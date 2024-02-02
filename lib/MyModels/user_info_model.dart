// shows user info with name and address

class UserInfoModel {
  final String name;
  final String address;
  final String uid;
  final String pincode;

  UserInfoModel(
    this.name,
    this.address,
    this.uid,
    this.pincode,
  );

  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
        "mobile": uid,
        "pinCode": pincode,
      };

  // create an instance to get the data
  factory UserInfoModel.getModelFromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      json["name"],
      json["address"],
      json["uid"],
      json["pinCode"],
    );
  }
}
