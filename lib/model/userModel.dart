// class UserData {
//   String id;
//   String name;
//   String email;
//   String accountType;
//   String imageProfile;
//   UserData(
//       {required this.id,
//       required this.name,
//       required this.email,
//       required this.accountType,
//       required this.imageProfile});
// }
// UserCredential(
// additionalUserInfo: AdditionalUserInfo(
// isNewUser: false,
// profile: {},
// providerId: null,
// username: null,
// authorizationCode: null),
// credential: null,
// user: User(
// displayName: null,
// email: abdonasser14@gmail.com,
// isEmailVerified: false,
// isAnonymous: false,
// metadata: UserMetadata(creationTime: 2024-09-06 15:34:02.400Z, lastSignInTime: 2024-09-13 11:55:31.054Z),
// phoneNumber: null,
// photoURL: null,
// providerData, [
//   UserInfo(
// displayName: null,
// email: abdonasser14@gmail.com,
// phoneNumber: null,
// photoURL: null,
// providerId: password,
// uid: abdonasser14@gmail.com)],
// refreshToken: null,
// tenantId: null,
// uid: Icz5q9ViKtdR5Dudkn8r2LzE54d2
// )
// )

class UserModel {
  User? user;

  UserModel({this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic phone;
  dynamic photoURL;
  bool? isEmailVerified;
  bool? isAnonymous;
  dynamic refreshToken;
  String? tenantId;
  dynamic displayName;
  String? uid;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.photoURL,
      this.isEmailVerified,
      this.isAnonymous,
      this.refreshToken,
      this.tenantId,
      this.displayName,
      this.uid});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photoURL = json['photoURL'];
    isEmailVerified = json['isEmailVerified'];
    isAnonymous = json['isAnonymous'];
    refreshToken = json['refreshToken'];
    tenantId = json['tenantId'];
    displayName = json['displayName'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['photoURL'] = photoURL;
    data['isEmailVerified'] = isEmailVerified;
    data['isAnonymous'] = isAnonymous;
    data['refreshToken'] = refreshToken;
    data['tenantId'] = tenantId;
    data['displayName'] = displayName;
    data['uid'] = uid;
    return data;
  }
}
