import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_blog_firebase/core/failures/failures.dart';
import 'package:flutter_blog_firebase/core/io/custom_file_picker.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';

class PickPostImageUseCase implements FutureUseCase<File?, NoParams> {
  final CustomFilePicker customFilePicker;

  PickPostImageUseCase(this.customFilePicker);

  @override
  Future<File?> call(params) {
    return customFilePicker.pickOneImage();
  }
}
