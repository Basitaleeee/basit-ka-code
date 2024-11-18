import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Reusable/Fonts.dart';
import '../Reusable/Header.dart';
import '../Reusable/app_colors.dart';
import '../Reusable/reusable Text.dart';
import '../reusable/Text Button.dart';
import '../reusable/customText field.dart';
import 'DESIGNER View/Add product1 .dart';

class Signup2 extends StatefulWidget {
  final String role;

  const Signup2({Key? key, required this.role}) : super(key: key);

  @override
  State<Signup2> createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _signUp() async {
    if (_passwordController.text.trim() != _confirmPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User created successfully!"),
          backgroundColor: Colors.green,
        ),
      );

      String userId = userCredential.user!.uid;
      await _firestore.collection('users').doc(userId).set({
        'fullName': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': _phoneController.text.trim(),
        'role': widget.role.toUpperCase(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirstScreen()),
      );
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to sign up: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeader(
                title: "SIGN UP",
                subtitle: "Already have an account? Login",
                linkText: "Login",
                onLinkTap: () {
                  Navigator.pop(context);
                },
                titleStyle: aStyleBlack32400.copyWith(
                  color: Colors.white,
                  fontSize: screenWidth * 0.11,
                  fontWeight: FontWeight.bold,
                ),
                subtitleStyle: tSStyleBlack18400.copyWith(
                  color: Colors.white,
                  fontSize: screenWidth * 0.03,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CustomTextField(
                      label: "Full Name",
                      controller: _fullNameController,
                      obscureText: false,
                      suffixIcon: null, labelText: 'Full Name',
                    ),

                    CustomTextField(
                      label: "Email",
                      controller: _emailController,
                      labelText: 'Email',
                      obscureText: false,
                      suffixIcon: null,
                    ),
                    CustomTextField(
                      label: "Phone Number",
                      controller: _phoneController,
                      labelText: 'Phone Number',
                      obscureText: false,
                      suffixIcon: null,
                    ),
                    CustomTextField(
                      label: "Password",
                      controller: _passwordController,
                      obscureText: true,
                      suffixIcon: Icon(Icons.visibility),
                      labelText: 'Password',
                    ),
                    CustomTextField(
                      label: "Confirm Password",
                      controller: _confirmPasswordController,
                      obscureText: true,
                      suffixIcon: Icon(Icons.visibility),
                      labelText: 'Confirm Password',
                    ),
                    SizedBox(height: screenHeight * 0.03), // Responsive spacing
                    ReusableTextButton(
                      buttonText: "SIGNUP NOW!",
                      onPressed: _signUp,
                      backgroundColor: AppColors.secondary,
                      icon: Icons.arrow_forward,
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
