import 'dart:convert';

import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
  final String? id;
  final String? forUser;
  final bool? isBought;
  final DateTime? createdAt;
  final String? forProduct;

  const Purchase({
    this.id,
    this.forUser,
    this.isBought,
    this.createdAt,
    this.forProduct,
  });

  factory Purchase.fromMap(Map<String, dynamic> data) => Purchase(
        id: data['id'] as String?,
        forUser: data['for_user'] as String?,
        isBought: data['is_bought'] as bool?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        forProduct: data['for_product'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'for_user': forUser,
        'is_bought': isBought,
        'created_at': createdAt?.toIso8601String(),
        'for_product': forProduct,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Purchase].
  factory Purchase.fromJson(String data) {
    return Purchase.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Purchase] to a JSON string.
  String toJson() => json.encode(toMap());

  Purchase copyWith({
    String? id,
    String? forUser,
    bool? isBought,
    DateTime? createdAt,
    String? forProduct,
  }) {
    return Purchase(
      id: id ?? this.id,
      forUser: forUser ?? this.forUser,
      isBought: isBought ?? this.isBought,
      createdAt: createdAt ?? this.createdAt,
      forProduct: forProduct ?? this.forProduct,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      forUser,
      isBought,
      createdAt,
      forProduct,
    ];
  }
}
