class UserData {
  String? id;
  String? name;
  String? email;
  String? image;
  bool? admin;
  bool? verification;

  UserData({this.id, this.name, this.email, this.admin, this.image});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    admin = json['admin'];
    verification = json['verification'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'admin': admin,
      'verification': verification,
    };
  }
}
