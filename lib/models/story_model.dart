

class Story {
  final String id;
  final String userId;
  final String image;
  final String video;
  final String caption;
  final DateTime expiredAt;
  final DateTime createdAt;

  Story({
    required this.id,
    required this.userId,
    required this.image,
    required this.video,
    required this.caption,
    required this.expiredAt,
    required this.createdAt,
  });

  factory Story.fromJson(Map<String, dynamic> json){
    return Story(id: json['_id'] ?? '', userId: json['userId'] ?? '', image: json['image'] ?? '', video: json['video'] ?? '', caption: json['caption'] ?? '',expiredAt: DateTime.parse(json['expired_at'] ?? DateTime.now().toIso8601String()), createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()));
  }
}