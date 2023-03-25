import 'package:firebase_1/authenticate/authenticating.dart';
import 'package:firebase_1/models/books.dart';
import 'package:firebase_1/screens/Home/model/categories_builder.dart';
import 'package:firebase_1/screens/cart.dart';
import 'package:firebase_1/services/bottom_appbar.dart';
import 'package:firebase_1/services/price_assign.dart';
import 'package:firebase_1/stateManagment/cart_provider.dart';
import 'package:flutter/material.dart';

class Book extends StatefulWidget {
  const Book(
      {super.key, required this.categoryToBeDisplayed, required this.index});

  final Books categoryToBeDisplayed;
  final int index;

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //1
          sliverAppbar(),
          //2
          sliverMainPage(),
        ],
      ),
      bottomNavigationBar: bottomAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: ((context) => const CartScreen()))),
        child: const Icon(Icons.shopping_cart_checkout_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  sliverAppbar() {
    return SliverAppBar(
      backgroundColor: Colors.white38,
      stretch: true,
      floating: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                  Theme.of(context).colorScheme.primary,
                  Colors.white
                ])),
            child: Center(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(widget
                      .categoryToBeDisplayed.listOfImgUrls[widget.index])),
            )),
      ),
    );
  }

  sliverMainPage() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(((context, index) {
        return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                //1
                Text(
                    widget.categoryToBeDisplayed.bookNameWithAuthor.keys
                        .elementAt(widget.index),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25)),
                //2
                Text(
                    widget.categoryToBeDisplayed.bookNameWithAuthor.values
                        .elementAt(widget.index),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 15)),

                const SizedBox(
                  height: 10,
                ),
                //3
                Text(
                    'Rs.${assigningPricesWRTCategory(widget.categoryToBeDisplayed)[widget.index]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: gettingColorsForPrice())),
                const SizedBox(
                  height: 10,
                ),

                //4
                ShoppingTab(
                    price: assigningPricesWRTCategory(
                        widget.categoryToBeDisplayed)[widget.index],
                    categoryToBeDisplayed: widget.categoryToBeDisplayed,
                    index: widget.index),

                //5
                BuildingDescription(
                  categoryToBeDisplayed: widget.categoryToBeDisplayed,
                  index: widget.index,
                ),

                //6
                aboutQuality(),

                //7
                BuildingMore(
                  categoryToBeDisplayed: widget.categoryToBeDisplayed,
                )
              ],
            ));
      }), childCount: 1),
    );
  }
}

class BuildingDescription extends StatefulWidget {
  const BuildingDescription(
      {super.key, required this.categoryToBeDisplayed, required this.index});

  final int index;
  final Books categoryToBeDisplayed;

  @override
  State<BuildingDescription> createState() => _BuildingDescriptionState();
}

class _BuildingDescriptionState extends State<BuildingDescription> {
  String formattedDescription = '';
  bool toShowMore = false;
  @override
  Widget build(BuildContext context) {
    String description =
        widget.categoryToBeDisplayed.listOfDescriptions[widget.index];
    return Wrap(
      runSpacing: 10,
      children: [
        const Divider(
          thickness: 1,
          height: 20,
          indent: 40,
          endIndent: 50,
        ),
        const Text(
          'Description',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Column(
          children: [
            Text(formattingDescription(description)),
            description.length > 500
                ? !toShowMore
                    ? moreButton()
                    : lessButton()
                : const Text('')
          ],
        ),
      ],
    );
  }

  String formattingDescription(String description) {
    if (description.length > 500 && !toShowMore) {
      return formattedDescription =
          " ${description.replaceRange(500, description.length, '')}";
    } else {
      return formattedDescription = " $description";
    }
  }

  moreButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            toShowMore = true;
          });
        },
        child: const Text(
          'more',
          style: TextStyle(color: Colors.blue),
        ));
  }

  lessButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            toShowMore = false;
          });
        },
        child: const Text(
          'less',
          style: TextStyle(color: Colors.blue),
        ));
  }
}

class ShoppingTab extends StatefulWidget {
  const ShoppingTab(
      {super.key,
      required this.price,
      required this.categoryToBeDisplayed,
      required this.index});
  final int price;
  final Books categoryToBeDisplayed;
  final int index;

  @override
  State<ShoppingTab> createState() => _ShoppingTabState();
}

class _ShoppingTabState extends State<ShoppingTab> {
  int quantity = 0;
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: const Color.fromARGB(255, 253, 167, 38)),
      child: Column(
        children: [
          //1
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              //1
              SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () => setState(() {
                            if (1 <= quantity && quantity <= 10) {
                              quantity -= 1;
                              totalPrice -= widget.price;
                            } else {
                              quantity;
                            }
                          }),
                      child: const Icon(
                        Icons.remove,
                        color: Color(0xFF000000),
                      ))),

              //2
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2)),
                child: Text(quantity.toString()),
              ),
              //3
              SizedBox(
                  width: 40,
                  child: TextButton(
                      onPressed: () => setState(() {
                            if (0 <= quantity && quantity < 10) {
                              quantity += 1;
                              totalPrice += widget.price;
                            } else {
                              quantity;
                              Utilis.showSnackBar('No more than 10. Sorry😕',
                                  color:
                                      const Color.fromARGB(255, 252, 193, 104));
                            }
                          }),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add,
                            color: Color(0xFF000000),
                          ),
                        ],
                      ))),
              //4
              const SizedBox(
                width: 140,
              ),
              Text(
                totalPrice.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          //2
          ElevatedButton.icon(
            onPressed: () {
              var cartProvider = CartProvider();

              return cartProvider.addItems(widget.categoryToBeDisplayed,
                  widget.index, totalPrice, quantity);
            },
            icon: const Icon(Icons.add_shopping_cart_rounded),
            label: const Text('Add to cart'),
            style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)))),
          ),
        ],
      ),
    );
  }
}

aboutQuality() {
  const String quality =
      "The book you'll get will of Original paper back as shown with a usefull bookmark attached in it, you can replace, exchange or give feedback about the product for your convenience. Thank You🤗";

  return Wrap(
    runSpacing: 10,
    children: const [
      Divider(
        thickness: 1,
        height: 20,
        indent: 40,
        endIndent: 50,
      ),
      Text(
        'About Quality',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      Text(quality)
    ],
  );
}

class BuildingMore extends StatelessWidget {
  const BuildingMore({super.key, required this.categoryToBeDisplayed});

  final Books categoryToBeDisplayed;

  whichMore(BuildContext context) {
    if (categoryToBeDisplayed.category == 'Self Help') {
      return selfHelpCategoryBuilder(context, true);
    } else if (categoryToBeDisplayed.category == 'Biography') {
      return biographyCategoryBuilder(context, true);
    } else if (categoryToBeDisplayed.category == 'Novel') {
      return novelCategoryBuilder(context, true);
    } else if (categoryToBeDisplayed.category == 'Non Fiction') {
      return nonFictionCategoryBuilder(context, true);
    } else if (categoryToBeDisplayed.category == 'Fiction') {
      return fictionCategoryBuilder(context, true);
    } else {
      return nonFictionCategoryBuilder(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        whichMore(context)
      ],
    );
  }
}
