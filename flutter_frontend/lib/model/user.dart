class User {
  final String id;
  final String nickname;
  final String phonenumber;
  final String? biography;
  final String? avatarUrl;

  User({
    required this.id,
    required this.nickname,
    required this.phonenumber,
    this.biography,
    this.avatarUrl,
  });
}
