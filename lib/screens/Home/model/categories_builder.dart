import 'package:firebase_1/Themeing/themeing.dart';
import 'package:firebase_1/models/books.dart';
import 'package:firebase_1/screens/Home/home_screen.dart';
import 'package:firebase_1/screens/book/book_screen.dart';
import 'package:firebase_1/services/getting_imgs.dart';
import 'package:firebase_1/services/price_assign.dart';
import 'package:flutter/material.dart';

categoryBuilder(Books categoryToBeDisplayed, int index, BuildContext context) =>
    SizedBox(
      height: 220,
      width: 155,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => Book(
                  categoryToBeDisplayed: categoryToBeDisplayed,
                  index: index)))),
          splashColor: const Color(0xFFD1C4E9),
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                top: 15,
                child: Container(
                  height: 200,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 5,
                      alignment: WrapAlignment.end,
                      direction: Axis.vertical,
                      children: [
                        Text(
                          categoryToBeDisplayed.bookNameWithAuthor.keys
                              .elementAt(index),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          categoryToBeDisplayed.bookNameWithAuthor.values
                              .elementAt(index),
                        ),
                        Text(
                          'Rs.${assigningPricesWRTCategory(categoryToBeDisplayed)[index]}',
                          style: TextStyle(
                              color: gettingColorsForPrice(),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: -5,
                  right: 20,
                  child: Container(
                      height: 140,
                      width: 90,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(138, 255, 254, 254),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(231, 80, 79, 79),
                                offset: Offset(-4, 4),
                                blurRadius: 4)
                          ]),
                      child: displayImage(
                          context, categoryToBeDisplayed.listOfImgUrls[index])))
            ],
          ),
        ),
      ),
    );

novelCategoryBuilder(BuildContext context, [toShowMore = false]) {
  Widget forMore = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      const Text('More',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
          icon: const Icon(Icons.home_rounded)),
    ],
  );

  Books categoryToBeDisplayed = Books.novel();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //1
      const Divider(
        thickness: 1,
        height: 10,
        indent: 40,
        endIndent: 50,
      ),
      const SizedBox(
        height: 5,
      ),
      //2
      toShowMore
          ? forMore
          : Text(
              'Novels',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
      const SizedBox(
        height: 10,
      ),
      //3
      SizedBox(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryToBeDisplayed.numberOfBooks,
            itemBuilder: ((context, index) =>
                categoryBuilder(categoryToBeDisplayed, index, context))),
      ),
    ],
  );
}

biographyCategoryBuilder(BuildContext context, [toShowMore = false]) {
  Widget forMore = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      const Text('More',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
          icon: const Icon(Icons.home_rounded)),
    ],
  );

  Books categoryToBeDisplayed = Books.biography();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //1
      const Divider(
        thickness: 1,
        height: 10,
        indent: 40,
        endIndent: 50,
      ),
      const SizedBox(
        height: 5,
      ),
      //2
      toShowMore
          ? forMore
          : Text(
              'Biographies',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
      const SizedBox(
        height: 10,
      ),
      //3
      SizedBox(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryToBeDisplayed.numberOfBooks,
            itemBuilder: ((context, index) =>
                categoryBuilder(categoryToBeDisplayed, index, context))),
      ),
    ],
  );
}

fictionCategoryBuilder(BuildContext context, [toShowMore = false]) {
  Widget forMore = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      const Text('More',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
          icon: const Icon(Icons.home_rounded)),
    ],
  );

  Books categoryToBeDisplayed = Books.fiction();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //1
      const Divider(
        thickness: 1,
        height: 10,
        indent: 40,
        endIndent: 50,
      ),
      const SizedBox(
        height: 5,
      ),
      //2
      toShowMore
          ? forMore
          : Text(
              'Fictional books',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
      const SizedBox(
        height: 10,
      ),
      //3
      SizedBox(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryToBeDisplayed.numberOfBooks,
            itemBuilder: ((context, index) =>
                categoryBuilder(categoryToBeDisplayed, index, context))),
      ),
    ],
  );
}

nonFictionCategoryBuilder(BuildContext context, [toShowMore = false]) {
  Widget forMore = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      const Text('More',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
          icon: const Icon(Icons.home_rounded)),
    ],
  );

  Books categoryToBeDisplayed = Books.nonFiction();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //1
      const Divider(
        thickness: 1,
        height: 10,
        indent: 40,
        endIndent: 50,
      ),
      const SizedBox(
        height: 5,
      ),
      //2
      toShowMore
          ? forMore
          : Text(
              'Non-Fictional books',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
      const SizedBox(
        height: 10,
      ),
      //3
      SizedBox(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryToBeDisplayed.numberOfBooks,
            itemBuilder: ((context, index) =>
                categoryBuilder(categoryToBeDisplayed, index, context))),
      ),
    ],
  );
}

selfHelpCategoryBuilder(BuildContext context, [bool toShowMore = false]) {
  Widget forMore = Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      const Text('More',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
      IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => const HomeScreen())));
          },
          icon: const Icon(Icons.home_rounded)),
    ],
  );

  Books categoryToBeDisplayed = Books.selfHelp();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //1
      const Divider(
        thickness: 1,
        height: 10,
        indent: 40,
        endIndent: 50,
      ),
      const SizedBox(
        height: 5,
      ),
      //2
      toShowMore
          ? forMore
          : Text(
              'Self-Help books',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
      const SizedBox(
        height: 10,
      ),
      //3
      SizedBox(
        height: 230,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryToBeDisplayed.numberOfBooks,
            itemBuilder: ((context, index) =>
                categoryBuilder(categoryToBeDisplayed, index, context))),
      ),
    ],
  );
}

gettingColorsForPrice() {
  if (currentTheme == const Color(0xFFC4E4E9)) {
    return const Color(0xFF7FA5AB);
  } else if (currentTheme == const Color(0xFFAEE6A6)) {
    return const Color(0xFF66bb6a);
  } else if (currentTheme == const Color(0xFF464846)) {
    return const Color(0xFFb0bec5);
  } else if (currentTheme == const Color(0XFFf48fb1)) {
    return const Color(0xFFec407a);
  } else {
    return const Color(0xFF9575cd);
  }
}
