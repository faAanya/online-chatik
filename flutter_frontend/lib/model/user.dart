class User {
  final String nickname;
  final String phonenumber;
  final String? biography;
  final String? avatarUrl;

  User({
    required this.nickname,
    required this.phonenumber,
    this.biography,
    this.avatarUrl,
  });
}
