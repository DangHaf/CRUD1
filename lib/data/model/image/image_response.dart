// ignore_for_file: public_member_api_docs, sort_constructors_first
class UrlImageResponse {
  String? originImage;
  String? extraLargeImage;
  String? largeImage;
  String? mediumImage;
  String? smallImage;
  String? extraSmallImage;

  UrlImageResponse({
    this.originImage,
    this.extraLargeImage,
    this.largeImage,
    this.mediumImage,
    this.smallImage,
    this.extraSmallImage,
  });

  @override
  String toString() {
    return 'UrlImageResponse(originImage: $originImage, extraLargeImage: $extraLargeImage, largeImage: $largeImage, mediumImage: $mediumImage, smallImage: $smallImage, extraSmallImage: $extraSmallImage)';
  }
}
