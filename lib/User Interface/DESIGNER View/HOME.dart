import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/products%20detail.dart';
import '../../Reusable/Bottom Navgation Bar.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Product Card.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/mere reusable.dart';
import '../Customer View/Logout Screen.dart';
import 'Add product 2.dart';
import 'Chat Screen.dart';
import 'Notification Screen.dart';
import 'Product Review.dart';
import 'Profile Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    NotificationScreen(),
    ProfileScreen(),
  ];


  Future<List<Map<String, dynamic>>> fetchProducts() async {

    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('products').get();
    List<Map<String, dynamic>> productsList = snapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
    return productsList;
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      // Already on HomeScreen, so do nothing
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _screens[index - 1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            CombinedTextWithLineWidget(text: 'HOME', fontSize: 15),
            SizedBox(height: 20.h),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child:  Text(
                      'NO PRODUCTS TO SHOW',
                      style: tSStyleBlack16400,
                    ),);
                  }

                  List<Map<String, dynamic>> products = snapshot.data!;

                  return GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 5.h,
                      childAspectRatio: 0.60,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard2(
                        imagePath: products[index]['images'][0] ?? 'No image',
                        title: products[index]['name'] ?? 'No Title',
                        subtitle: products[index]['description'] ?? 'No Description',
                        price: '\$${products[index]['price'] ?? '0'}',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Productdetails1(
                                  productId: products[index]
                                  ['productId'] ??
                                      'no product ID',
                                )),
                          );
                        }, imageUrl: products[index]['images'][0] ?? 'No image',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 71.w,
        height: 71.h,
        child: FloatingActionButton(
    onPressed: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AddProductScreen()),
    );},
          elevation: 8.0,
          backgroundColor: AppColors.secondary,
          shape: const CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: 40.sp),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: MyCustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
