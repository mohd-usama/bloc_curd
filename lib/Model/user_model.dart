class UserModel {
  UserModel({
    this.id,
    this.name,
    this.mobileNo,
    this.dob,
    this.profileImg,
    this.age});

  UserModel.fromJson(dynamic json) {
    id = json["id"];
    name = json['name'];

    mobileNo = json['mobileNo'];
    dob = json['dob'];
    profileImg = json['profileImg'];
    age = json['age'];
  }
  int? id;
  String? name;

  String? mobileNo;
  String? dob;
  String? profileImg;
  String? age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id']=id;
    map['name'] = name;
    map['mobileNo'] = mobileNo;
    map['dob'] = dob;
    map['profileImg'] = profileImg;
    map['age'] = age;
    return map;
  }

}