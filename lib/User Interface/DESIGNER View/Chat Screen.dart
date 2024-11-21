import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/chatmodel.dart';
import '../../Reusable/Bottom Navgation Bar.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import '../../services/chat_service.dart';
import 'HOME.dart';
import 'Messaging.dart';
import 'Notification Screen.dart';
import 'Profile Screen.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 1;
  String _searchQuery = ''; // To hold the search query
  final TextEditingController _searchController = TextEditingController();
  final ChatService _chatService = ChatService(); // Chat service instance

  final List<Widget> _screens = [
    HomeScreen(),
    ChatScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CombinedTextWithLineWidget(text: 'MESSAGES', fontSize: 15),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 50.h,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value; // Update the search query
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.greylight,
                  hintText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: StreamBuilder<List<Chat>>(
                stream: _chatService.getChats('designerId'), // Pass designerId here
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  // Filter chats based on the search query
                  final filteredChats = snapshot.data!.where((chat) {
                    return chat.name.toLowerCase().contains(_searchQuery.toLowerCase());
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredChats.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage('assets/Images/splash.png'),
                        ),
                        title: Text(
                          filteredChats[index].name,
                          style: tSStyleBlack16400.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(filteredChats[index].message),
                        trailing: Text(
                          filteredChats[index].time,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatDetailScreen(
                                contactName: filteredChats[index].name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
