// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../Models/chat/chatmodel.dart';
//
// class ChatScreen extends StatefulWidget {
//   final String currentUserId;
//   final String chatWithUserId;
//
//   const ChatScreen({required this.currentUserId, required this.chatWithUserId});
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _messageController = TextEditingController();
//
//   void sendMessage() async {
//     if (_messageController.text.trim().isEmpty) return;
//
//     final message = _messageController.text.trim();
//     final timestamp = DateTime.now();
//
//     await FirebaseFirestore.instance.collection('messages').add({
//       'senderId': widget.currentUserId,
//       'receiverId': widget.chatWithUserId,
//       'message': message,
//       'timestamp': timestamp.toIso8601String(),
//     });
//
//     _messageController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Check if currentUserId is valid
//     if (widget.currentUserId.isEmpty) {
//       return Scaffold(
//         body: Center(child: Text("Error: Current user ID is missing")),
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('messages')
//                   .where('senderId', isEqualTo: widget.currentUserId)
//                   .where('receiverId', isEqualTo: widget.chatWithUserId)
//                   .orderBy('timestamp', descending: true)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 final messages = snapshot.data!.docs;
//
//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = ChatMessage.fromMap(
//                         messages[index].data() as Map<String, dynamic>);
//
//                     return ListTile(
//                       title: Text(message.message),
//                       subtitle: Text(
//                         message.timestamp.toString(),
//                         style: TextStyle(fontSize: 12, color: Colors.grey),
//                       ),
//                       leading: CircleAvatar(child: Icon(Icons.person)),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(hintText: 'Enter message...'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ChatMessage  {
//   final String senderId;
//   final String receiverId;
//   final String message;
//   final DateTime timestamp;
//
//   ChatMessage({required this.senderId, required this.receiverId, required this.message, required this.timestamp});
//
//   static fromMap(Map<String, dynamic> data) {}
// }
