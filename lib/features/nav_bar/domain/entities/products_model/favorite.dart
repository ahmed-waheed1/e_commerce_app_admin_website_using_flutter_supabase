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

  Map<String, dynamic> toMap() => {
        'id': id,
        'for_user': forUser,
        'created_at': createdAt?.toIso8601String(),
        'for_product': forProduct,
        'is_favorite': isFavorite,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Favorite].
  factory Favorite.fromJson(String data) {
    return Favorite.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Favorite] to a JSON string.
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
