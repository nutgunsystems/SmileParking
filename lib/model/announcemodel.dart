class AnnounceTable {
  String id;
  String refObstacleId;
  String announceDatetime;

  AnnounceTable({this.id, this.refObstacleId, this.announceDatetime});

  AnnounceTable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refObstacleId = json['ref_obstacle_id'];
    announceDatetime = json['announce_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ref_obstacle_id'] = this.refObstacleId;
    data['announce_datetime'] = this.announceDatetime;
    return data;
  }
}
