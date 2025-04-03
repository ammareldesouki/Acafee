import 'dart:convert';

import 'package:flutter/services.dart';

class Item {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final String category;


  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.category
  });

  // Convert JSON to Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      category: json['category']
    );
  }

  // Convert Item to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
    };
  }

}