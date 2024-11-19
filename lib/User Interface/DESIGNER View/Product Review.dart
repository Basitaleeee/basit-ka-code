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
    print(productId);
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
                  Text('${product['name']} [${product['category']}]',
                      style: tSStyleBlack18400),
                  SizedBox(height: 10.h),
                  Text(
                    product['description'] ?? 'No description available.',
                    style: tSStyleBlack18400.copyWith(
                      fontSize: 14.sp,
                      color: AppColors.grey4,
                    ),
                  ),
                  SizedBox(height: 20.h),
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
                        child: Text('M',
                            style: tSStyleBlack18400.copyWith(fontSize: 12.sp)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text('Minimum Order Quantity',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      Text('[ ${product['quantity'] ?? 'N/A'} ]',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.w,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/200/300'), // Placeholder
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
                              icon: Icons.arrow_forward_outlined,
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
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProductScreen(productId: productId?? '')),
                      );
                    },
                    text: 'EDIT',
                  ),
                  SizedBox(height: 20.h),
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    text: 'DONE',
                  ),
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
