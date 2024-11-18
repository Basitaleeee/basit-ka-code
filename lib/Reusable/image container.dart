import 'package:flutter/material.dart';

class ReusableImageContainer extends StatelessWidget {
  final double height;
  final String imagePath;
  final List<Color> gradientColors;

  const ReusableImageContainer({
    Key? key,
    required this.height,
    required this.imagePath,
    required this.gradientColors,
    Color backgroundColor = Colors.transparent,
    Column child = const Column(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
