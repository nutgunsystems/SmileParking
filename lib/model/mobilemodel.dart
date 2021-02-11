class MobileModel {
  String imei;
  String uniqueId;

  MobileModel({this.imei, this.uniqueId});

  MobileModel.fromJson(Map<String, dynamic> json) {
    imei = json['Imei'];
    uniqueId = json['uniqueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Imei'] = this.imei;
    data['uniqueId'] = this.uniqueId;
    return data;
  }
}
