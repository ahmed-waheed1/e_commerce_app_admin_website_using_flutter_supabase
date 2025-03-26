import 'dart:convert';

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String? id;
  final String? comment;
  final String? forUser;
  final DateTime? createdAt;
  final String? forProduct;
  final String? username; // Add this field

  const Comment({
    this.id,
    this.comment,
    this.forUser,
    this.createdAt,
    this.forProduct,
    this.username, // Add this field
  });

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        id: data['id'] as String?,
        comment: data['comment'] as String?,
        forUser: data['for_user'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        forProduct: data['for_product'] as String?,
        username: data['username'] as String?, // Add this field
      );

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (comment != null) data['comment'] = comment;
    if (forUser != null) data['for_user'] = forUser;
    if (forProduct != null) data['for_product'] = forProduct;
    if (username != null) data['username'] = username; // Add this field
    return data;
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Comment].
  factory Comment.fromJson(Map<String, dynamic> data) {
    return Comment.fromMap(data);
  }

  /// `dart:convert`
  ///
  /// Converts [Comment] to a JSON string.
  String toJson() => json.encode(toMap());

  Comment copyWith({
    String? id,
    String? comment,
    String? forUser,
    DateTime? createdAt,
    String? forProduct,
    String? username, // Add this field
  }) {
    return Comment(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      forUser: forUser ?? this.forUser,
      createdAt: createdAt ?? this.createdAt,
      forProduct: forProduct ?? this.forProduct,
      username: username ?? this.username, // Add this field
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      comment,
      forUser,
      createdAt,
      forProduct,
      username, // Add this field
    ];
  }
}
