import 'package:flutter/material.dart';

import 'package:database/provider/database_pro.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../models/data_model.dart';

class DbFunction {
  static Future<void> addStudent(context, StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.add(value);
    getAllStudents(context);
  }

  static Future<void> getAllStudents(BuildContext context) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    Provider.of<DatabasePro>(context, listen: false)
        .addAllstudent(data: studentDB.values);
  }

  static Future<void> deleteStudent(context, int index) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(index);
    await getAllStudents(context);
  }

  static Future<void> updateDetails(
      {context, required data, required index}) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.putAt(index, data);
    getAllStudents(context);
  }
}
