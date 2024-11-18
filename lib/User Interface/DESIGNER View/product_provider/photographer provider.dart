import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models/photographer.dart';

class PhotographerProvider with ChangeNotifier {
  final List<PhotographerModel> _photographers = [];

  List<PhotographerModel> get photographers => _photographers;

  get imageUrl =>  FirebaseFirestore.instance.collection('photographers').doc().id;

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

  pickImage () {}
}
