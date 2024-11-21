import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Custom Small Button.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';

class DesignerDetailScreen extends StatelessWidget {
  final String designerName;
  final String designerPhotoUrl;

  DesignerDetailScreen({
    required this.designerName,
    required this.designerPhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'LOOK',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'BOOK',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CombinedTextWithLineWidget(text: 'JHONE LANE', fontSize: 17),
            SizedBox(height: 10),

            // Designer Photo from Network
            Container(
              width: 411.w,
              height: 381.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(designerPhotoUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            SizedBox(height: 16),

            // Designer Name
            Text(
              designerName,
              style: tSStyleBlack18400.copyWith(
                fontSize: 20, // Use the font size parameter
              ),
            ),

            SizedBox(height: 8),
            Text(
              "We work with monitoring programmes to ensure compliance with safety, health and quality standards for our products.",
              style: tSStyleBlack18400.copyWith(
                fontSize: 12,
              ),
            ),

            // Designer Details Container
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone Number',
                  style: tSStyleBlack18400.copyWith(
                    fontSize: 15,
                  ),
                ),
                _contactDetailRow(
                  icon: Icons.phone,
                  label: '+123 456 7890',
                  onTap: () {
                    print('Phone tapped');
                  },
                ),
                Text(
                  'Email Address',
                  style: tSStyleBlack18400.copyWith(
                    fontSize: 15,
                  ),
                ),
                _contactDetailRow(
                  icon: Icons.email,
                  label: 'designer@example.com',
                  onTap: () {
                    print('Email tapped');
                  },
                ),
                Text(
                  'Instagram',
                  style: tSStyleBlack18400.copyWith(
                    fontSize: 15,
                  ),
                ),
                _contactDetailRow(
                  icon: Icons.camera_alt,
                  label: '@designer_insta',
                  onTap: () {
                    print('Instagram tapped');
                  },
                ),
              ],
            ),

            SizedBox(height: 20),

            // Block Button
            CustomSmallButton(
              color: Colors.red,
              height: 40,
              width: 140,
              text: "REPORT",
              onPressed: () {
                _showCustomConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactDetailRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.secondary),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward, color: AppColors.secondary),
          ],
        ),
      ),
    );
  }

  void _showCustomConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 400,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Cross Icon to close dialog
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Text(
                    'Are you sure you want to block?',
                    style: TextStyle(
                      fontSize: 16.sp,
                     // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                //sDivider(thickness: 1, color: Colors.grey),

                // Cancel and Confirm Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal:25),
                        decoration: BoxDecoration(
                       //   color: Colors.grey[300],
                          border: Border.all(
                            color: AppColors.grey1, // Border color
                            width: 2.0, // Border width
                          ),
                          borderRadius: BorderRadius.circular( 8
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        // Perform block action
                        print('Designer blocked');
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8,horizontal:25),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular( 8
                           // bottomRight: Radius.circular(10),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
