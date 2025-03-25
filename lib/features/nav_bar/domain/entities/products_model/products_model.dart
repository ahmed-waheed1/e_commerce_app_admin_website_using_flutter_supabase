import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'comment.dart';
import 'favorite.dart';
import 'purchase.dart';
import 'rate.dart';

class ProductsModel extends Equatable {
  final String? productId;
  final DateTime? createdAt;
  final String? productName;
  final String? description;
  final String? oldPrice;
  final String? newPrice;
  final DateTime? updatedAt;
  final String? category;
  final String? sales;
  final String? imagePath;
  final List<Favorite>? favorites;
  final List<Purchase>? purchases;
  final List<Comment>? comments;
  final List<Rate>? rates;

  const ProductsModel({
    this.productId,
    this.createdAt,
    this.productName,
    this.description,
    this.oldPrice,
    this.newPrice,
    this.updatedAt,
    this.category,
    this.sales,
    this.imagePath,
    this.favorites,
    this.purchases,
    this.comments,
    this.rates,
  });

  factory ProductsModel.fromMap(Map<String, dynamic> data) => ProductsModel(
        productId: data['product_id'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        productName: data['product_name'] as String?,
        description: data['description'] as String?,
        oldPrice: data['old_price'] as String?,
        newPrice: data['new_price'] as String?,
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        category: data['category'] as String?,
        sales: data['sales'] as String?,
        imagePath: data['image_path'] as String?,
        favorites: (data['favorites'] as List<dynamic>?)
            ?.map((e) => Favorite.fromMap(e as Map<String, dynamic>))
            .toList(),
        purchases: (data['purchases'] as List<dynamic>?)
            ?.map((e) => Purchase.fromMap(e as Map<String, dynamic>))
            .toList(),
        comments: (data['comments'] as List<dynamic>?)
            ?.map((e) => Comment.fromMap(e as Map<String, dynamic>))
            .toList(),
        rates: (data['rates'] as List<dynamic>?)
            ?.map((e) => Rate.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'product_id': productId,
        'created_at': createdAt?.toIso8601String(),
        'product_name': productName,
        'description': description,
        'old_price': oldPrice,
        'new_price': newPrice,
        'updated_at': updatedAt?.toIso8601String(),
        'category': category,
        'sales': sales,
        'image_path': imagePath,
        'favorites': favorites?.map((e) => e.toMap()).toList(),
        'purchases': purchases?.map((e) => e.toMap()).toList(),
        'comments': comments?.map((e) => e.toMap()).toList(),
        'rates': rates?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductsModel].
  factory ProductsModel.fromJson(Map <String, dynamic> data) {
    return ProductsModel.fromMap(data);
    // return ProductsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ProductsModel copyWith({
    String? productId,
    DateTime? createdAt,
    String? productName,
    String? description,
    String? oldPrice,
    String? newPrice,
    DateTime? updatedAt,
    String? category,
    String? sales,
    String? imagePath,
    List<Favorite>? favorites,
    List<Purchase>? purchases,
    List<Comment>? comments,
    List<Rate>? rates,
  }) {
    return ProductsModel(
      productId: productId ?? this.productId,
      createdAt: createdAt ?? this.createdAt,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      oldPrice: oldPrice ?? this.oldPrice,
      newPrice: newPrice ?? this.newPrice,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      sales: sales ?? this.sales,
      imagePath: imagePath ?? this.imagePath,
      favorites: favorites ?? this.favorites,
      purchases: purchases ?? this.purchases,
      comments: comments ?? this.comments,
      rates: rates ?? this.rates,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      productId,
      createdAt,
      productName,
      description,
      oldPrice,
      newPrice,
      updatedAt,
      category,
      sales,
      imagePath,
      favorites,
      purchases,
      comments,
      rates,
    ];
  }
}
