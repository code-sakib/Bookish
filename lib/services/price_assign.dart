import 'package:firebase_1/models/books.dart';

int priceAssinging() {
  final listOfPrices = <int>[
    150,
    130,
    230,
    170,
    99,
    210,
    195,
    150,
    160,
    130,
    180,
    220,
    160,
    105,
    140,
    205,
    185,
  ]..shuffle();

  return listOfPrices[1];
}

assingPricesForAll() {
  final listOfPricesForAll = <int>[
    150,
    130,
    230,
    170,
    99,
    210,
    195,
    150,
    160,
    130,
    180,
    220,
    160,
    105,
    140,
    205,
    185,
  ];
  List<int> prices = List.generate(Books.all().bookNameWithAuthor.length,
      (index) => listOfPricesForAll[index % listOfPricesForAll.length]);

  return prices;
}

assignPricesForFiction() {
  final listOfPricesForFiction = <int>[
    150,
    130,
    230,
    170,
    99,
    210,
    195,
    150,
    160,
    130,
    180,
    220,
    160,
    105,
    140,
    205,
    185,
  ];
  List<int> prices = List.generate(Books.fiction().bookNameWithAuthor.length,
      (index) => listOfPricesForFiction[index % listOfPricesForFiction.length]);

  return prices;
}

assignPricesForNonFiction() {
  final listOfPricesForNonFiction = <int>[
    185,
    195,
    220,
    160,
    205,
    130,
    180,
    130,
    170,
    230,
    150,
    150,
    160,
    140,
    99,
    210,
    105
  ];
  List<int> prices = List.generate(
      Books.nonFiction().bookNameWithAuthor.length,
      (index) =>
          listOfPricesForNonFiction[index % listOfPricesForNonFiction.length]);

  return prices;
}

assignPricesForSelfhelp() {
  final listOfPricesForSelfhelp = <int>[
    130,
    185,
    210,
    150,
    160,
    195,
    99,
    130,
    220,
    170,
    180,
    205,
    105,
    140,
    150,
    230,
    160
  ];
  List<int> prices = List.generate(
      Books.selfHelp().bookNameWithAuthor.length,
      (index) =>
          listOfPricesForSelfhelp[index % listOfPricesForSelfhelp.length]);

  return prices;
}

assignPricesForNovel() {
  final listOfPricesForNovel = <int>[
    170,
    150,
    99,
    205,
    160,
    130,
    185,
    210,
    160,
    230,
    220,
    195,
    130,
    140,
    150,
    180,
    105
  ];
  List<int> prices = List.generate(Books.all().bookNameWithAuthor.length,
      (index) => listOfPricesForNovel[index % listOfPricesForNovel.length]);

  return prices;
}

assignPricesForbiography() {
  final listOfPricesForbiography = <int>[
    99,
    205,
    180,
    150,
    170,
    210,
    230,
    195,
    220,
    185,
    160,
    105,
    140,
    150,
    130,
    160,
    130
  ];
  List<int> prices = List.generate(
      Books.all().bookNameWithAuthor.length,
      (index) =>
          listOfPricesForbiography[index % listOfPricesForbiography.length]);

  return prices;
}

List<int> assigningPricesWRTCategory(Books categoryToBeDisplayed) {
  if (categoryToBeDisplayed.category == 'Self Help') {
    return assignPricesForSelfhelp();
  } else if (categoryToBeDisplayed.category == 'Biography') {
    return assignPricesForbiography();
  } else if (categoryToBeDisplayed.category == 'Novel') {
    return assignPricesForNovel();
  } else if (categoryToBeDisplayed.category == 'Non Fiction') {
    return assignPricesForNonFiction();
  } else if (categoryToBeDisplayed.category == 'Fiction') {
    return assignPricesForFiction();
  } else {
    return assingPricesForAll();
  }
}
