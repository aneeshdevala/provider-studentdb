import 'dart:convert';
import 'package:database/provider/edit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db/models/data_model.dart';
import 'edit_screen.dart';

// ignore: must_be_immutable
class ViewScreen extends StatelessWidget {
  StudentModel data;
  int? index;

  final _name = TextEditingController();
  final _age = TextEditingController();
  final _domain = TextEditingController();
  final _phone = TextEditingController();
  ViewScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    _name.text = data.name.toString();
    _age.text = data.age.toString();
    _domain.text = data.domain.toString();
    _phone.text = data.phone.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('View'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<EditProvider>(context, listen: false).image =
                    data.image;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                              data: data,
                              index: index,
                            )));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                backgroundImage:
                    MemoryImage(const Base64Decoder().convert(data.image)),
                radius: 50,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _name,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _age,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _domain,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phone,
              readOnly: true,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ],
      ),
    );
  }
}
