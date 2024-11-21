import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Models/photographer.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Custom Small Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_images.dart';
import 'Add product 2.dart';
import 'Edit_Product.dart';
import 'HOME.dart';
import 'PhotographerProfileScreen.dart';

class Productdetails1 extends StatelessWidget {
  final String? productId;

  Productdetails1({required this.productId});

  Future<Map<String, dynamic>> fetchProductDetails() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .get();

    return snapshot.data() as Map<String, dynamic>;
  }

  Future<List<Map<String, dynamic>>> fetchPhotographers() async {
    QuerySnapshot photographersSnapshot = await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .collection('photographers')
        .get();

    return photographersSnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
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
                  SizedBox(
                    height: 72.h,
                    width: 430.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'P R O D U C T  D E T A I L S',
                          style: tSStyleBlack18400,
                        ),
                        SvgPicture.asset(
                          AppImages.line,
                          color: AppColors.text1,
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 400.h,
                      width: double.infinity,
                      child: product['images'] != null &&
                          product['images'].isNotEmpty
                          ? Image.network(
                          product['images'][0]) // Display product image
                          : Icon(Icons.image_not_supported,
                          size: 100), // Placeholder
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text('${product['name']} [${product['category']}]',
                      style: tSStyleBlack16600),
                  SizedBox(height: 10.h),
                  Text(
                    product['description'] ?? 'No description available.',
                    style: tSStyleBlack16400.copyWith(color: AppColors.text1),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 10.h),
                  //price
                  Text(
                    product['price'] ?? 'No price available.',
                    style: tSStyleBlack20400.copyWith(
                        color: AppColors.secondary),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text('Color',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      CircleAvatar(
                        radius: 10.w,
                        backgroundColor: AppColors.black,
                      ),
                      SizedBox(width: 50.w),
                      Text('Size',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      SizedBox(width: 10.w),
                      CircleAvatar(
                        radius: 10.w,
                        backgroundColor: AppColors.black,
                        child: Text('M',
                            style: tSStyleBlack18400.copyWith(
                                fontSize: 12.sp, color: Colors.white)),
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
                  Column(
                    children: [
                      Text('[ ${product['socialLinks'] ?? 'N/A'} ]',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      Text('[ ${product['socialLinks'] ?? 'N/A'} ]',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                      Text('[ ${product['socialLinks'] ?? 'N/A'} ]',
                          style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Fetch photographers dynamically
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: fetchPhotographers(),
                    builder: (context, photographersSnapshot) {
                      if (photographersSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (photographersSnapshot.hasError) {
                        return Center(
                            child: Text(
                                'Error fetching photographers: ${photographersSnapshot
                                    .error}'));
                      }

                      List<Map<String, dynamic>> photographers =
                          photographersSnapshot.data ?? [];

                      if (photographers.isEmpty) {
                        return Text(
                          'No photographers available.',
                          style: tSStyleBlack18400.copyWith(
                            fontSize: 14.sp,
                            color: AppColors.grey4,
                          ),
                        );
                      }

                      return SingleChildScrollView(
                        child: Column(
                          children: photographers.map((photographer) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              // Optional padding between photographer rows
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.w,
                                    backgroundImage: NetworkImage(
                                        photographer['imageUrl'] ??
                                            'https://via.placeholder.com/150'),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("PHOTOGRAPHER NAME: ",
                                              style: tSStyleBlack18400.copyWith(
                                                  fontSize: 16.sp)),
                                          Text(
                                            photographer['name'] ??
                                                'No Photographer Name',
                                            style: tSStyleBlack18400.copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      CustomSmallButton(
                                        text: 'VIEW',
                                        onPressed: () {
                                          // showPhotographerBottomSheet(
                                          //     context, photographer);
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 30.h),
                  RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProductScreen(productId: productId ?? '')),
                      );
                    },
                    text: 'EDIT',
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// void showPhotographerBottomSheet(BuildContext context, Map<String, dynamic> photographer) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true, // Allows the bottom sheet to expand based on content size
//     builder: (BuildContext context) {
//       // Extract data from photographer
//       String name = photographer['name'] ?? 'Unknown';
//       String imageUrl = photographer['imageUrl'] ?? 'https://via.placeholder.com/150';
//       String about = photographer['about'] ?? 'No information available.';
//       return PhotographerProfileScreen(
//         photographer: PhotographerModel(
//           name: name,
//           imageUrl: imageUrl, // Assumes 'images' is a list
//           about: about, email: 'email', phone: 'phone', socialLinks: 'socialLinks',
//         ),
//       );
//     },
//   );
// }
}

