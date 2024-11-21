import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Reusable/Fonts.dart';
import '../../Reusable/Text Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/app_images.dart';
import '../Signup.dart';

class CreateWithScreen extends StatefulWidget {
  const CreateWithScreen({super.key});

  @override
  _CreateWithScreenState createState() => _CreateWithScreenState();
}

class _CreateWithScreenState extends State<CreateWithScreen> {
  String selectedButton = '';

  void updateButtonSelection(String button) {
    setState(() {
      selectedButton = button;
    });
  }

  void navigateToSignup2(String role) {
    Navigator.pushNamed(context, 'Signup2', arguments: role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Wrap the entire body in a SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                AppImages.splash,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 40.0.h,
                horizontal: 24.0.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'CREATE WITH',
                      style: aStyleBlack48400,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 58.h,
                    child: ReusableTextButton(
                      icon: Icons.arrow_forward_outlined,
                      buttonText: 'DESIGNER',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup2(role: 'DESIGNER'),
                          ),
                        );
                      },
                      color: selectedButton == 'DESIGNER'
                          ? AppColors.secondary
                          : AppColors.greylight,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 58.h,
                    child: ReusableTextButton(
                      icon: Icons.arrow_forward_outlined,
                      buttonText: 'CUSTOMER',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Signup2(role: 'CUSTOMER'),
                          ),
                        );
                      },
                      color: selectedButton == 'CUSTOMER'
                          ? AppColors.secondary
                          : AppColors.greylight,
                    ),
                  ),
                  SizedBox(height: 20.h), // Add some extra space at the bottom
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
