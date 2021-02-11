class CardsModel {
  String id;
  String refCarId;
  String issueDate;
  String issueDatetime;
  String informerName;
  String informerContact;
  String expireStatus;
  String deviceId;
  String urlImage;
  String ownerContact;
  String acknowledgeStatus;
  String carIdentify;
  String carProvince;
  String carPicture;

  CardsModel(
      {this.id,
      this.refCarId,
      this.issueDate,
      this.issueDatetime,
      this.informerName,
      this.informerContact,
      this.expireStatus,
      this.deviceId,
      this.urlImage,
      this.ownerContact,
      this.acknowledgeStatus,
      this.carIdentify,
      this.carProvince,
      this.carPicture});

  CardsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refCarId = json['ref_car_id'];
    issueDate = json['issue_date'];
    issueDatetime = json['issue_datetime'];
    informerName = json['informer_name'];
    informerContact = json['informer_contact'];
    expireStatus = json['expire_status'];
    deviceId = json['device_id'];
    urlImage = json['url_image'];
    ownerContact = json['owner_contact'];
    acknowledgeStatus = json['acknowledge_status'];
    carIdentify = json['car_identify'];
    carProvince = json['car_province'];
    carPicture = json['car_picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_car_id'] = this.refCarId;
    data['issue_date'] = this.issueDate;
    data['issue_datetime'] = this.issueDatetime;
    data['informer_name'] = this.informerName;
    data['informer_contact'] = this.informerContact;
    data['expire_status'] = this.expireStatus;
    data['device_id'] = this.deviceId;
    data['url_image'] = this.urlImage;
    data['owner_contact'] = this.ownerContact;
    data['acknowledge_status'] = this.acknowledgeStatus;
    data['car_identify'] = this.carIdentify;
    data['car_province'] = this.carProvince;
    data['car_picture'] = this.carPicture;
    return data;
  }
}
