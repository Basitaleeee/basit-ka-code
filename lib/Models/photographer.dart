import 'package:cloud_firestore/cloud_firestore.dart';

class PhotographerModel {
  final String name;
  final String email;
  final String phone;
  final String socialLinks;
  final String imageUrl;

  PhotographerModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.socialLinks,
    required this.imageUrl,
  });

  // Convert from map (Firestore data) to PhotographerModel
  factory PhotographerModel.fromMap(Map<String, dynamic> map) {
    return PhotographerModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      socialLinks: map['socialLinks'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  // Convert PhotographerModel to map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'socialLinks': socialLinks,
      'imageUrl': imageUrl,
    };
  }

  // Convert Firestore document snapshot to PhotographerModel
  factory PhotographerModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return PhotographerModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      socialLinks: data['socialLinks'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}
