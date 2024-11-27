import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String? text;
  String? sender;
  String? receiver;
  DateTime? sentOn;
  String? img;
  bool? isRead;
  bool? isReported;

  MessageModel(
      {this.id,
        this.text,
        this.sender,
        this.receiver,
        this.sentOn,
        this.img,
        this.isRead,
        this.isReported});


  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      sender:
      map['sender'] ?? '',
      receiver: map['receiver'] ?? '',
      sentOn: map['sentOn'] != null
          ? (map['sentOn'] as Timestamp).toDate()
          : null,
      img: map['img'] ?? '',
      isRead: map['isRead'] ?? false,
      isReported: map['isReported'] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'sender': sender,
      'receiver': receiver,
      'sentOn': sentOn != null
          ? Timestamp.fromDate(sentOn!)
          : null,
      'img': img,
      'isRead': isRead,
      'isReported': isReported
    };
  }
}