import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/product_provider/photographer%20provider.dart';
import 'package:provider/provider.dart';
import '../../Models/photographer.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Image_picker.dart';
import '../../Reusable/customText field.dart';
import '../../Reusable/app_colors.dart';
import 'HOME.dart';
import 'Product Review.dart';

class Photographer extends StatefulWidget {
  final String? productId;
  const Photographer({super.key, required this.productId});

  @override
  State<Photographer> createState() => _PhotographerState();
}

class _PhotographerState extends State<Photographer> {
  final TextEditingController _emailsController = TextEditingController();
  final TextEditingController _photographerNameController =
      TextEditingController();
  final TextEditingController _socialLinksController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final photographerProvider = Provider.of<PhotographerProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'LOOK',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 70.0),
              child: Text(
                'BOOK',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              CombinedTextWithLineWidget(
                  text: 'ADD PHOTOGRAPHER', fontSize: 20),
              SizedBox(height: 40.h),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    // Trigger image picking and uploading
                    await photographerProvider.pickImage(
                        context: context,
                        onImagePicked: (String imageUrl) {},
                        onError: (String error) {});
                  },
                  child: ImagePickerWidget(
                    height: 200,
                    width: 500,
                    onImagesPicked: (images) {}, // Placeholder
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                controller: _photographerNameController,
                label: 'Photographer Name',
                labelText: 'Photographer Name',
              ),
              CustomTextField(
                controller: _socialLinksController,
                label: 'Social Links',
                labelText: 'Social Links',
              ),
              Row(
                children: [
                  Text(
                    'Add Social Links',
                    style: TextStyle(
                        fontSize: 15.sp, color: AppColors.primaryColor),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Placeholder for social links bottom sheet
                    },
                    child: Icon(Icons.add_circle_outline,
                        color: AppColors.secondary, size: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  labelText: 'Phone'),
              CustomTextField(
                  controller: _emailsController,
                  label: 'Email',
                  labelText: 'Email'),
              RoundedButton(
                onPressed: () async {
                  if (_photographerNameController.text.isEmpty ||
                      _emailsController.text.isEmpty ||
                      _phoneController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                    return;
                  }

                  if (photographerProvider.imageUrl == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please upload an image.')),
                    );
                    return;
                  }

                  // Add photographer to Firestore using provider
                  try {
                    final photographer = PhotographerModel(
                      name: _photographerNameController.text,
                      email: _emailsController.text,
                      phone: _phoneController.text,
                      socialLinks: _socialLinksController.text,
                      imageUrl: photographerProvider.imageUrl!,
                    );

                    await FirebaseFirestore.instance
                        .collection('products')
                        .doc(widget.productId)
                        .collection('photographers')
                        .add(photographer.toMap());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Photographer added successfully!')),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductReviewScreen(productId: widget.productId,),
                      ),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                },
                text: 'SAVE',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
