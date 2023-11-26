import 'package:flutter/material.dart';

import '../models/books.dart';

List listOfOrderedBookImage = [];
List listOfOrderedBookNames = [];
List listOfOrderedBookNamesAuthor = [];
List<int> listOfPrices = [];
List<int> listOfQuantities = [];

class CartProvider extends ChangeNotifier {
  addItems(
      Books categoryToBeDisplayed, int index, int totalPrice, int quantity) {
    listOfOrderedBookImage.add(categoryToBeDisplayed.listOfImgUrls[index]);
    listOfOrderedBookNames
        .add(categoryToBeDisplayed.bookNameWithAuthor.keys.elementAt(index));
    listOfOrderedBookNamesAuthor
        .add(categoryToBeDisplayed.bookNameWithAuthor.values.elementAt(index));

    listOfPrices.add(totalPrice);
    listOfQuantities.add(quantity);

    notifyListeners();
  }
}
