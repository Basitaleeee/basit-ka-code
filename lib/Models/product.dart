import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;
  String name;
  String price;
  String description;
  String quantity;
  String barcode;
  String category;
  String color;
  String event;
  String eventDate;
  List<String> images;
  List<String> socialLinks;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.quantity,
    required this.barcode,
    required this.category,
    required this.color,
    required this.event,
    required this.eventDate,
    required this.images,
    required this.socialLinks,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'quantity': quantity,
      'barcode': barcode,
      'category': category,
      'color': color,
      'event': event,
      'eventDate': eventDate,
      'images': images,
      'socialLinks': socialLinks,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? '',
      barcode: map['barcode'] ?? '',
      category: map['category'] ?? '',
      color: map['color'] ?? '',
      event: map['event'] ?? '',
      eventDate: map['eventDate'] ?? '',
      images: List<String>.from(map['images'] ?? []),
      socialLinks: List<String>.from(map['socialLinks'] ?? []),
    );
  }

  // Convert Firestore document snapshot to ProductModel
  factory ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductModel(
      id: snapshot.id,
      name: data['name'] ?? '',
      price: data['price'] ?? '',
      description: data['description'] ?? '',
      quantity: data['quantity'] ?? '',
      barcode: data['barcode'] ?? '',
      category: data['category'] ?? '',
      color: data['color'] ?? '',
      event: data['event'] ?? '',
      eventDate: data['eventDate'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      socialLinks: List<String>.from(data['socialLinks'] ?? []),
    );
  }

  get minimumOrderQuantity => null;
}
