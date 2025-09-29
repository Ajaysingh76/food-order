import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String distanceText;

  const Restaurant({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.distanceText,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, rating, distanceText];
}
