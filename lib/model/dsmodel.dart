class DSModel {
  String refStationId;
  String stationNameEn;
  String stationNameTh;
  String latPosition;
  String longPosition;

  DSModel(
      {this.refStationId,
      this.stationNameEn,
      this.stationNameTh,
      this.latPosition,
      this.longPosition});

  DSModel.fromJson(Map<String, dynamic> json) {
    refStationId = json['ref_station_id'];
    stationNameEn = json['station_name_en'];
    stationNameTh = json['station_name_th'];
    latPosition = json['lat_position'];
    longPosition = json['long_position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ref_station_id'] = this.refStationId;
    data['station_name_en'] = this.stationNameEn;
    data['station_name_th'] = this.stationNameTh;
    data['lat_position'] = this.latPosition;
    data['long_position'] = this.longPosition;
    return data;
  }
}
