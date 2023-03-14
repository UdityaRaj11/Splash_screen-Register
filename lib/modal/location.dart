class Location {
  String country;

  Location(this.country);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(json['Country']);
  }
}
