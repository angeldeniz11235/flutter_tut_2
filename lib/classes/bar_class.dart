class Bar {
  final String name;
  final String city;
  final String state;
  final String? website;
  Bar(
      {required this.city,
      required this.name,
      required this.state,
      this.website});

  factory Bar.fromJson(Map<String, dynamic> json) {
    return Bar(
        name: json['name'],
        city: json['city'],
        state: json['state'],
        website: json['website_url']);
  }
}
