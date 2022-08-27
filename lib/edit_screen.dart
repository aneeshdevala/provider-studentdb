import 'dart:convert';
import 'dart:io';

import 'package:database/provider/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'db/functions/db_functions.dart';
import 'db/models/data_model.dart';
import 'home_screen.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditPage extends StatelessWidget {
  StudentModel data;
  int? index;
  EditPage({Key? key, required this.data, required this.index})
      : super(key: key);

  final formkey = GlobalKey<FormState>();

  final _name = TextEditingController();

  final _age = TextEditingController();

  final _domain = TextEditingController();

  final _phone = TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imageToString = '';
  @override
  Widget build(BuildContext context) {
    _name.text = data.name.toString();
    _age.text = data.age.toString();
    _domain.text = data.domain.toString();
    _phone.text = data.phone.toString();
    imageToString = data.image;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit student'),
      ),
      body: Form(
          child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<EditProvider>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () {
                    pickImage(context);
                  },
                  child: imageProfile(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invald Username';
                } else {
                  return null;
                }
              },
              controller: _name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid age';
                } else {
                  return null;
                }
              },
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid domain';
                } else {
                  return null;
                }
              },
              controller: _domain,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Domain'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid Phone';
                } else {
                  return null;
                }
              },
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  checkValidation(context);
                  formkey.currentState?.validate();
                },
                child: const Text('Update')),
          )
        ],
      )),
    );
  }

  pickImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      imageToString = base64Encode(imageTemporary);
      Provider.of<EditProvider>(context, listen: false)
          .changeImage(imageToString);
    }
  }

  checkValidation(context) async {
    final name = _name.text.trim();
    final age = _age.text.trim();
    final domain = _domain.text.trim();
    final phone = _phone.text.trim();
    final student = StudentModel(
        age: age,
        name: name,
        domain: domain,
        phone: phone,
        image: imageToString);

    if (name.isEmpty || age.isEmpty || domain.isEmpty || phone.isEmpty) {
      return;
    } else {
      DbFunction.updateDetails(data: student, index: index);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      DbFunction.getAllStudents(context);
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage:
                MemoryImage(const Base64Decoder().convert(imageToString)),
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: Icon(
              Icons.edit,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
