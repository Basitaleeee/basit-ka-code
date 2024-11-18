import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Product Card.dart';
import '../../Reusable/app_colors.dart';
import '../DESIGNER View/Product Review.dart';

class SearchFilter extends StatefulWidget {
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  final List<Map<String, String>> products = [
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash1.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash2.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/images/product4.png'},
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Container(
                height: 50.h,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Filtered Result",
                style: tSStyleBlack16400.copyWith(
                    fontSize: 16.sp, color: AppColors.secondary),
              ),
              SizedBox(height: 10.h),
              CombinedTextWithLineWidget(text: 'TEAR SHOW', fontSize: 15),
              SizedBox(height: 20.h),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => PreviewProduct(),
                      //   ),
                      // );
                    },
                    child: ProductCardWidget(
                      title: products[index]['title']!,
                      // image: products[index]['image']!,
                      subtitle: 'Cardigan',
                      price: '\$120', imageUrl: '',
                    ),
                  );
                },
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 296.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 50.w),
                      child: Text(
                        'LOOK',
                        style: aStyleBlack18600.copyWith(color: Colors.white),
                      ),
                    ),
                    Text(
                      'BOOK',
                      style: aStyleBlack18600.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 15.h),
                    SizedBox(
                      height: 74.h,
                      width: 323.w,
                      child: Text(
                        'Making a luxurious lifestyle accessible for a generous group of women is our daily drive.',
                        style: tSStyleBlack16400.copyWith(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SvgPicture.asset(
                      'assets/Icons/line.svg',
                      color: AppColors.white,
                    ),
                    SizedBox(height: 20.h),
                    SvgPicture.asset(
                      'assets/Icons/Signature.svg',
                      width: 150.w,
                      height: 45.h,
                      color: AppColors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 320.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: const Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/Icons/twitter.svg',
                          width: 150.w,
                          height: 45.h,
                          //scolor: AppColors.white,
                        ),
                        SizedBox(width: 30.h),
                        SvgPicture.asset(
                          'assets/Icons/Instagram.svg',
                          width: 150.w,
                          height: 45.h,
                          //color: AppColors.white,
                        ),
                        SizedBox(width: 30.h),
                        SvgPicture.asset(
                          'assets/Icons/youtube.svg',
                          width: 150.w,
                          height: 45.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SvgPicture.asset(
                      'assets/Icons/line.svg',
                      color: AppColors.black,
                    ),
                    SizedBox(height: 20.h),
                    Text("support@fashionstore", style: tSStyleBlack16400),
                    SizedBox(height: 20.h),
                    Text("+1 234 567 890", style: tSStyleBlack16400),
                    SizedBox(height: 20.h),
                    Text("08:00 - 20:00 - Everyday", style: tSStyleBlack16400),
                    SizedBox(height: 20.h),
                    SvgPicture.asset(
                      'assets/Icons/line.svg',
                      color: AppColors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {},
                            child: Text('About', style: tSStyleBlack16400)),
                        SizedBox(width: 30.w),
                        TextButton(
                            onPressed: () {},
                            child: Text('Contact', style: tSStyleBlack16400)),
                        SizedBox(width: 30.w),
                        TextButton(
                            onPressed: () {},
                            child: Text('Blog', style: tSStyleBlack16400)),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 50.h,
                color: AppColors.greylight,
                child: Center(
                  child: Text(
                    ' Designed by Fashionstore',
                    style: tSStyleBlack16400.copyWith(color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
