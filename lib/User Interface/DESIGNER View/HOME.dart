import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/products%20detail.dart';
import '../../Reusable/Bottom Navgation Bar.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Product Card.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/mere reusable.dart';
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
    ChatScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  // Fetch products from Firebase
  Future<List<Map<String, dynamic>>> fetchProducts() async {
    // Fetching data from Firestore (Assuming you have a 'products' collection)
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
                    return Center(child: Text('No products found'));
                  }

                  List<Map<String, dynamic>> products = snapshot.data!;

                  return GridView.builder(
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
                              builder: (context) => Productdetails1(
                                productId: products[index]['productId'] ?? 'no product ID',
                              )
                            ),
                          );
                        },
                        child: ProductCardWidget(
                          title: products[index]['name'] ?? 'No Title',
                          subtitle: products[index]['description'] ?? 'No Description',
                          price: '\$${products[index]['price'] ?? '0'}',
                          imageUrl: products[index]['images'][0] ?? 'No image',
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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen()),
          );
        },
        backgroundColor: AppColors.secondary,
        child: Icon(Icons.add, color: Colors.white, size: 30.sp),
      ),
      bottomNavigationBar: MyCustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
