import 'package:cloud_firestore/cloud_firestore.dart';

class PhotographerModel {
  final String name;
  final String email;
  final String phone;
  final String socialLinks;
  final String imageUrl;
  final String about; // Added about field

  PhotographerModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.socialLinks,
    required this.imageUrl,
    required this.about, // Added about parameter
  });

  // Convert from map (Firestore data) to PhotographerModel
  factory PhotographerModel.fromMap(Map<String, dynamic> map) {
    return PhotographerModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      socialLinks: map['socialLinks'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      about: map['about'] ?? '', // Fetching about field
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
      'about': about, // Saving about field
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
      about: data['about'] ?? '', // Fetching about field
    );
  }
}
