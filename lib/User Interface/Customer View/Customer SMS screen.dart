import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Customer bottom bar.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import 'Customer Notification Screen.dart';
import 'Customer Profile Screen.dart';
import 'Home Screen.dart';

class CustomerChatScreen extends StatefulWidget {
  final String name;

  CustomerChatScreen({Key? key, this.name = ''}) : super(key: key);

  @override
  _CustomerChatScreenState createState() => _CustomerChatScreenState();
}

class _CustomerChatScreenState extends State<CustomerChatScreen> {
  int _selectedIndex = 1; // Set the selected index to 1 for Chat
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> chats = [
    {'name': 'KASHAN ASHRAF', 'message': 'KIDR HA ?', 'time': '10:00 AM'},
    {'name': 'HUZAIFA BHAI', 'message': 'ACHA KAM HAI!', 'time': '10:15 AM'},
    {'name': 'SUBHAN SAAB', 'message': 'SIGMA HAI TU TO ', 'time': '11:00 AM'},
    {'name': 'FARHAN RAJA', 'message': 'CHALA JA !', 'time': '11:30 AM'},
  ];

  final List<Widget> _screens = [
    CustomerHomeScreen(),
    CustomerChatScreen(),
    CustomerNotificationScreen(),
    CustomerProfileScreen(),
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
    final filteredChats = chats.where((chat) {
      return chat['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Column(
      //     children: [
      //       Text(
      //         'LOOK',
      //         style: aStyleBlack14400.copyWith(
      //           fontSize: 16.sp,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 70.0),
      //         child: Text(
      //           'BOOK',
      //           style: aStyleBlack14400.copyWith(
      //             fontSize: 16.sp,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      //   centerTitle: true,
      //   leading: IconButton(
      //     icon: Icon(Icons.menu),
      //     onPressed: () {
      //       // Implement menu action
      //     },
      //   ),
      // ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),
            CombinedTextWithLineWidget(text: 'MESSAGES', fontSize: 15),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 50.h,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
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
                itemCount: filteredChats.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25.r,
                      backgroundImage: AssetImage('assets/Images/splash.png'),
                    ),
                    title: Text(
                      filteredChats[index]['name']!,
                      style: tSStyleBlack16400.copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(filteredChats[index]['message']!),
                    trailing: Text(
                      filteredChats[index]['time']!,
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CustomerChatScreen(
                      //       name: filteredChats[index]['name']!,
                      //     ),
                      //   ),
                      // );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: CustomerCustomBottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onTabTapped,
      // ),
    );
  }
}
