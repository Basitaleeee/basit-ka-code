import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase dependency
import '../../Reusable/Button.dart';
import '../../Reusable/Custom Small Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import 'Add product 2.dart';
import 'Edit_Product.dart';
import 'HOME.dart';

class ProductReviewScreen extends StatelessWidget {
  late final String productId; // ID of the product to fetch from Firebase

   ProductReviewScreen({Key? key, required this.productId}) : super(key: key);

  String get images  => '';

  Future<Map<String, dynamic>?> fetchProductData() async {
    try {
      final doc =
      await FirebaseFirestore.instance.collection('products').doc(productId).get();
      if (doc.exists) {
        return doc.data(); // Return product data
      }
    } catch (e) {
      debugPrint('Error fetching product: $e');
    }
    return null; // Return null if not found
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchProductData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                'Failed to load product details',
                style: tSStyleBlack18400,
              ),
            );
          }

          final productData = snapshot.data!;
          final imageUrl; productId = productData['images'][0] ?? 'No image';
          final title = productData['name'] ?? 'Unknown Product';
          final category = productData['category'] ?? 'Unknown Category';
          final description = productData['description'] ?? 'No description available';
          final photographer = productData['photographer'] ?? 'Unknown Photographer';
          final colors = List<String>.from(productData['colors'] ?? []);
          final size = productData['size'] ?? 'N/A';
          final minOrderQty = productData['minOrderQuantity'] ?? '0';

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  Center(
                    child: Container(
                      height: 400.h,
                      width: 300.w,
                      child: images.isNotEmpty
                          ? Image.network(images, fit: BoxFit.cover)
                          : Icon(Icons.image_not_supported, size: 100),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('$title [$category]', style: tSStyleBlack18400),
                  SizedBox(height: 10.h),
                  Text(description,
                      style: tSStyleBlack18400.copyWith(
                          fontSize: 14.sp, color: AppColors.grey4)),
                  SizedBox(height: 20.h),

                  // Dynamic selected colors
                  Row(
                    children: [
                      Text('Color',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      ...colors
                          .map((color) => Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: CircleAvatar(
                          radius: 10.w,
                          backgroundColor: Color(int.parse(color)),
                        ),
                      ))
                          .toList(),
                      SizedBox(width: 50.w),
                      Text('Size',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      CircleAvatar(
                        radius: 10.w,
                        backgroundColor: AppColors.secondary,
                        child: Text(
                          size,
                          style: tSStyleBlack18400.copyWith(fontSize: 12.sp),
                        ),
                      ),
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
                            Text('Photographer Name: $photographer',
                                style: tSStyleBlack18400.copyWith(
                                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
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
                  SizedBox(height: 40.h),
                  // Minimum Order Quantity
                  Row(
                    children: [
                      Text('Minimum Order Quantity',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      Text('[ $minOrderQty ]',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  // Buttons
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductScreen(),
                        ),
                      );
                    },
                    text: 'EDIT',
                  ),
                  SizedBox(height: 20.h),
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    text: 'DONE',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
