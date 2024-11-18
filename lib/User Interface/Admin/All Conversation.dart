import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/app_colors.dart';
import '../DESIGNER View/Messaging.dart';
import 'Chat.dart';

class ConversationsScreen extends StatefulWidget {
  @override
  _ConversationsScreenState createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  List<Map<String, String>> conversations = [
    {
      'designerName': 'Jhone Lane',
      'customerName': 'Jone Lisa',
      'designerImage': 'assets/Images/noti.png',
      'customerImage': 'assets/Images/profile.png',
      'lastMessage': 'Looking forward to our next session!',
    },
    {
      'designerName': 'Jane Doe',
      'customerName': 'Mark Smith',
      'designerImage': 'assets/Images/noti.png',
      'customerImage': 'assets/Images/profile.png',
      'lastMessage': 'Can we schedule a fitting next week?',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredConversations = conversations
        .where((conversation) =>
    conversation['designerName']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
        conversation['customerName']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'LOOK',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'BOOK',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CombinedTextWithLineWidget(text: 'CONVERSATIONS', fontSize: 17),
            SizedBox(height: 10),
            Container(
              height: 45,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.grey1,
                  hintText: 'Search Conversations',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredConversations.length,
                itemBuilder: (context, index) {
                  return ConversationListItem(
                    designerImage: filteredConversations[index]['designerImage']!,
                    customerImage: filteredConversations[index]['customerImage']!,
                    designerName: filteredConversations[index]['designerName']!,
                    customerName: filteredConversations[index]['customerName']!,
                    lastMessage: filteredConversations[index]['lastMessage']!,
                    destinationScreen: ChatDetailScreen1(designerName: '', customerName: '', designerImage: '', customerImage: '',),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationListItem extends StatelessWidget {
  final String designerImage;
  final String customerImage;
  final String designerName;
  final String customerName;
  final String lastMessage;
  final Widget destinationScreen;

  const ConversationListItem({
    Key? key,
    required this.designerImage,
    required this.customerImage,
    required this.designerName,
    required this.customerName,
    required this.lastMessage,
    required this.destinationScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.grey1,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(designerImage),
                  radius: 20,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$designerName & $customerName',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        lastMessage,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward, color: AppColors.secondary),
              ],
            ),
          ),
          Positioned(
            left: 2,
            top: 13,
            child: CircleAvatar(
              backgroundImage: AssetImage(customerImage),
              radius: 20,
            ),
          ),
        ],
      ),
    );
  }
}
