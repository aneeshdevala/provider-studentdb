import 'dart:convert';
import 'dart:io';

import 'package:database/provider/edit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'db/functions/db_functions.dart';
import 'db/models/data_model.dart';
import 'home_screen.dart';

class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);

  final formkey = GlobalKey<FormState>();

  final _username = TextEditingController();

  final _age = TextEditingController();

  final _domain = TextEditingController();

  final _phone = TextEditingController();

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add student'),
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<EditProvider>(
                  builder: (context, value, child) => GestureDetector(
                    onTap: (() {
                      pickImage(context);
                    }),
                    child: value.image == ''
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(value.image),
                          )
                        : imageProfile(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid Username';
                    } else {
                      return null;
                    }
                  },
                  controller: _username,
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
                      if (formkey.currentState!.validate()) {
                        checkValidation(context);
                      }

                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HomeScreen()));
                    },
                    child: const Text('Submit')),
              )
            ],
          )),
    );
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
          )
        ],
      ),
    );
  }

  // String _image = '';
  String imageToString = '';

  pickImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      imageToString = base64Encode(imageTemporary);
      Provider.of<EditProvider>(context, listen: false)
          .changeImage(imageToString);

      //   setState(() {
      //     imageToString = base64Encode(imageTemporary);
      //     _image = imageToString;
      //   });
    }
  }

  checkValidation(context) {
    final name = _username.text.trim();
    final age = _age.text.trim();
    final domain = _domain.text.trim();
    final phone = _phone.text.trim();

    final student = StudentModel(
        age: age,
        name: name,
        domain: domain,
        phone: phone,
        image: imageToString);

    if (name.isEmpty ||
        age.isEmpty ||
        domain.isEmpty ||
        phone.isEmpty ||
        imageToString.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
          content: Text('Please Pick an image')));
    } else {
      // print('$name $age $domain $phone');
      DbFunction.addStudent(context, student);

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    }
  }
}
