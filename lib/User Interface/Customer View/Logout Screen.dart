import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Dropdownfield.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';

class AboutScreen extends StatelessWidget {
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About section
            Text(
              "About Fashion Concierge",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary // Customize to your app's color scheme
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.\n\n"
                  "The User is the primary end-user of the application. This role represents the general audience for whom the app’s features and services are designed.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Language selection dropdown
            CustomDropdownField(
              controller: _categoryController,
              labelText: "Select Language",
              items: ['English', 'Spanish', 'French'],
            ),
            Spacer(),
            // Logout button
            ElevatedButton(
                onPressed: () {
                  // Add logout functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary, // Customize to your app's color scheme
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("LOGOUT",
                    style: tSStyleBlack18400.copyWith(color: Colors.white)),

              ),

          ],
        ),
      ),
    );
  }
}
