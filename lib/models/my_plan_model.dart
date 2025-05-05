class SubscribePlanModel {
  final String planId;
  final String name;
  final int originalPrice;
  final int offerPrice;
  final int discountPercentage;
  final String duration;
  final DateTime startDate;
  final DateTime endDate;
  final String id;

  SubscribePlanModel({
    required this.planId,
    required this.name,
    required this.originalPrice,
    required this.offerPrice,
    required this.discountPercentage,
    required this.duration,
    required this.startDate,
    required this.endDate,
    required this.id,
  });

  factory SubscribePlanModel.fromJson(Map<String, dynamic> json) {
    return SubscribePlanModel(
      planId: json['planId'] ?? '',
      name: json['name'] ?? '',
      originalPrice: json['originalPrice'] ?? 0,
      offerPrice: json['offerPrice'] ?? 0,
      discountPercentage: json['discountPercentage'] ?? 0,
      duration: json['duration'] ?? '',
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'planId': planId,
      'name': name,
      'originalPrice': originalPrice,
      'offerPrice': offerPrice,
      'discountPercentage': discountPercentage,
      'duration': duration,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      '_id': id,
    };
  }
}
