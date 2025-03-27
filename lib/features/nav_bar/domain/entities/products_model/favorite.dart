import 'dart:convert';

import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String? id;
  final String? forUser;
  final DateTime? createdAt;
  final String? forProduct;
  final bool? isFavorite;

  const Favorite({
    this.id,
    this.forUser,
    this.createdAt,
    this.forProduct,
    this.isFavorite,
  });

  factory Favorite.fromMap(Map<String, dynamic> data) => Favorite(
        id: data['id'] as String?,
        forUser: data['for_user'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        forProduct: data['for_product'] as String?,
        isFavorite: data['is_favorite'] as bool?,
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (forUser != null) data['for_user'] = forUser;
    if (forProduct != null) data['for_product'] = forProduct;
    if (isFavorite != null) data['is_favorite'] = isFavorite;
    return data;
  }

  factory Favorite.fromJson(Map<String, dynamic> data) {
    return Favorite.fromMap(data);
  }

  String toJson() => json.encode(toMap());

  Favorite copyWith({
    String? id,
    String? forUser,
    DateTime? createdAt,
    String? forProduct,
    bool? isFavorite,
  }) {
    return Favorite(
      id: id ?? this.id,
      forUser: forUser ?? this.forUser,
      createdAt: createdAt ?? this.createdAt,
      forProduct: forProduct ?? this.forProduct,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      forUser,
      createdAt,
      forProduct,
      isFavorite,
    ];
  }
}
