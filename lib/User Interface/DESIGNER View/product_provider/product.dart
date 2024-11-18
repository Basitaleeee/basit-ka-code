import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../Models/product.dart';

class ProductProvider with ChangeNotifier {
  List<File> selectedImages = [];
  List<String> selectedSocialLinks = [];

  Future<void> addProduct(ProductModel product) async {
    try {
      // Generate product ID
      String productId = FirebaseFirestore.instance.collection('products').doc().id;

      // Upload images
      List<String> imageUrls = [];
      for (var image in selectedImages) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = FirebaseStorage.instance.ref().child('product_images/$fileName');
        await ref.putFile(image);
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      product.images = imageUrls;

      // Save to Firestore
      await FirebaseFirestore.instance.collection('products').doc(productId).set(product.toMap());
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  void clearData() {
    selectedImages = [];
    selectedSocialLinks = [];
    notifyListeners();
  }
}
