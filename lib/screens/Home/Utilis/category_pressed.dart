import 'package:firebase_1/models/books.dart';
//To change color when pressed

changingButtonColor(List<Books> bookObjs, int index) {
  List<bool> currentBk =
      List.generate(bookObjs.length, (index) => bookObjs[index].isActive);

  if (currentBk[index] == true) {
    currentBk[index] = false;
  } else {
    for (var element in bookObjs) {
      element.isActive = false;
    }
    currentBk[index] = true;
  }

  bookObjs[index].isActive = currentBk[index];
}

//category to be shown
Books displayCategory(List<Books> bookObjs, Books? categoryToBeDisplayed) {
  for (var element in bookObjs) {
    if (element.isActive) {
      categoryToBeDisplayed = element;
      break;
    } else {
      categoryToBeDisplayed = Books.all();
    }
  }

  return categoryToBeDisplayed!;
}
