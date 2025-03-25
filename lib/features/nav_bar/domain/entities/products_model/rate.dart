import 'dart:convert';

import 'package:equatable/equatable.dart';

class Rate extends Equatable {
  final String? id;
  final int? rate;
  final String? forUser;
  final DateTime? createdAt;
  final String? forProduct;

  const Rate({
    this.id,
    this.rate,
    this.forUser,
    this.createdAt,
    this.forProduct,
  });

  factory Rate.fromMap(Map<String, dynamic> data) => Rate(
        id: data['id'] as String?,
        rate: data['rate'] as int?,
        forUser: data['for_user'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        forProduct: data['for_product'] as String?,
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (id != null) data['id'] = id;
    if (rate != null) data['rate'] = rate;
    if (forUser != null) data['for_user'] = forUser;
    if (createdAt != null) data['created_at'] = createdAt?.toIso8601String();
    if (forProduct != null) data['for_product'] = forProduct;
    return data;
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rate].
  factory Rate.fromJson(Map<String, dynamic> data) {
    return Rate.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [Rate] to a JSON string.
  String toJson() => json.encode(toMap());

  Rate copyWith({
    String? id,
    int? rate,
    String? forUser,
    DateTime? createdAt,
    String? forProduct,
  }) {
    return Rate(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      forUser: forUser ?? this.forUser,
      createdAt: createdAt ?? this.createdAt,
      forProduct: forProduct ?? this.forProduct,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, rate, forUser, createdAt, forProduct];
}
