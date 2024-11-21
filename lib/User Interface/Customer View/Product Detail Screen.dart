import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Custom Small Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../reusable/Text Button.dart';

class CustomerReviewScreen extends StatelessWidget {
  const CustomerReviewScreen({Key? key}) : super(key: key);

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CombinedTextWithLineWidget(text: 'PRODUCT DETAIL', fontSize: 15),

              SizedBox(height: 20.h),
              // Static Image
              Center(
                child: Container(
                  height: 400.h,
                  width: 300.w,
                  child: Image.asset('assets/Images/product1.png'),
                ),
              ),

              SizedBox(height: 20.h),
              Text('Elegant Red Dress [DRESS]', style: tSStyleBlack18400),

              SizedBox(height: 10.h),
              Text('This is the best one ',
                  style: tSStyleBlack18400.copyWith(
                      fontSize: 14.sp, color: AppColors.grey4)), // Static text

              SizedBox(height: 20.h),

              // Static Selected Colors
              Row(
                children: [
                  Text('Color',
                      style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 10.w,
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 10.w,
                    backgroundColor: Colors.black, // Static color
                  ),
                  SizedBox(width: 50.w),
                  Text('Size',
                      style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                  SizedBox(width: 10.w),
                  CircleAvatar(
                    radius: 10.w,
                    backgroundColor: AppColors.secondary,
                    child: Text(
                      'M', // Static size
                      style: tSStyleBlack18400.copyWith(fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              // Static Minimum Order Quantity
              Row(
                children: [
                  Text('Minimum Order Quantity',
                      style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                  SizedBox(width: 10.w),
                  Text('[ 20 ]',
                      style: tSStyleBlack18400.copyWith(fontSize: 16.sp)),
                ],
              ),

              SizedBox(height: 20.h),
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.w,
                      backgroundImage:
                      NetworkImage('https://picsum.photos/200/300'),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Photographer NAME [John Doe]',
                            style: tSStyleBlack18400.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        CustomSmallButton(
                          height: 30,
                          text: 'VIEW',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )

                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.w,
                      backgroundImage:
                      NetworkImage('https://picsum.photos/200/300'),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('DESIGNER NAME[John Doe]',
                            style: tSStyleBlack18400.copyWith(
                                fontSize: 16.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5.h),
                        CustomSmallButton(
                          height: 30,
                          text: 'VIEW',

                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )

                      ],
                    ),
                  ],
                ),
              ),


              SizedBox(height: 30.h),

              // Custom Buttons
              RoundedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddProductScreen(),
                  //   ),
                  // );
                },
                text: 'REMOVE FROM HOME  ',
              ),

              SizedBox(height: 20.h),
              CustomSmallButton(
                color: Colors.red,
                height: 50,
                width: 150,
                text: "REPORT",
                onPressed: () {
                  // // Navigator.push(
                  // //   context,
                  // //   MaterialPageRoute(
                  // //     builder: (context) => AddProductScreen(),
                  // //   ),
                  // );
                },

              ),
              SizedBox(height: 80.h),

            ],
          ),
        ),
      ),
    );
  }
}
