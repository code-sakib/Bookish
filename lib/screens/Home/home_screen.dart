import 'dart:async';

import 'package:firebase_1/main.dart';
import 'package:firebase_1/screens/Home/Utilis/category_pressed.dart';
import 'package:firebase_1/screens/Home/model/categories_builder.dart';
import 'package:firebase_1/screens/book/book_screen.dart';
import 'package:firebase_1/screens/cart.dart';
import 'package:firebase_1/services/bottom_appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_1/models/books.dart';
import 'package:firebase_1/screens/Home/view/headline.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const CartScreen()))),
        child: const Icon(Icons.shopping_cart_checkout_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  appBar() {
    return AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          Expanded(
            child: Card(
              elevation: 1,
              child: ListTile(
                onTap: () => showSearch(
                  context: context,
                  delegate: MySearchDelegate(),
                ),
                title: const Text('Search'),
                leading: const Icon(
                  (Icons.search_rounded),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => const MainPage())));
            },
            icon: const Icon(Icons.logout),
          )
        ]);
  }

  body() {
    List<Books> bookObjs = [
      Books.all(),
      Books.biography(),
      Books.fiction(),
      Books.nonFiction(),
      Books.novel(),
      Books.selfHelp()
    ];
    final StreamController<Object> controller = StreamController();
    Books categoryToBeDisplayed = Books.all();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              headLine(context),
              //2 This will deal with whole book categories section
              const SizedBox(
                height: 15,
              ),
              //3
              StreamBuilder<Object>(
                  stream: controller.stream,
                  builder: (context, snapshot) {
                    return Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //1 To show categories
                          SizedBox(
                            height: 35,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: bookObjs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: OutlinedButton(
                                        onPressed: () {
                                          //Here simplifying things
                                          changingButtonColor(bookObjs, index);

                                          categoryToBeDisplayed =
                                              displayCategory(bookObjs,
                                                  categoryToBeDisplayed);

                                          controller.add(Object());
                                        },
                                        style: bookObjs[index].isActive
                                            ? ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary),
                                              )
                                            : null,
                                        child: Text(bookObjs[index].category)),
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          //2 To display book section
                          SizedBox(
                            height: 230,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryToBeDisplayed.numberOfBooks,
                                itemBuilder: ((context, index) =>
                                    categoryBuilder(categoryToBeDisplayed,
                                        index, context))),
                          ),
                        ],
                      ),
                    );
                  }),

              // 4
              nonFictionCategoryBuilder(context),
              // 5
              selfHelpCategoryBuilder(context),
              //6
              fictionCategoryBuilder(context),
              //7
              novelCategoryBuilder(context),
              //8
              biographyCategoryBuilder(context)
            ]),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  static List<Books> bookObjs = [
    Books.all(),
    Books.biography(),
    Books.fiction(),
    Books.nonFiction(),
    Books.novel(),
    Books.selfHelp()
  ];

  List<String> searchResults = [];
  List<int> indexesOf = [];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            onPressed: (() {
              query = '';
            }),
            icon: const Icon(Icons.clear)),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: (() => close(context, null)),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    for (var objs in bookObjs) {
      for (var key in objs.bookNameWithAuthor.keys) {
        searchResults.contains(key) == false ? searchResults.add(key) : null;
        for (var image in objs.listOfImgUrls) {
          indexesOf.add(objs.listOfImgUrls.indexOf(image));
        }
      }
    }

    List listOfSuggestions = searchResults.where((name) {
      final result = name.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
        itemCount: listOfSuggestions.length,
        itemBuilder: ((context, index) {
          String suggestion = listOfSuggestions[index];

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: ((context) {
                try {
                  return navigateTo(listOfSuggestions[index]);
                } catch (e) {
                  return const Center(
                      child: Text(
                    'Sorry, unable to display book😥',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ));
                }
              })));
            },
          );
        }));
  }

  navigateTo(String query) {
    for (var objs in bookObjs) {
      int i = 0;
      if (objs.category == 'All') {
        for (var bookName in objs.bookNameWithAuthor.keys) {
          if (bookName == query) {
            return Book(categoryToBeDisplayed: objs, index: i);
          } else {
            i += 1;
          }
        }
      }
      if (objs.category == 'Biography') {
        for (var bookName in objs.bookNameWithAuthor.keys) {
          if (bookName == query) {
            return Book(categoryToBeDisplayed: objs, index: i);
          } else {
            i += 1;
          }
        }
      }
      if (objs.category == 'Fiction') {
        for (var bookName in objs.bookNameWithAuthor.keys) {
          if (bookName == query) {
            return Book(categoryToBeDisplayed: objs, index: i);
          } else {
            i += 1;
          }
        }
      }
      if (objs.category == 'Non Fiction') {
        for (var bookName in objs.bookNameWithAuthor.keys) {
          if (bookName == query) {
            return Book(categoryToBeDisplayed: objs, index: i);
          } else {
            i += 1;
          }
        }
      }
      if (objs.category == 'Novel') {
        print('reached');
        for (var bookName in objs.bookNameWithAuthor.keys) {
          if (bookName == query) {
            return Book(categoryToBeDisplayed: objs, index: i);
          } else {
            i += 1;
          }
        }
      }
      if (objs.category == 'Self Help') {
        for (var bookName in objs.bookNameWithAuthor.keys) {
          if (bookName == query) {
            return Book(categoryToBeDisplayed: objs, index: i);
          } else {
            i += 1;
          }
        }
      }
    }
  }
}
