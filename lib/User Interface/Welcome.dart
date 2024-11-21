import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import the AutoSizeText package
import '../Reusable/Fonts.dart';
import '../Reusable/app_colors.dart';
import 'SignIn.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      'assets/Images/splash.png',
      'assets/Images/splash1.png',
      'assets/Images/splash2.png',
    ];
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CarouselSlider(
            items: imageList.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: screenWidth,
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: screenHeight,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              autoPlayInterval: Duration(seconds: 6),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            top: screenHeight * 0.68,
            left: screenWidth * 0.05,
            child: Text(
              "FASHION",
              style: aStyleBlack48400.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.78,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            child: AutoSizeText(
              "Discover the latest trends, styles and exclusive collections",
              style: tSStyleBlack18400.copyWith(
                color: AppColors.white,
              ),

              maxLines: 2,
              minFontSize: 12,
              maxFontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.05,
            right: screenWidth * 0.05,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.01,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Lookbook1()),
                );
              },
              child: Text(
                "Continue",
                style: tSStyleBlack18400.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight * 0.04,
            left: screenWidth * 0.05,
            child: AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: imageList.length,
              effect: ExpandingDotsEffect(
                activeDotColor: AppColors.secondary,
                dotColor: Colors.white,
                dotHeight: 10,
                dotWidth: 10,
                expansionFactor: 4,
                spacing: 8.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
