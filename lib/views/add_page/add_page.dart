import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:social_media_app/utils/constants/colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  PlatformFile? pickedFile;
  // this is to pick file from gallery
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  // upload file to firebase storage
  Future<void> uploadDoc() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    // set reference for the file
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

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
            IconButton(
                onPressed: uploadDoc,
                icon: const Icon(Icons.upload_file))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            selectFile();
          },
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (pickedFile != null)
                Expanded(
                  child: Container(
                    color: AppColors.fillColor,
                    child: Image.file(
                      File(pickedFile!.path!),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        )

        //  GridView.builder(
        //     itemCount: _images.length + 1,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3),
        //     itemBuilder: (context, index) {
        //       return index == 0
        //           ? Center(
        //               child: Container(
        //               decoration: BoxDecoration(color: Colors.grey[100]),
        //               child: IconButton(
        //                   onPressed: selectFile, icon: const Icon(Icons.add)),
        //             ))
        //           : Container(
        //               decoration: BoxDecoration(
        //                   image: DecorationImage(
        //                       image: FileImage(
        //                         _images[index - 1],
        //                       ),
        //                       fit: BoxFit.cover)),
        //             );
        //     }),
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

  // upload images to firebase storage
  Future uploadFile() async {
    for (var img in _images) {
      ref = firebase_storage.FirebaseStorage.instance.ref().child('');
    }
  }
}
