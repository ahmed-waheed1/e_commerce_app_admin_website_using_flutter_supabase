import 'package:flutter/material.dart';

class Category {
  final String name;
  final IconData icon; // todo may be change to String

  Category({required this.name, required this.icon});
  @override
  String toString() {
    return 'Category{name: $name, imageUrl: $icon}';
  }
}
