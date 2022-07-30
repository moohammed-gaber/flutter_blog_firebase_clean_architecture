import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';
import 'package:flutter_blog_firebase/features/posts/data/remote/models/post_remote_data_model.dart';
import 'package:flutter_blog_firebase/features/posts/domain/entities/post.dart';

class RemoteDomainMapper {
/*
  List<Post> mapFromRemote(List<Map> remoteData) {
    return remoteData.map((e) => Post.fromJson(e)).toList();
  }
*/
/*
  static List<Post> toDomainList(List<PostRemoteDataModel> remoteData) {
    return remoteData.map((e) => toDomain(e)).toList();
  }
*/

// to domain
  static Post toDomain(PostRemoteDataModel remoteData, UserEntity uploader) {
    return Post(
        userLikeIds: remoteData.userLikeIds,
        uploader: uploader,
        id: remoteData.id,
        description: remoteData.description,
        imageUrl: remoteData.imageUrl,
        likesCount: 0);
  }

  static PostRemoteDataModel toPostRemoteDataModel(Post post) {
    return PostRemoteDataModel(
      userLikeIds: [],
      id: post.id,
      uploaderID: '',
      description: post.description,
      imageUrl: post.imageUrl,
    );
  }
}
