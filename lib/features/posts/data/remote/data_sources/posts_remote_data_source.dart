import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_firebase/core/constants/firestore_constants.dart';
import 'package:flutter_blog_firebase/core/firestore_crud_operations.dart';
import 'package:flutter_blog_firebase/features/posts/data/remote/models/post_remote_data_model.dart';

class PostsRemoteDataSource
    extends FirestoreCrudOperations<PostRemoteDataModel> {
  final FirebaseAuth firebaseAuth;

  PostsRemoteDataSource(this.firebaseAuth)
      : super('posts',
            (snapshot) => PostRemoteDataModel.fromFirestoreDocument(snapshot));

  Future likePost(PostRemoteDataModel newPost) {
    return collection.doc(newPost.id).update({
      FireStoreConstants.userLikeIds:
          FieldValue.arrayUnion([firebaseAuth.currentUser!.uid])
    });
  }

  Future unLikePost(PostRemoteDataModel newPost) {
    return collection.doc(newPost.id).update({
      FireStoreConstants.userLikeIds:
          FieldValue.arrayRemove([firebaseAuth.currentUser!.uid])
    });
  }
}
