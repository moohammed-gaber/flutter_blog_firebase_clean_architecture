import 'package:flutter_blog_firebase/core/firestore_crud_operations.dart';

class PostRemoteDataModel extends FirestoreDocumentModel {
  final String description, imageUrl;
  final List<String> userLikeIds;
  final String uploaderID;

  PostRemoteDataModel(
      {required this.description,
      required this.imageUrl,
      required this.userLikeIds,
      required this.uploaderID,
      required String id})
      : super(id);
  PostRemoteDataModel.fromFirestoreDocument(super.doc)
      : description = doc['description'],
        imageUrl = doc['image_url'],
        userLikeIds = (doc['user_like_ids'] as List).cast<String>(),
        uploaderID = doc['uploader'],
        super.fromFirestoreDocument();

  @override
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'image_url': imageUrl,
      'user_like_ids': userLikeIds,
      'uploader': uploaderID,
    };
  }

  // copy with
  PostRemoteDataModel copyWith({
    String? id,
    String? description,
    String? imageUrl,
    List<String>? userLikeIds,
    String? uploader,
  }) {
    return PostRemoteDataModel(
      id: id ?? this.id,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      userLikeIds: userLikeIds ?? this.userLikeIds,
      uploaderID: uploader ?? this.uploaderID,
    );
  }

/*
  PostDataModel(this.description, this.imageUrl, this.likesCount,
      this.userLikeIds, this.uploader);
*/
}
