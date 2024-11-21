import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/Combined Text+icon.dart'; // Ensure this import is correct

class ChatDetailScreen extends StatefulWidget {
  final String contactName;

  ChatDetailScreen({required this.contactName});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.insert(0, message);
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'LOOK',
              style: aStyleBlack14400.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'BOOK',
                style: aStyleBlack14400.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 20.h),
          CombinedTextWithLineWidget(text: 'MESSAGES', fontSize: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
              ),
              Text(
                widget.contactName,
                style: tSStyleBlack18400.copyWith(
                    fontSize: 15.sp, fontWeight: FontWeight.w900),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/Images/splash.png',
                  ),
                  radius: 20.sp,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: index % 2 == 0
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? AppColors.secondary.withOpacity(0.8)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _messages[index],
                      style: TextStyle(
                        color: index % 2 == 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                // Attach file icon button
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.add, color: AppColors.secondary),
                    onPressed: () {},
                  ),
                ),
                // Expanded TextField with icons
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                            ),
                            icon: Icon(Icons.send, color: AppColors.white),
                            onPressed: _sendMessage,
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
