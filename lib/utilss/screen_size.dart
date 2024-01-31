import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyScreenSize {
  Size getScreenSize() {
    // ignore: deprecated_member_use
    return MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  }

  Future<Uint8List?> pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
  }
}
