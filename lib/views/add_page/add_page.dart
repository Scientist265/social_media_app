import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // image storage
  final List<File> _images = [];
  final ImagePicker picker = ImagePicker();

  // create reference for the storage
  CollectionReference? imgRef;
  firebase_storage.Reference? ref;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Upload Picture')),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.upload_file))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: GridView.builder(
          itemCount: _images.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            return index == 0
                ? Center(
                    child: Container(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: IconButton(
                        onPressed: chooseImage, icon: const Icon(Icons.add)),
                  ))
                : Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(
                              _images[index - 1],
                            ),
                            fit: BoxFit.cover)),
                  );
          }),
    );
  }

  void chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) getLostData();
  }

  Future<void> getLostData() async {
    final ImagePicker picker = ImagePicker();
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _images.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    for (var img in _images) {
      ref = firebase_storage.FirebaseStorage.instance.ref().child('');
    }
  }
}
