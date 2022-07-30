import 'dart:io';

class AddPostState {
  final File? pickedImage;
  final String description;

  AddPostState(this.pickedImage, this.description);

// initial state
  factory AddPostState.initial() => AddPostState(null, '');

  // copy with
  AddPostState copyWith({
    File? pickedImage,
    String? description,
  }) {
    return AddPostState(
        pickedImage ?? this.pickedImage, description ?? this.description);
  }
}
