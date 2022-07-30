import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomFilePicker {
  Future<File?> pickOneImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      return File(result.files.first.path!);
    }
  }
}
