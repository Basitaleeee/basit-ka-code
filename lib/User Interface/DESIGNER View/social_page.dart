import 'package:flutter/material.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/customText field.dart';
import '../../Reusable/error message.dart';
import '../../reusable/Button.dart';

class SocialLinksScreen extends StatefulWidget {
  @override
  _SocialLinksScreenState createState() => _SocialLinksScreenState();
}

class _SocialLinksScreenState extends State<SocialLinksScreen> {
  TextEditingController instagramController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _saveSocialLinks() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // Perform saving or submitting the social links
    try {
      // Simulate saving social links logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Social links saved!')),
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
            'SOCIAL LINKS',
            style: aStyleBlack28800.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '',
            style: tSStyleBlack16400.copyWith(fontSize: 14),
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: instagramController,
            labelText: "Instagram",
            obscureText: false,
           // suffixIcon: Icon(Icons.link, color: Colors.grey),
            label: '',
          ),
          SizedBox(height: screenHeight * 0.02),
          CustomTextField(
            controller: linkedInController,
            labelText: "LinkedIn",
            obscureText: false,
            //suffixIcon: Icon(),
            label: 'Link',
          ),
          ErrorMessage(errorText: _errorMessage),
          SizedBox(height: screenHeight * 0.02),
          RoundedButton(
            text: "SAVE LINKS",
            isLoading: _isLoading,
            onPressed: _saveSocialLinks,
          ),
        ],
      ),
    );
  }
}
void showSocialLinksBottomSheet(BuildContext context) {
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
        child: SocialLinksScreen(),
      );
    },
  );
}
