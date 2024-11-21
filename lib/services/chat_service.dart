import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/chatmodel.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<Chat>> getChats(String designerId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: designerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Chat.fromFirestore(doc as Map<String, dynamic>);
      }).toList();
    });
  }
}
