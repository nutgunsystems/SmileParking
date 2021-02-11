class WSModel {
  String stationId;
  String stationNameEn;
  String stationNameTh;
  String description;
  String createDate;

  WSModel(
      {this.stationId,
      this.stationNameEn,
      this.stationNameTh,
      this.description,
      this.createDate});

  WSModel.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    stationNameEn = json['station_name_en'];
    stationNameTh = json['station_name_th'];
    description = json['description'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['station_id'] = this.stationId;
    data['station_name_en'] = this.stationNameEn;
    data['station_name_th'] = this.stationNameTh;
    data['description'] = this.description;
    data['create_date'] = this.createDate;
    return data;
  }
}
