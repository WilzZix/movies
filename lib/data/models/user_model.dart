class UserModel {
  final String requestToken;
  final String accountId;

  UserModel({
    required this.requestToken,
    required this.accountId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      requestToken: '',
      accountId: '',
    );
  }
}
