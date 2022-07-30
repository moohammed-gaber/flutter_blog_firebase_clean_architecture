import 'package:flutter_blog_firebase/core/constants/sqflite_constants.dart';
import 'package:flutter_blog_firebase/core/sqflite.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';

class PostLocalDataModel extends SqfLiteLocalDataModel {
  final String description, imageUrl;

  PostLocalDataModel(
      {required this.description, required this.imageUrl, required String id})
      : super(id);

  PostLocalDataModel.fromMap(Map map)
      : description = map[SqfLiteConstants.descriptionColumn],
        imageUrl = map[SqfLiteConstants.imageUrlColumn],
        super.fromMap(map);

  @override
  Map<String, dynamic> toMap() {
    return {
      SqfLiteConstants.descriptionColumn: description,
      SqfLiteConstants.imageUrlColumn: imageUrl,
      ...super.toMap()
    };
  }
/*
  Post toDomain() {
    return Post(
      id: '',
      userLikeIds: [],
      likesCount: 0,
      description: description,
      imageUrl: imageUrl,
    );
  }*/
}
