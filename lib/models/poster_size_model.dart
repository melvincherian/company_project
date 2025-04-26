class PosterSize {
  final String title;
  final String size;
  final double width;
  final double height;

  PosterSize({
    required this.title,
    required this.size,
    required this.width,
    required this.height,
  });

  factory PosterSize.fromMap(Map<String, String> map) {
    final dimensions = map['size']!.split('*');
    return PosterSize(
      title: map['title']!,
      size: map['size']!,
      width: double.parse(dimensions[0]),
      height: double.parse(dimensions[1]),
    );
  }
}