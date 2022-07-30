import 'package:flutter_blog_firebase/core/injection.dart';
import 'package:flutter_blog_firebase/core/io/custom_file_picker.dart';
import 'package:flutter_blog_firebase/core/use_case/use_case.dart';
import 'package:flutter_blog_firebase/features/posts/data/repositories/posts_repo.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/domain/use_cases/pick_post_image_use_case.dart';
import 'package:flutter_blog_firebase/features/posts/presentation/manager/add_post/add_post_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final addPostProvider =
    StateNotifierProvider.autoDispose<AddPostManager, AddPostState>((ref) {
  return AddPostManager(
      PickPostImageUseCase(
        CustomFilePicker(),
      ),
      AddPostsUseCase(
        Injection.getIt.get<PostsRepoImpl>(),
      ));
});

class AddPostManager extends StateNotifier<AddPostState> {
  final PickPostImageUseCase pickPostImageUseCase;
  final AddPostsUseCase addPostsUseCase;

  AddPostManager(this.pickPostImageUseCase, this.addPostsUseCase)
      : super(AddPostState.initial());

  Future<void> pickPostImage() async {
    final result = await pickPostImageUseCase.call(NoParams());
    state = state.copyWith(pickedImage: result);
  }

  void onChangedDescription(String value) {
    state = state.copyWith(description: value);
  }

  Future<void> addPost() async {
    final result = await addPostsUseCase
        .call(AddPostParams(state.pickedImage!, state.description));
    result.fold((l) => null, (r) => null);
  }
}
