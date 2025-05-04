

// class Story {
//   final String id;
//   final String userId;
//   final String image;
//   final String video;
//   final String caption;
//   final DateTime expiredAt;
//   final DateTime createdAt;

//   Story({
//     required this.id,
//     required this.userId,
//     required this.image,
//     required this.video,
//     required this.caption,
//     required this.expiredAt,
//     required this.createdAt,
//   });

//   factory Story.fromJson(Map<String, dynamic> json){
//     return Story(id: json['_id'] ?? '', userId: json['userId'] ?? '', image: json['image'] ?? '', video: json['video'] ?? '', caption: json['caption'] ?? '',expiredAt: DateTime.parse(json['expired_at'] ?? DateTime.now().toIso8601String()), createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()));
//   }
// }




class Story {
  final String id;
  final String userId;
  final List<String> images;
  final List<String> videos;
  final String caption;
  final DateTime expiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  Story({
    required this.id,
    required this.userId,
    required this.images,
    required this.videos,
    required this.caption,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      id: json['_id'] ?? '',
      userId: json['user'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      videos: List<String>.from(json['videos'] ?? []),
      caption: json['caption'] ?? '',
      expiredAt: DateTime.tryParse(json['expired_at'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}
