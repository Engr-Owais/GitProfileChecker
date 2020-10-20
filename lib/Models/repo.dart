class Repositries {
  // ignore: non_constant_identifier_names
  final String repo_name;
  // ignore: non_constant_identifier_names
  final String created_date;
  // ignore: non_constant_identifier_names
  final String last_pushed;
  final String description;
  final String branch;
  final String language;
  final String url;
  final int stars;

  Repositries({
    // ignore: non_constant_identifier_names
    this.repo_name,
    // ignore: non_constant_identifier_names
    this.created_date,
    this.branch,
    this.description,
    this.language,
    // ignore: non_constant_identifier_names
    this.last_pushed,
    this.stars,
    this.url,
  });
}