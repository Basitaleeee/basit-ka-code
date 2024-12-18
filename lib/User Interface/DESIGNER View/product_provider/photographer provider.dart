import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../Models/photographer.dart';

class PhotographerProvider extends ChangeNotifier {
  final List<PhotographerModel> _photographers = [];
  List<PhotographerModel> get photographers => _photographers;
  String? imageUrl;

  // Fetch photographers from Firestore
  Future<void> fetchPhotographers(String productId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('photographers')
          .get();

      _photographers.clear();
      for (var doc in snapshot.docs) {
        _photographers.add(PhotographerModel.fromMap(doc.data()));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching photographers: $e');
    }
  }

  // Add a new photographer
  Future<void> addPhotographer(String productId, PhotographerModel photographer) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .collection('photographers')
          .add(photographer.toMap());
      _photographers.add(photographer);
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding photographer: $e');
    }
  }

  // Pick an image and upload it to Firebase Storage
  Future<void> pickImage({
    required BuildContext context,
    required void Function(String imageUrl) onImagePicked,
    required void Function(String error) onError,
  }) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);
        String fileName = pickedFile.name;
        Reference storageReference = FirebaseStorage.instance.ref().child('photographers/$fileName');

        UploadTask uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() async {
          imageUrl = await storageReference.getDownloadURL();
          onImagePicked(imageUrl!);
          notifyListeners();
        });
      }
    } catch (e) {
      onError("Error picking image: $e");  // Improve error message
    }
  }
}
