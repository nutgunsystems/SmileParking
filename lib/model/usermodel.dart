class UserModel {
  String id;
  String membertype;
  String fullname;
  String user;
  String password;
  String modifydate;

  UserModel(
      {this.id,
      this.membertype,
      this.fullname,
      this.user,
      this.password,
      this.modifydate});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    membertype = json['membertype'];
    fullname = json['fullname'];
    user = json['user'];
    password = json['password'];
    modifydate = json['modifydate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['membertype'] = this.membertype;
    data['fullname'] = this.fullname;
    data['user'] = this.user;
    data['password'] = this.password;
    data['modifydate'] = this.modifydate;
    return data;
  }
}
