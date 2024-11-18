import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/photographer.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/product_provider/product.dart';
import 'package:lookbook/User%20Interface/DESIGNER%20View/social_page.dart';
import 'package:provider/provider.dart';
import '../../Reusable/Button.dart';
import '../../Reusable/Custome calender.dart';
import '../../Reusable/Dropdownfield.dart';
import '../../Reusable/Image_picker.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/customText field.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Custom CircularAvatar.dart';
import '../../Reusable/Custom Color widget.dart';
import '../../Reusable/Custom TextColumn.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/description textfield.dart';
import 'Add Category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Add this function to generate a unique product ID
String generateProductID() {
  final random = Random();
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  return List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
}

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    // Initialize TextEditingControllers
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _quantityController = TextEditingController();
    final TextEditingController _barcodeController = TextEditingController();
    final TextEditingController _eventController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();
    final TextEditingController _colorController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
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
              CombinedTextWithLineWidget(text: 'Add Product'),
              SizedBox(height: 40.h),
              Center(
                child: ImagePickerWidget(
                  height: 190.h,
                  width: 272.h,
                  onImagesPicked: (images) {
                    productProvider.selectedImages = images;
                  },
                ),
              ),
              SizedBox(height: 5.h),
              CustomTextColumnWidget(
                firstText: 'ADD PRODUCT IMAGES ',
                secondText: '[MAX 3 IMAGES ]',
              ),
              SizedBox(height: 30.h),
              CustomDropdownField(
                controller: _categoryController,
                labelText: 'Category',
                items: ['Clothing', 'Shoes', 'Etc.'],
              ),
              Row(
                children: [
                  Text('Add Category', style: tSStyleBlack18400.copyWith(fontSize: 15.sp)),
                  InkWell(
                    onTap: () {
                      _categoryController.clear();
                      showAddCategoryBottomSheet(context);
                    },
                    child: Icon(Icons.add_circle_outline, color: AppColors.secondary, size: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                controller: _nameController,
                label: 'Dress Title',
                labelText: 'Dress Title',
              ),
              CustomTextField(
                controller: _priceController,
                label: 'Price',
                labelText: 'Price',
              ),
              CustomDescriptionTextField(
                controller: _descriptionController,
                maxLines: 10,
                minLines: 1,
                labelText: 'Description',
                hintText: 'Type here',
              ),
              Text('Colors', style: tSStyleBlack18400.copyWith()),
              SizedBox(height: 10.h),
              CustomColorPickerTextField(controller: _colorController),
              Text('Sizes', style: tSStyleBlack18400.copyWith()),
              SizedBox(height: 10.h),
              CustomContainerWidget(sizeLabels: ['S', 'M', 'L']),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: _quantityController,
                label: 'Minimum Order Quantity',
                labelText: 'Minimum Order Quantity',
              ),
              Row(
                children: [
                  Text('Add Social Links', style: tSStyleBlack18400.copyWith(fontSize: 15.sp)),
                  GestureDetector(
                    onTap: () {
                      showSocialLinksBottomSheet(context);
                    },
                    child: Icon(Icons.add_circle_outline, color: AppColors.secondary, size: 20.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              CustomTextField(
                controller: _barcodeController,
                label: 'Barcode',
                labelText: 'Barcode',
              ),
              CustomTextField(
                controller: _eventController,
                label: 'Event',
                labelText: 'Event',
              ),
              Text('Event Date', style: tSStyleBlack18400.copyWith(fontSize: 15.sp)),
              SizedBox(height: 10.h),
              CustomDateTextField(controller: _dateController),
              SizedBox(height: 20.h),
              RoundedButton(
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _priceController.text.isEmpty ||
                      _descriptionController.text.isEmpty ||
                      _quantityController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fill in all fields.')),
                    );
                    return;
                  }

                  try {
                    // Generate unique product ID
                    String productId = generateProductID();

                    // Collect product data from text fields
                    String name = _nameController.text;
                    String price = _priceController.text;
                    String description = _descriptionController.text;
                    String quantity = _quantityController.text;
                    String barcode = _barcodeController.text;
                    String event = _eventController.text;
                    String color = _colorController.text;
                    String category = _categoryController.text;
                    String eventDate = _dateController.text;

                    // Collect social links from provider
                    List<String> socialLinks = productProvider.selectedSocialLinks;

                    // Upload images to Firebase Storage
                    List<String> imageUrls = [];
                    if (productProvider.selectedImages.isNotEmpty) {
                      for (var image in productProvider.selectedImages) {
                        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
                        Reference ref = FirebaseStorage.instance.ref().child('product_images/$fileName');
                        await ref.putFile(File(image.path));
                        String imageUrl = await ref.getDownloadURL();
                        imageUrls.add(imageUrl);
                      }
                    }

                    // Save product data to Firestore
                    await FirebaseFirestore.instance.collection('products').doc(productId).set({
                      'productId': productId, // Add the product ID to Firestore
                      'name': name,
                      'price': price,
                      'description': description,
                      'quantity': quantity,
                      'barcode': barcode,
                      'category': category,
                      'color': color,
                      'event': event,
                      'eventDate': eventDate,
                      'images': imageUrls,
                      'socialLinks': socialLinks,
                      'timestamp': FieldValue.serverTimestamp(),
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Product added successfully!')),
                    );

                    // Navigate to Photographer screen and pass the productId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Photographer(productId: productId),
                      ),
                    );

                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                    print('Error adding product: $e');
                  }
                },
                text: 'NEXT',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
