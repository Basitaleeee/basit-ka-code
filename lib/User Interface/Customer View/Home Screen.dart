import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Customer bottom bar.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Product Card.dart';
import '../../Reusable/app_colors.dart';
import '../DESIGNER View/Product Review.dart';
import 'Customer Notification Screen.dart';
import 'Customer SMS screen.dart';
import 'Customer Profile Screen.dart';
import 'Event_sheet.dart'; // Ensure this is the correct path for EventSearchScreen
import 'Logout Screen.dart';
import 'Product Detail Screen.dart';
import 'Scan Barcode.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final List<Map<String, String>> products = [
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash1.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash2.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/images/product4.png'},
  ];

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Implement QR scanner or other action
          },
          backgroundColor: AppColors.secondary,
          shape: CircleBorder(),
          child: SvgPicture.asset('assets/Icons/ScanFrame.svg', color: Colors.white),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Container(
              height: 50.h,
              width: double.infinity,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => EventSearchScreen(),
                      );
                    },
                    child: SvgPicture.asset('assets/Icons/SearchMenu.svg'),
                  ),
                  suffixIconConstraints: BoxConstraints(minHeight: 20.h, minWidth: 70.h),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            CombinedTextWithLineWidget(text: 'TEAR SHOW', fontSize: 15),
            SizedBox(height: 20.h),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.h,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerReviewScreen(),
                      ),
                    );
                  },
                  child: ProductCardWidget(
                    title: products[index]['title']!,
                    subtitle: 'Cardigan',
                    price: '\$120', imageUrl: '',
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 296.h,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 50.w),
                    child: Text(
                      'LOOK',
                      style: aStyleBlack18600.copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    'BOOK',
                    style: aStyleBlack18600.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    height: 74.h,
                    width: 323.w,
                    child: Text(
                      'Making a luxurious lifestyle accessible for a generous group of women is our daily drive.',
                      style: tSStyleBlack16400.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SvgPicture.asset(
                    'assets/Icons/line.svg',
                    color: AppColors.white,
                  ),
                  SizedBox(height: 20.h),
                  SvgPicture.asset(
                    'assets/Icons/Signature.svg',
                    width: 150.w,
                    height: 45.h,
                    color: AppColors.white,
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              height: 320.h,
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/Icons/twitter.svg',
                        width: 150.w,
                        height: 45.h,
                      ),
                      SizedBox(width: 30.h),
                      SvgPicture.asset(
                        'assets/Icons/Instagram.svg',
                        width: 150.w,
                        height: 45.h,
                      ),
                      SizedBox(width: 30.h),
                      SvgPicture.asset(
                        'assets/Icons/youtube.svg',
                        width: 150.w,
                        height: 45.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  SvgPicture.asset(
                    'assets/Icons/line.svg',
                    color: AppColors.black,
                  ),
                  SizedBox(height: 20.h),
                  Text("support@fashionstore", style: tSStyleBlack16400),
                  SizedBox(height: 20.h),
                  Text("+1 234 567 890", style: tSStyleBlack16400),
                  SizedBox(height: 20.h),
                  Text("08:00 - 20:00 - Everyday", style: tSStyleBlack16400),
                  SizedBox(height: 20.h),
                  SvgPicture.asset(
                    'assets/Icons/line.svg',
                    color: AppColors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text('About', style: tSStyleBlack16400)),
                      SizedBox(width: 30.w),
                      TextButton(
                          onPressed: () {},
                          child: Text('Contact', style: tSStyleBlack16400)),
                      SizedBox(width: 30.w),
                      TextButton(
                          onPressed: () {},
                          child: Text('Blog', style: tSStyleBlack16400)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50.h,
              color: AppColors.greylight,
              child: Center(
                child: Text(
                  'Designed by Fashionstore',
                  style: tSStyleBlack16400.copyWith(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
