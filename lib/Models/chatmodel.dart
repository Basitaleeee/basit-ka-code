class Chat {
  final String id;
  final String name;
  final String message;
  final String time;

  Chat({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
  });

  factory Chat.fromFirestore(Map<String, dynamic> firestoreData, String id) {
    return Chat(
      id: id,
      name: firestoreData['customerName'] ?? '',
      message: firestoreData['messages'].last['text'] ?? '', // Last message
      time: firestoreData['messages'].last['timestamp'].toDate().toString(),
    );
  }
}
