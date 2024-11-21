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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image Container
            Flexible(
              child: Container(
                height: 150.h,
                width: 180.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : AssetImage('assets/Images/placeholder.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Content Container
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: tSStyleBlack16400.copyWith(
                        fontSize: 13.sp,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Subtitle
                    Text(
                      subtitle,
                      style: tSStyleBlack16400.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Price
                    Text(
                      price,
                      style: tSStyleBlack16400.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.secondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
