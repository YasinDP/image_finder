class ImageItem {
  final int id;
  final String previewUrl;
  final String url;
  final int likes;
  final int views;

  const ImageItem({
    required this.id,
    required this.previewUrl,
    required this.url,
    required this.likes,
    required this.views,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) => ImageItem(
        id: json["id"] ?? 0,
        previewUrl: json["previewURL"] ?? "",
        url: json["largeImageURL"] ?? "",
        likes: json["likes"] ?? 0,
        views: json["views"] ?? 0,
      );
}
