import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';

class Reportscreen extends StatelessWidget {
  Reportscreen({Key? key}) : super(key: key);

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
     // ProductCardWidget(title: , image: Image.asset('assets/Images/product1.png'), subtitle: subtitle, price: price,),
    ],
    )
    ),
    ),
    );
  }
}