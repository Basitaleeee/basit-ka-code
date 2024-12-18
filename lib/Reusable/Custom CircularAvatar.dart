import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Fonts.dart';
import 'app_colors.dart';

class CustomContainerWidget extends StatefulWidget {
  final List<String> sizeLabels;

  const CustomContainerWidget({
    Key? key,
    required this.sizeLabels, // Pass labels for avatars dynamically
  }) : super(key: key);

  @override
  _CustomContainerWidgetState createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  String _selectedSize = ''; // Track the selected size

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.r),
        border: Border.all(color: AppColors.greylight),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10.w),
        child: Row(
          children: widget.sizeLabels.map((label) => _buildSizeAvatar(label)).toList(),
        ),
      ),
    );
  }

  Widget _buildSizeAvatar(String label) {
    final bool isSelected = _selectedSize == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSize = label; // Update the selected size
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10.w),
        child: CircleAvatar(
          radius: 11.r,
          backgroundColor: isSelected ? AppColors.primaryColor : AppColors.grey4,
          child: CircleAvatar(
            radius: 10.r,
            backgroundColor: Colors.white,
            child: Center(
              child: Text(
                label,
                style: tSStyleBlack18400.copyWith(
                  fontSize: 13.sp,
                  color: isSelected ? Colors.black: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
