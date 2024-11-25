import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Reusable/Bottom Navgation Bar.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import 'Chat Screen.dart';
import 'HOME.dart';
import 'Messaging.dart';
import 'Profile Screen.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 2;

  final List<Widget> _screens = [
    HomeScreen(),
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

  final List<Map<String, String>> notifications = [
    {'title': 'Order Update', 'message': 'Your order has been shipped', 'time': '1h ago'},
    {'title': 'New Message', 'message': 'You received a new message', 'time': '3h ago'},
    {'title': 'Discount Alert', 'message': '50% off on selected items!', 'time': '5h ago'},
    {'title': 'Update Available', 'message': 'New update is ready to install', 'time': '1d ago'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            CombinedTextWithLineWidget(text: 'NOTIFICATIONS', fontSize: 15),
            SizedBox(height: 20.h),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.secondary.withOpacity(0.8),
                        child: Icon(Icons.notifications, color: Colors.white),
                      ),
                      title: Text(
                        notifications[index]['title']!,
                        style: tSStyleBlack16400.copyWith(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(notifications[index]['message']!),
                      trailing: Text(
                        notifications[index]['time']!,
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: MyCustomBottomNavigationBar( // Use the renamed custom bottom navigation bar
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
