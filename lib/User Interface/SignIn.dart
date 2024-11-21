import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Reusable/Fonts.dart';
import '../Reusable/app_colors.dart';
import '../reusable/Header.dart';
import '../reusable/customText field.dart';
import '../reusable/divider.dart';
import '../reusable/error message.dart';
import '../reusable/Button.dart';
import 'Admin/Dashboard Screen.dart';
import 'Customer View/Home Screen.dart';
import 'DESIGNER View/HOME.dart';
import 'DESIGNER View/Forgot_password.dart';
import 'DESIGNER View/Role Assign.dart';

class Lookbook1 extends StatefulWidget {
  Lookbook1({super.key});

  @override
  State<Lookbook1> createState() => Lookbook1state();
}

class Lookbook1state extends State<Lookbook1> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  String _errorMessage = '';
  bool _isPasswordVisible = false;

  // Firebase sign-in function with role-based redirection
  Future<void> signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (userCredential.user != null) {
        // Fetch user role from Firestore
        var userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .get();

        String role = userDoc['role'] ?? '';

        if (role.isEmpty) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Role not assigned to user';
          });
          return;
        }

        // Save role to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', role);

        // Redirect based on role
        if (role == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else if (role == 'CUSTOMER') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
          );
        } else if (role == 'DESIGNER') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Invalid role assigned';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Authentication failed. Please check your credentials.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: ${e.toString()}';
      });
      print('Error in sign-in: ${e.toString()}');
    }
  }


  // Google Sign-In
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Create a new credential
      OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Fetch user role from Firestore
        var userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .get();

        String role = userDoc['role'] ?? ''; // Safely get the role

        if (role.isEmpty) {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Role not assigned to user';
          });
          return;
        }

        // Redirect based on role
        if (role == 'Admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
        } else if (role == 'CUSTOMER') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomerHomeScreen()),
          );
        } else if (role == 'DESIGNER') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Invalid role assigned';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Authentication failed. Please check your credentials.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: ${e.toString()}';
      });
      print('Error in Google sign-in: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              AuthHeader(
                title: "LOGIN ACCOUNT",
                subtitle: "Don't have an account? Sign up",
                linkText: "Sign up",
                onLinkTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateWithScreen()), // Replace with actual screen
                  );
                },
                titleStyle: aStyleBlack32400.copyWith(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      labelText: "Email",
                      obscureText: false,
                      suffixIcon: null, hintText: 'Email',

                    ),
                    CustomTextField(
                      controller: passwordController,
                      labelText: "Password",
                      obscureText: !_isPasswordVisible,  // Toggle visibility based on the state
                      suffixIcon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.primaryColor,
                        size: 20,
                      ), hintText: 'Password',
                    ),
                    ErrorMessage(errorText: _errorMessage),
                    RoundedButton(
                      text: "LOGIN NOW!",
                      isLoading: _isLoading,
                      onPressed: signIn,
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 150.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.greylight),
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.transparent,
                      ),
                      child: GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: tSStyleBlack14400.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        onTap: () {
                          showForgotPasswordBottomSheet(context);
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    OrDivider(),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google login
                        IconButton(
                          icon: SvgPicture.asset(
                            'assets/Icons/GoogleLogo.svg',
                            width: 24,
                            height: 24,
                          ),
                          onPressed: _signInWithGoogle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
