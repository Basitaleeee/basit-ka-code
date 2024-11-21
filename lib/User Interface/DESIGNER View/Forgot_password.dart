import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Reusable/Fonts.dart';
import '../../reusable/customText field.dart';
import '../../reusable/Button.dart';
import '../../reusable/error message.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'FORGOT PASSWORD',
            style:aStyleBlack28800.copyWith(fontSize: 26
                ,
            fontWeight: FontWeight.bold
            ),
          ),
          Text(
            'Enter your email for the verification proccess. \n'
              'we will send 4 digits code to your email.',
            style:tSStyleBlack16400.copyWith(
              fontSize: 14
            )
            ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: emailController,
            labelText: "Email",
            obscureText: false,
            suffixIcon: Icon(Icons.email, color: Colors.grey), hintText: 'Email',

          ),
          ErrorMessage(errorText: _errorMessage),
          SizedBox(height: screenHeight * 0.02),
          RoundedButton(
            text: "CONTINUE",
            isLoading: _isLoading,
            onPressed: _sendPasswordResetEmail,
          ),
        ],
      ),
    );
  }
}

// Function to display the Forgot Password screen as a bottom sheet
void showForgotPasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets, // Adjust for keyboard
        child: ForgotPasswordScreen(),
      );
    },
  );
}
