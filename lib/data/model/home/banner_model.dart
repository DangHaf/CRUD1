class BannerModel {
  String? id;
  String? type;
  bool? isShow;
  int? position;
  String? link;
  String? image;

  BannerModel({
    this.id,
    this.type,
    this.isShow,
    this.position,
    this.link,
    this.image,
  });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    type = json['type'];
    isShow = json['isShow'];
    position = json['position'];
    link = json['link'];
    image = json['image'];
  }
}
