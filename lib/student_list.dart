import 'dart:convert';
import 'dart:ui';

import 'package:database/provider/database_pro.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'db/functions/db_functions.dart';

import 'view_screen.dart';

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabasePro>(builder: (context, value, child) {
      return value.studentList.isEmpty
          ? const Center(
              child: Text(
                'No students List Found',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final data = value.studentList[index];
                return ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      // if (data.id != null) {
                      //   deleteStudent(index);
                      // }
                      DbFunction.deleteStudent(context, index);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewScreen(data: data, index: index)));
                  },
                  leading: CircleAvatar(
                      backgroundImage: MemoryImage(
                          const Base64Decoder().convert(data.image)),
                      radius: 30),
                  title: Text(data.name),
                  subtitle: Text(data.age),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: value.studentList.length);
    });
  }
}
