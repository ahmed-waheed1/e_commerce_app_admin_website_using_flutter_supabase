import 'dart:convert';

import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String? id;
  final String? comment;
  final String? forUser;
  final DateTime? createdAt;
  final String? forProduct;

  const Comment({
    this.id,
    this.comment,
    this.forUser,
    this.createdAt,
    this.forProduct,
  });

  factory Comment.fromMap(Map<String, dynamic> data) => Comment(
        id: data['id'] as String?,
        comment: data['comment'] as String?,
        forUser: data['for_user'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        forProduct: data['for_product'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'comment': comment,
        'for_user': forUser,
        'created_at': createdAt?.toIso8601String(),
        'for_product': forProduct,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Comment].
  factory Comment.fromJson(String data) {
    return Comment.fromMap(json.decode(data) as Map<String, dynamic>);
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
  }) {
    return Comment(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      forUser: forUser ?? this.forUser,
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
      comment,
      forUser,
      createdAt,
      forProduct,
    ];
  }
}
