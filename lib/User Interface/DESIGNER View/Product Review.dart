import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Custom Small Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/Fonts.dart';
import 'Add product 2.dart';
import 'Edit_Product.dart';
import 'HOME.dart';

class ProductReviewScreen extends StatelessWidget {
  final String? productId;

  ProductReviewScreen({required this.productId});

  Future<Map<String, dynamic>> fetchProductDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get();

    return snapshot.data() as Map<String, dynamic>;
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No product details found.'));
          }

          Map<String, dynamic> product = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Center(
                    child: Container(
                      height: 400.h,
                      width: 300.w,
                      child: product['images'] != null && product['images'].isNotEmpty
                          ? Image.network(product['images'][0]) // Display product image
                          : Icon(Icons.image_not_supported, size: 100), // Placeholder
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Product Name & Category
                  Text('${product['name']} [${product['category']}]', style: tSStyleBlack18400),
                  SizedBox(height: 10.h),

                  // Product Description
                  Text(
                    product['description'] ?? 'No description available.',
                      style: tSStyleBlack10400.copyWith(
                        fontSize: 14.sp
                      )
                  ),
                  SizedBox(height: 20.h),

                  // Color & Size Options
                  Row(
                    children: [
                      Text('Color', style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      CircleAvatar(
                        radius: 10.w,
                        backgroundColor: AppColors.secondary,
                      ),
                      SizedBox(width: 50.w),
                      Text('Size', style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      CircleAvatar(
                        radius: 10.w,
                        backgroundColor: AppColors.secondary,
                        child: Text('M', style: tSStyleBlack18400.copyWith(fontSize: 12.sp)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Minimum Order Quantity
                  Row(
                    children: [
                      Text('Minimum Order Quantity', style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      Text('[ ${product['quantity'] ?? 'N/A'} ]', style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Photographer Info
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.w,
                          backgroundImage: NetworkImage('https://picsum.photos/200/300'), // Placeholder
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['photographerName'] ?? 'No Photographer',
                              style: tSStyleBlack18400.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5.h),
                            CustomSmallButton(
                              text: 'Edit',
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Edit & Done Buttons
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProductScreen(productId: productId ?? '')),
                      );
                    },
                    text: 'EDIT',
                  ),
                  SizedBox(height: 20.h),
                  Center(child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(350.w, 40.h),
                        backgroundColor: AppColors.white,
                        foregroundColor: AppColors.secondary,

                         //backgroundColor: buttonController.isButtonEnabled ? AppColors.primaryColor : AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                          side: BorderSide(
                            color: AppColors.secondary,
                            width: 1.0,
                          ),
                        ),

                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }, child: Text('DONE',style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold
                  ),))),
                  SizedBox(height: 150.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
