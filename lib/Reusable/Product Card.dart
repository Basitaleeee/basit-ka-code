import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/app_colors.dart';
import 'Fonts.dart';

class ProductCardWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String subtitle;
  final String price;

  const ProductCardWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.subtitle,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 150.h,
            width: 180.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl) // Use network image if URL is available
                    : AssetImage('assets/Images/placeholder.png') as ImageProvider, // Fallback to placeholder
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: Column(
              children: [
                Text(
                  title,
                  style: tSStyleBlack16400.copyWith(fontSize: 13.sp, color: AppColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: tSStyleBlack16400.copyWith(fontSize: 12.sp, color: AppColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  price,
                  style: tSStyleBlack16400.copyWith(fontSize: 16.sp, color: AppColors.secondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
