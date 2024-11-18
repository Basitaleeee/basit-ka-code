import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Customer bottom bar.dart';
import '../../Reusable/Dashcontainer.dart';
import '../../Reusable/app_colors.dart';
import '../Customer View/Customer Notification Screen.dart';
import '../Customer View/Customer Profile Screen.dart';
import '../Customer View/Customer SMS screen.dart';
import '../Customer View/Event_sheet.dart';
import '../Customer View/Logout Screen.dart';
import '../DESIGNER View/Product Review.dart';
import 'All Conversation.dart';
import 'All Customers.dart';
import 'All Designer.dart';
import 'All Reports.dart';
import 'All products.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onNavItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
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
            icon: SvgPicture.asset('assets/Icons/Menu.svg'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            _buildHomeContent(),
            CustomerChatScreen(),
            CustomerNotificationScreen(),
            CustomerProfileScreen(),
          ],
        ),
        bottomNavigationBar: CustomerCustomBottomNavigationBar(
          selectedIndex: _selectedIndex,
          onTap: _onNavItemTapped,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CombinedTextWithLineWidget(text: 'ADMIN DASHBOARD', fontSize: 15),
            SizedBox(height: 30.h),
            CustomListItem(
              svgPath: 'assets/Icons/DesignersLogo.svg',
              text: 'Designers',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DesignerListScreen()),
                );
              },
            ),
            SizedBox(height: 12),
            CustomListItem(
              svgPath: 'assets/Icons/CustomersLogo.svg',
              text: 'Customers',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerListScreen()),
                );
              },
            ),
            SizedBox(height: 12),
            CustomListItem(
              svgPath: 'assets/Icons/ProductsLogo.svg',
              text: 'Products',
              onTap: () {
                Navigator .push(
                  context,
                  MaterialPageRoute(builder: (context) => AllProductsScreen()),
                );
              },
            ),
            SizedBox(height: 12),
            CustomListItem(
              svgPath: 'assets/Icons/ReportsLogo.svg',
              text: 'Reports',
              onTap: () {
                Navigator .push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportScreen()),
                );
              },
            ),
            SizedBox(height: 12),
            CustomListItem(
              svgPath: 'assets/Icons/ConversationsLogo.svg',
              text: 'Conversations',
              onTap: () {
                Navigator .push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversationsScreen()),
                );

              },
            ),
            SizedBox(height: 12),
            CustomListItem(
              svgPath: 'assets/Icons/BlockIcon.svg',
              text: 'Blocked Users',
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
}
