// To parse this JSON data, do
//
//     final productEntry = productEntryFromJson(jsonString);

import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    String description;
    String thumbnail;
    String category;
    String brand;
    bool isFeatured;
    DateTime createdAt;
    int stock;
    int sold;
    int rating;
    int user;

    Fields({
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.brand,
        required this.isFeatured,
        required this.createdAt,
        required this.stock,
        required this.sold,
        required this.rating,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        brand: json["brand"],
        isFeatured: json["is_featured"],
        createdAt: DateTime.parse(json["created_at"]),
        stock: json["stock"],
        sold: json["sold"],
        rating: json["rating"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "brand": brand,
        "is_featured": isFeatured,
        "created_at": createdAt.toIso8601String(),
        "stock": stock,
        "sold": sold,
        "rating": rating,
        "user": user,
    };
}
