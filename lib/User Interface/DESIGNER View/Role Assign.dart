import 'package:flutter/material.dart';
import '../../Reusable/Fonts.dart';
import '../../reusable/Text Button.dart';
import '../../reusable/image container.dart';
import '../Signup.dart';

class Rolescreen extends StatefulWidget {
  Rolescreen({super.key});

  @override
  State<Rolescreen> createState() => _RolescreenState();
}

class _RolescreenState extends State<Rolescreen> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReusableImageContainer(
                height: screenHeight * 0.4,
                imagePath: "assets/Images/splash.png",
                gradientColors: [Colors.blue, Colors.red],
                backgroundColor: Colors.transparent,
                child: const Column(),
              ),
              SizedBox(height: screenHeight * 0.09),
              Text(
                "CREATE WITH",
                style: aStyleBlack32400.copyWith(
                  fontSize: screenWidth * 0.1,
                  fontWeight: FontWeight.bold,
                )
              ),
              SizedBox(height: screenHeight * 0.03),
              ReusableTextButton(
                buttonText: "DESIGNER",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup2(role: 'DESIGNER'),
                    ),
                  );
                },
                backgroundColor: null,
                icon: Icons.arrow_forward,

              ),
              SizedBox(height: screenHeight * 0.02),
              ReusableTextButton(
                buttonText: "CUSTOMER",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup2(role: 'CUSTOMER'),
                    ),
                  );
                },
                backgroundColor: null,
                icon: Icons.arrow_forward,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
