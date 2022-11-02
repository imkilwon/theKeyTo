class UserDetailsModel {
  String profile_image;
  //database에 들어갈 정보들
  final String name;

  UserDetailsModel({required this.name,this.profile_image = ''});

  Map<String, dynamic> getJson() => {
    'name': name,
  };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"],profile_image: '');
  }
}