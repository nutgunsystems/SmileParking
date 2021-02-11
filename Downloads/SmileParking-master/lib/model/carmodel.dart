class CarModel {
  String id;
  String carIdentify;
  String carProvince;
  String ownerName;
  String ownerContact;
  String parkDate;
  String parkDatetime;
  String urlImage;
  String expireStatus;
  String deviceId;
  String deviceToken;

  CarModel(
      {this.id,
      this.carIdentify,
      this.carProvince,
      this.ownerName,
      this.ownerContact,
      this.parkDate,
      this.parkDatetime,
      this.urlImage,
      this.expireStatus,
      this.deviceId,
      this.deviceToken});

  CarModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carIdentify = json['car_identify'];
    carProvince = json['car_province'];
    ownerName = json['owner_name'];
    ownerContact = json['owner_contact'];
    parkDate = json['park_date'];
    parkDatetime = json['park_datetime'];
    urlImage = json['url_image'];
    expireStatus = json['expire_status'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_identify'] = this.carIdentify;
    data['car_province'] = this.carProvince;
    data['owner_name'] = this.ownerName;
    data['owner_contact'] = this.ownerContact;
    data['park_date'] = this.parkDate;
    data['park_datetime'] = this.parkDatetime;
    data['url_image'] = this.urlImage;
    data['expire_status'] = this.expireStatus;
    data['device_id'] = this.deviceId;
    data['device_token'] = this.deviceToken;
    return data;
  }
}
