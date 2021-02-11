class CardsModel {
  String id;
  String refCarId;
  String carIdentify;
  String carProvince;
  String refStationId;
  String issueDate;
  String issueDatetime;
  String informerName;
  String informerContact;
  String expireStatus;
  String deviceId;
  String urlImage;
  String acknowledgeStatus;
  String acknowledgeDatetime;
  String informerDeviceToken;
  String ownerName;
  String ownerContact;
  String refCarIdentify;
  String refCarProvince;
  String refCarPicture;
  String ownerDeviceToken;
  String totalAnnounce;

  CardsModel(
      {this.id,
      this.refCarId,
      this.carIdentify,
      this.carProvince,
      this.refStationId,
      this.issueDate,
      this.issueDatetime,
      this.informerName,
      this.informerContact,
      this.expireStatus,
      this.deviceId,
      this.urlImage,
      this.acknowledgeStatus,
      this.acknowledgeDatetime,
      this.informerDeviceToken,
      this.ownerName,
      this.ownerContact,
      this.refCarIdentify,
      this.refCarProvince,
      this.refCarPicture,
      this.ownerDeviceToken,
      this.totalAnnounce});

  CardsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCarId = json['ref_car_id'];
    carIdentify = json['car_identify'];
    carProvince = json['car_province'];
    refStationId = json['ref_station_id'];
    issueDate = json['issue_date'];
    issueDatetime = json['issue_datetime'];
    informerName = json['informer_name'];
    informerContact = json['informer_contact'];
    expireStatus = json['expire_status'];
    deviceId = json['device_id'];
    urlImage = json['url_image'];
    acknowledgeStatus = json['acknowledge_status'];
    acknowledgeDatetime = json['acknowledge_datetime'];
    informerDeviceToken = json['informer_device_token'];
    ownerName = json['owner_name'];
    ownerContact = json['owner_contact'];
    refCarIdentify = json['ref_car_identify'];
    refCarProvince = json['ref_car_province'];
    refCarPicture = json['ref_car_picture'];
    ownerDeviceToken = json['owner_device_token'];
    totalAnnounce = json['total_announce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_car_id'] = this.refCarId;
    data['car_identify'] = this.carIdentify;
    data['car_province'] = this.carProvince;
    data['ref_station_id'] = this.refStationId;
    data['issue_date'] = this.issueDate;
    data['issue_datetime'] = this.issueDatetime;
    data['informer_name'] = this.informerName;
    data['informer_contact'] = this.informerContact;
    data['expire_status'] = this.expireStatus;
    data['device_id'] = this.deviceId;
    data['url_image'] = this.urlImage;
    data['acknowledge_status'] = this.acknowledgeStatus;
    data['acknowledge_datetime'] = this.acknowledgeDatetime;
    data['informer_device_token'] = this.informerDeviceToken;
    data['owner_name'] = this.ownerName;
    data['owner_contact'] = this.ownerContact;
    data['ref_car_identify'] = this.refCarIdentify;
    data['ref_car_province'] = this.refCarProvince;
    data['ref_car_picture'] = this.refCarPicture;
    data['owner_device_token'] = this.ownerDeviceToken;
    data['total_announce'] = this.totalAnnounce;
    return data;
  }
}
