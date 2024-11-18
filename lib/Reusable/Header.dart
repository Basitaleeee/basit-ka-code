import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Fonts.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String linkText;
  final VoidCallback onLinkTap;
  final TextStyle? titleStyle; // New parameter for title text style
  final TextStyle? subtitleStyle; // New parameter for subtitle text style

  const AuthHeader({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.linkText,
    required this.onLinkTap,
    this.titleStyle, // Optional title text style
    this.subtitleStyle, // Optional subtitle text style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      height: screenHeight * 0.35,
      width:double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.04,
          right: screenWidth * 0.07,
          top: screenHeight * 0.15,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.start,
           // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start
            ,
            children: [
              Text(
                title,
                style: titleStyle ??
                    aStyleBlack32400.copyWith(
                      color: Colors.white,
                      fontSize: screenWidth * 0.11,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.75,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Text(
                        subtitle,
                        style: subtitleStyle ??
                            tSStyleBlack18400.copyWith(
                              color: Colors.white,
                              fontSize: screenWidth * 0.035,
                            ),
                      ), SizedBox(),
                      // const Spacer(),
                      IconButton(
                        onPressed: onLinkTap,
                        icon:  Icon(Icons.arrow_forward_outlined, color: Colors.white,
                            size: 18.0

                        ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
