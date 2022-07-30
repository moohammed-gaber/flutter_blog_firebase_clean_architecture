class UserEntity {
  final String name, profilePicture, email, id;

// required constructor
  const UserEntity({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.email,
  });
}
