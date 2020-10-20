class User {
  String username;
  String imageUrl;
  int followers;
  int followings;
  // ignore: non_constant_identifier_names
  int public_repo;
  // ignore: non_constant_identifier_names
  String joined_date;

  User({
    this.username,
    this.imageUrl,
    // ignore: non_constant_identifier_names
    this.joined_date,
    this.followers,
    this.followings,
    // ignore: non_constant_identifier_names
    this.public_repo,
  });
}