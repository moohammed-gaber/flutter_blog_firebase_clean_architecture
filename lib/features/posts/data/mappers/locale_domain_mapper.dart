import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/features/posts/data/local/models/post_local_data_model.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';

class LocalDomainMapper {
  static List<Post> toDomainList(
      List<PostLocalDataModel> localData, UserEntity uploader) {
    return localData
        .map((e) => Post(
            uploader: uploader,
            userLikeIds: [],
            id: e.id,
            isBookmarked: true,
            description: e.description,
            imageUrl: e.imageUrl,
            likesCount: 0))
        .toList();
  }

  static PostLocalDataModel toLocalDataModel(Post post) {
    return PostLocalDataModel(
      description: post.description,
      imageUrl: post.imageUrl,
      id: post.id,
    );
  }

  static List<PostLocalDataModel> toLocalDataModelList(List<Post> localData) {
    return localData.map((e) => toLocalDataModel(e)).toList();
  }
}
