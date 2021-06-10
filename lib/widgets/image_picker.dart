import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;
  final picker = ImagePicker();

  void _pickImage() async {
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedImageFile != null) {
      setState(() {
        _image = File(pickedImageFile.path);
      });
      widget.imagePickFn(_image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundColor: Colors.grey,
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        TextButton.icon(
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  TextStyle(color: Theme.of(context).primaryColor))),
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Pick a photo'),
        )
      ],
    );
  }
}
