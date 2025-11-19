// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

ProductEntry productEntryFromJson(String str) => ProductEntry.fromJson(json.decode(str));

String productEntryToJson(ProductEntry data) => json.encode(data.toJson());

class ProductEntry {
  String model;
  String pk;
  Fields fields;

  ProductEntry({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String name;
  int price;
  int stock;
  String description;
  String thumbnail;
  String category;
  bool isFeatured;
  int rating;
  int totalRatings;
  dynamic user;

  Fields({
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.thumbnail,
    required this.category,
    required this.isFeatured,
    required this.rating,
    required this.totalRatings,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    name: json["name"],
    price: json["price"],
    stock: json["stock"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    category: json["category"],
    isFeatured: json["is_featured"],
    rating: json["rating"],
    totalRatings: json["total_ratings"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "stock": stock,
    "description": description,
    "thumbnail": thumbnail,
    "category": category,
    "is_featured": isFeatured,
    "rating": rating,
    "total_ratings": totalRatings,
    "user": user,
  };
}
