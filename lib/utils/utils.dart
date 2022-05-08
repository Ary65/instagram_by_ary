import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No image selected');
}

//? Snackbar
showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // elevation: 1000,
      // behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      backgroundColor: Colors.purple,
      content: Text(content),
      duration: const Duration(seconds: 2),
    ),
  );
}
