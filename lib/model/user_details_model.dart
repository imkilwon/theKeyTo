class UserDetailsModel {
  final String name;
  String userId;

  UserDetailsModel({required this.name, this.userId =''});

  Map<String, dynamic> getJson() => {
    'name': name,
    'userId': userId,
  };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"], userId: json["userId"]);
  }
}