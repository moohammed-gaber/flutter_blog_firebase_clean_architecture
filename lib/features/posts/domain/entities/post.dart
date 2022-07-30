import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog_firebase/core/domain/entities/user_entity.dart';

class Post extends Equatable {
  final String description, imageUrl;
  final int likesCount;
  final String id;
  final bool isBookmarked;
  final UserEntity uploader;
  List<String> userLikeIds;

  bool get isLiked =>
      userLikeIds.contains(FirebaseAuth.instance.currentUser!.uid);

  Post(
      {required this.description,
      required this.imageUrl,
      required this.uploader,
      this.isBookmarked = false,
      required this.userLikeIds,
      required this.id,
      required this.likesCount});

  // copy with
  Post copyWith({
    String? id,
    String? description,
    String? imageUrl,
    int? likesCount,
    List<String>? userLikeIds,
    bool? isBookmarked,
    UserEntity? loggedUser,
  }) {
    return Post(
      uploader: loggedUser ?? this.uploader,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      id: id ?? this.id,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      likesCount: likesCount ?? this.likesCount,
      userLikeIds: userLikeIds ?? this.userLikeIds,

      // isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        description,
        imageUrl,
        likesCount,
        id,
        userLikeIds,
        // isLiked,
      ];
// equality
}
