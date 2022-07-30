import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_firebase/core/constants/constants.dart';
import 'package:flutter_blog_firebase/core/firestore_crud_operations.dart';
import 'package:flutter_blog_firebase/features/auth/data/exceptions.dart';
import 'package:flutter_blog_firebase/features/auth/data/repositories/user_remote_data_model.dart';

class UsersRemoteDataSource
    extends FirestoreCrudOperations<UserRemoteDataModel> {
  final FirebaseAuth firebaseAuth;
// firebase authentication
  UsersRemoteDataSource(this.firebaseAuth)
      : super('users', UserRemoteDataModel.fromFirestoreDocument);

  User getLoggedUser() {
    final user = firebaseAuth.currentUser;
    return user!;
  }

  // register
  Future<User?> register(String name, String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user!;
      const defaultAvatar = Constants.defaultAvatar;
      await Future.wait([
        user.updateDisplayName(name),
        user.updatePhotoURL(defaultAvatar),
        super.add(UserRemoteDataModel(
            id: user.uid,
            email: email,
            name: name,
            profilePicture: Constants.defaultAvatar))
      ]);

      return result.user!;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw EmailAlreadyInUseException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'weak-password':
          throw WeakPasswordException();
      }
      throw e;
    }

    return null;
  }

  Future<User?> login(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(result);
      return result.user!;
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case 'too-many-requests':
          throw TooManyRequestException();

        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'invalid-email':
          throw InvalidEmailException();
        case 'user-disabled':
          throw UserDisabledException();
      }
    }

    return null;
  }
}
