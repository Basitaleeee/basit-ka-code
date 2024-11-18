import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Bottom Navgation Bar.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
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

  // Sample chat data
  final List<Map<String, String>> chats = [
    {'name': 'KASHAN ASHRAF', 'message': 'KIDR HA ?', 'time': '10:00 AM'},
    {'name': 'HUZAIFA BHAI', 'message': 'ACHA KAM HAI!', 'time': '10:15 AM'},
    {'name': 'SUBHAN SAAB', 'message': 'SIGMA HAI TU TO ', 'time': '11:00 AM'},
    {'name': 'FARHAN RAJA', 'message': 'CHALA JA !', 'time': '11:30 AM'},
  ];

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
    // Filter chats based on the search query
    final filteredChats = chats.where((chat) {
      return chat['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
              child: ListView.builder(
                itemCount: filteredChats.length, // Use filtered chats
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: AssetImage('assets/Images/splash.png'),
                    ),
                    title: Text(
                      filteredChats[index]['name']!,
                      style: tSStyleBlack16400.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(filteredChats[index]['message']!),
                    trailing: Text(
                      filteredChats[index]['time']!,
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailScreen(
                            contactName: filteredChats[index]['name']!,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyCustomBottomNavigationBar( // Use the reusable bottom navigation bar
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
