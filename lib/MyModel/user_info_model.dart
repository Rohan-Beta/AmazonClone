// shows user info with name and address

class UserInfoModel {
  final String name;
  final String address;
  final String uid;

  UserInfoModel(this.name, this.address, this.uid);

  Map<String, dynamic> getJson() => {
        "name": name,
        "address": address,
        "mobile": uid,
      };

  // create an instance to get the data
  factory UserInfoModel.getModelFromJson(Map<String, dynamic> json) {
    return UserInfoModel(json["name"], json["address"], json["uid"]);
  }
}
