class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? subscriptionType;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.subscriptionType,
  });
}
