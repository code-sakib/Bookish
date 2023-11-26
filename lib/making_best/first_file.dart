import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/books.dart';

FirebaseFirestore firebaseObj = FirebaseFirestore.instance;

pushingThings() {
  Books currentBooksObj = Books.fiction();
  int currentIteration = 0;

  currentBooksObj.bookNameWithAuthor.forEach((key, value) {
    String bookName = key;
    String bookAuthor = value;
    String bookImage = currentBooksObj.listOfImgUrls[currentIteration];
    String bookDescription =
        currentBooksObj.listOfDescriptions[currentIteration];

    Map<String, Object> pushingBook = {
      'name': bookName,
      'author': bookAuthor,
      'image': bookImage,
      'description': bookDescription,
    };

    firebaseObj
        .collection('booksCategories')
        .doc('fiction')
        .collection('collections')
        .add(pushingBook);

    currentIteration++;
  });
}
