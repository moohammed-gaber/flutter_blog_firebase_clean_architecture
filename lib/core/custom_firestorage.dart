import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

typedef Url = String;

class CustomFireStorage {
  final FirebaseStorage firebaseStorage;

  CustomFireStorage(this.firebaseStorage);

  Future<Url> upload(File file) async {
    final result =
        await firebaseStorage.ref('posts').child(Uuid().v4()).putFile(file);
    return result.ref.getDownloadURL();
  }
}
