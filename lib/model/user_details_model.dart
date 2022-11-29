class UserDetailsModel {
  String profileImage;
  //database에 들어갈 정보들
  final String name;
  final String email;

  UserDetailsModel({required this.name,required this.email,this.profileImage = ''});

  Map<String, dynamic> getJson() => {
    'name': name,
    'email':email,
  };

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json["name"],email: json["email"],profileImage: '');
  }
}