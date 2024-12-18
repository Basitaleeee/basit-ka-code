import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../Reusable/Button.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _profileImageUrl = ''; // Variable to store the profile image URL

  Future<void> _pickImage() async {
    // Pick an image from the gallery
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload the image to Firebase Storage
      try {
        String fileName = pickedFile.name;
        Reference storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
        UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));
        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update the profile image URL in Firestore
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
            'profileImage': downloadUrl,
          });

          setState(() {
            _profileImageUrl = downloadUrl;
          });
        }
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<Map<String, dynamic>> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      return {
        'fullName': userDoc.data()?['fullName'] ?? 'Name not set',
        'email': user.email ?? 'Email not available',
        'phone': userDoc.data()?['phone'] ?? 'Phone not set',
        'instagram': userDoc.data()?['instagram'] ?? 'Not linked',
        'linkedin': userDoc.data()?['linkedin'] ?? 'Not linked',
        'profileImage': userDoc.data()?['profileImage'] ?? '', // Fetch the profile image URL
      };
    }

    return {
      'fullName': 'No user logged in',
      'email': '',
      'phone': '',
      'instagram': '',
      'linkedin': '',
      'profileImage': '', // No profile image for an unauthenticated user
    };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
             Navigator.pushReplacementNamed(context, '/DesignerHomeScreen');
            },
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final userData = snapshot.data ?? {};

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 26.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: CombinedTextWithLineWidget(
                          text: 'PROFILE', fontSize: 15),
                    ),
                    SizedBox(height: 70.h),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20.0.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 10.0.w,
                              right: 10.0.w,
                              top: 100.0.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildCustomTextField
                                  ('fullName',
                                    userData['fullName'] ?? '', false),
                                _buildCustomTextField('Email',
                                    userData['email'] ?? '', false),
                                _buildCustomTextField('Phone',
                                    userData['phone'] ?? '', false),
                                _buildCustomTextField('Password', '••••••••', true),
                                _buildCustomTextField('Instagram',
                                    userData['instagram'] ?? '', false),
                                _buildCustomTextField('LinkedIn',
                                    userData['linkedin'] ?? '', false),
                                SizedBox(height: 15.h),
                                Row(
                                  children: [
                                    Text('Add Social Links',
                                        style: TextStyle(fontSize: 15.sp)),
                                    GestureDetector(
                                      onTap: () {
                                        // Handle adding social links
                                      },
                                      child: Icon(Icons.add_circle_outline,
                                          color: AppColors.secondary,
                                          size: 20.sp),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40.h),
                                SizedBox(
                                  height: 50,
                                  child: RoundedButton(
                                    text: 'UPDATE',
                                    onPressed: () {
                                      // Handle update logic
                                    },
                                  ),
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -45.h,
                          left: MediaQuery.of(context).size.width * 0.5 - 70.w,
                          child: GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 60.0.r,
                              backgroundColor: Colors.grey.withOpacity(0.5),
                              backgroundImage: _profileImageUrl.isNotEmpty
                                  ? NetworkImage(_profileImageUrl)
                                  : AssetImage('assets/Images/splash.png')
                              as ImageProvider,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCustomTextField(String label, String value, bool obscureText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: TextField(
        readOnly: true,
        obscureText: obscureText,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: value,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
      ),
    );
  }
}
