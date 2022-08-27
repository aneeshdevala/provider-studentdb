import 'package:database/db/models/data_model.dart';
import 'package:flutter/widgets.dart';

class DatabasePro with ChangeNotifier {
  List<StudentModel> studentList = [];
  void addAllstudent({required data}) {
    studentList.clear();
    studentList.addAll(data);
    notifyListeners();
  }
}
