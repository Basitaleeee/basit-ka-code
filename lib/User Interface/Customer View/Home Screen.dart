import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Customer bottom bar.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Product Card.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/mere reusable.dart';
import '../DESIGNER View/Product Review.dart';
import '../DESIGNER View/products detail.dart';
import 'Customer Notification Screen.dart';
import 'Customer SMS screen.dart';
import 'Customer Profile Screen.dart';
import 'Event_sheet.dart';
import 'Logout Screen.dart';
import 'Product Detail Screen.dart';
import 'Scan Barcode.dart';

class CustomerHomeScreen extends StatefulWidget {
  @override
  _CustomerHomeScreenState createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection('products').get();
      return snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

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
        appBar: _buildAppBar(),
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

  AppBar _buildAppBar() {
    return AppBar(
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
        icon: SvgPicture.asset('assets/Icons/Menu.svg'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutScreen()),
          );
        },
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
            _buildSearchBar(),
            SizedBox(height: 20.h),
            _buildProductGrid(),
            SizedBox(height: 20.h),
            _buildMissionSection(),
            SizedBox(height: 20.h),
            _buildFooter(),
            _buildFooterBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
    );
  }

  Widget _buildProductGrid() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Failed to load products.'),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'NO PRODUCTS TO SHOW',
              style: tSStyleBlack16400,
            ),
          );
        }

        List<Map<String, dynamic>> products = snapshot.data!;
        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 5.h,
            childAspectRatio: 0.60,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            String imagePath = (products[index]['images'] as List?)?.first ?? 'No image';
            return ProductCard2(
              imagePath: imagePath,
              title: products[index]['name'] ?? 'No Title',
              subtitle: products[index]['description'] ?? 'No Description',
              price: '\$${products[index]['price'] ?? '0'}',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Productdetails1(
                      productId: products[index]['productId'] ?? 'no product ID',
                    ),
                  ),
                );
              },
              imageUrl: imagePath,
            );
          },
        );
      },
    );
  }

  Widget _buildMissionSection() {
    return Container(
      width: double.infinity,
      height: 296.h,
      decoration: BoxDecoration(color: AppColors.primaryColor),
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
          SvgPicture.asset('assets/Icons/line.svg', color: AppColors.white),
          SizedBox(height: 20.h),
          SvgPicture.asset('assets/Icons/Signature.svg', width: 150.w, height: 45.h, color: AppColors.white),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      height: 320.h,
      decoration: BoxDecoration(color: AppColors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/Icons/twitter.svg', width: 150.w, height: 45.h),
              SizedBox(width: 30.h),
              SvgPicture.asset('assets/Icons/Instagram.svg', width: 150.w, height: 45.h),
              SizedBox(width: 30.h),
              SvgPicture.asset('assets/Icons/youtube.svg', width: 150.w, height: 45.h),
            ],
          ),
          SizedBox(height: 20.h),
          SvgPicture.asset('assets/Icons/line.svg', color: AppColors.black),
          SizedBox(height: 20.h),
          Text("support@fashionstore", style: tSStyleBlack16400),
          SizedBox(height: 20.h),
          Text("+1 234 567 890", style: tSStyleBlack16400),
          SizedBox(height: 20.h),
          Text(
            "Fashion Store @2024. All Rights Reserved.",
            style: tSStyleBlack16400,
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBar() {
    return Container(
      height: 64.h,
      width: double.infinity,
      color: AppColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'About',
            style: tSStyleBlack16400.copyWith(color: Colors.black),
          ),
          SizedBox(width: 50.w),
          Text(
            'Contact',
            style: tSStyleBlack16400.copyWith(color: Colors.black),
          ),
          SizedBox(width: 50.w),
          Text(
            'Blog',
            style: tSStyleBlack16400.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
