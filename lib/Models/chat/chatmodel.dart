class ChatRoomModel {
  String? chatroomId;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoomModel({
    this.chatroomId,
    this.participants,
    this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      "chatroomId": chatroomId,
      "participants": participants,
      "lastmessage": lastMessage,
    };
  }
  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      chatroomId: map["chatroomId"] ?? '',
      participants: map["participants"] ?? {},
      lastMessage: map["lastmessage"] ?? '',
    );
  }
}