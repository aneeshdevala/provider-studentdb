import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditProvider with ChangeNotifier {
  String image = 'assets/person.jpg';
  void changeImage(String image) {
    image = image;
    notifyListeners();
  }
}
