import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/photographer.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/product_provider/product.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/social_page.dart';
import 'package:provider/provider.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Dropdownfield.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Image_picker.dart';
import '../../Reusable/Text Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/customText field.dart';
import '../../Reusable/description textfield.dart';
import 'Product Review.dart';

import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String getInitials(String name) {
      List<String> nameParts = name.split(' ');
      if (nameParts.length >= 2) {
        return nameParts[0][0] + nameParts[1][0];
      } else if (nameParts.isNotEmpty) {
        return nameParts[0][0];
      }
      return '';
    }

    return SafeArea(
      child: Scaffold(
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
            icon: Icon(Icons.arrow_back ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 26.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child:
                  CombinedTextWithLineWidget(text: 'PROFILE', fontSize: 15),
                ),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/line.svg', // Replace with your asset path
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 70.h),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20.0.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.0.w,
                              right: 10.0.w,
                              top: 100.0.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextField(
                                  text: 'Name',
                                  toHide: false,
                                  suffixIcon:
                                  'assets/Icons/UpdateProfileIcon.svg',
                                  optionalSvgIcon:
                                  '', // Replace with your asset path
                                ),
                                SizedBox(height: 15.h),
                                CustomTextField(
                                  text: 'Email',
                                  toHide: false,
                                  optionalSvgIcon: '',
                                  suffixIcon:
                                  'assets/Icons/UpdateProfileIcon.svg', // Replace with your asset path
                                ),
                                SizedBox(height: 15.h),
                                CustomTextField(
                                  text: 'Phone',
                                  toHide: false,
                                  optionalSvgIcon: '',
                                  suffixIcon:
                                  'assets/Icons/UpdateProfileIcon.svg',
                                  // Replace with your asset path
                                ),
                                SizedBox(height: 15.h),
                                CustomTextField(
                                  text: 'Password',
                                  toHide: false,
                                  optionalSvgIcon: '',
                                  suffixIcon:
                                  'assets/Icons/UpdateProfileIcon.svg',
                                  // Replace with your asset path
                                ),
                                SizedBox(height: 15.h),
                                CustomTextField(
                                  text: 'Instagram',
                                  toHide: false,
                                  optionalSvgIcon: '',
                                  suffixIcon:
                                  'assets/Icons/UpdateProfileIcon.svg',
                                  // Replace with your asset path
                                ), SizedBox(height: 15.h),
                                CustomTextField(
                                  text: 'Linkdin',
                                  toHide: false,
                                  optionalSvgIcon: '',
                                  suffixIcon:
                                  'assets/Icons/UpdateProfileIcon.svg',
                                  // Replace with your asset path
                                ),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    Text('Add Social Links', style: tSStyleBlack18400.copyWith(fontSize: 15.sp)),
                                    GestureDetector(
                                      onTap: () {
                                        showSocialLinksBottomSheet(context);
                                      },
                                      child: Icon(Icons.add_circle_outline, color: AppColors.secondary, size: 20.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h),
                                SizedBox(
                                    height: 50,
                                    child: RoundedButton(
                                      text: 'UPDATE',
                                      onPressed: () {},
                                    )),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -45.h,
                        left: MediaQuery.of(context).size.width * 0.5 - 70.w,
                        child: Center(
                            child: CircleAvatar(
                              radius: 60.0.r,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              backgroundImage: AssetImage(
                                'assets/Images/splash.png', // Replace with your asset path
                              ),
                            )),
                      ),
                      Positioned(
                        top: 40.h,
                        left: MediaQuery.of(context).size.width * 0.5 + 15.w,
                        child: Container(
                          height: 30.0.h,
                          width: 30.0.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0.r),
                          ),
                          child: IconButton(
                            icon: SvgPicture.asset(
                              'assets/Icons/UpdateProfileIcon.svg',
                              width: 50.w,
                              height: 50.h,
                            ),
                            onPressed: () {
                              // Add your upload logic here
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String text;
  final bool toHide;
  final String optionalSvgIcon;

  final dynamic suffixIcon;

  const CustomTextField({
    Key? key,
    required this.text,
    required this.toHide,
    required this.suffixIcon,
    required this.optionalSvgIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: text,

        // labelText: text,
        prefixIcon: optionalSvgIcon.isNotEmpty
            ? SvgPicture.asset(optionalSvgIcon)
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      obscureText: toHide,
    );
  }
}
