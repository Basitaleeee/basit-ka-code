// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
//
// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Fetch messages for a specific chat
//   Stream<List<types.Message>> getMessages(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true) // Ensure messages are sorted by time
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         final data = doc.data();
//         if (data['type'] == 'text') {
//           return types.TextMessage(
//             id: doc.id,
//             text: data['text'],
//             author: types.User(id: data['senderId']),
//             createdAt: (data['timestamp'] as Timestamp).millisecondsSinceEpoch,
//           );
//         } else {
//           // Handle other message types (e.g., images)
//           return types.CustomMessage(
//             id: doc.id,
//             metadata: data, // Add custom fields
//             author: types.User(id: data['senderId']),
//             createdAt: (data['timestamp'] as Timestamp).millisecondsSinceEpoch,
//           );
//         }
//       }).toList();
//     });
//   }
//
//   // Send a new message
//   Future<void> sendMessage(String chatId, types.TextMessage message) async {
//     final messageData = {
//       'text': message.text,
//       'senderId': message.author.id,
//       'timestamp': FieldValue.serverTimestamp(),
//       'type': 'text', // Define message type
//     };
//     await _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .add(messageData);
//   }
//   Future<void> createChat(String chatId, List<String> participants) async {
//     final chatRef = _firestore.collection('chats').doc(chatId);
//     final chatDoc = await chatRef.get();
//
//     if (!chatDoc.exists) {
//       await chatRef.set({
//         'participants': participants,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//   }
// }
