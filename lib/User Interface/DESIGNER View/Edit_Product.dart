import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Dropdownfield.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/Text Button.dart';
import '../../Reusable/app_colors.dart';
import '../../Reusable/customText field.dart';
import '../../Reusable/description textfield.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  const EditProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _eventController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  String _productImageUrl = '';

  Future<void> _fetchProductData(String productId) async {
    try {
      DocumentSnapshot productDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();

      if (productDoc.exists) {
        var productData = productDoc.data() as Map<String, dynamic>;
        _categoryController.text = productData['category'];
        _nameController.text = productData['name'];
        _priceController.text = productData['price'];
        _descriptionController.text = productData['description'];
        _quantityController.text = productData['quantity'];
        _barcodeController.text = productData['barcode'];
        _eventController.text = productData['event'];
        _dateController.text = productData['date'];
        _colorController.text = productData['color'];
        _productImageUrl = productData['imageUrl'] ?? '';
      }
    } catch (e) {
      print("Error fetching product data: $e");
    }
  }

  Future<void> _deleteProduct(BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product deleted successfully!')),
      );

      Navigator.of(context).popUntil((route) => route.isFirst); // Go back to the main screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete product: $e')),
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text(
          'Are you sure you want to delete this product? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop(); // Close dialog
              _deleteProduct(context); // Call delete function
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchProductData(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
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
          icon: const Icon(Icons.arrow_back),
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
              CombinedTextWithLineWidget(text: 'Edit Product'),
              SizedBox(height: 40.h),
              Center(
                child: Container(
                  height: 400.h,
                  width: 300.w,
                  child: _productImageUrl.isNotEmpty
                      ? Image.network(_productImageUrl, fit: BoxFit.cover)
                      : Image.asset('assets/Images/product1.png'),
                ),
              ),
              SizedBox(height: 20.h),
              CustomDropdownField(
                controller: _categoryController,
                labelText: 'Category',
                items: ['Clothing', 'Shoes', 'Etc.'],
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
              SizedBox(height: 10.h),
              CustomTextField(
                controller: _quantityController,
                label: 'Minimum Order Quantity',
                labelText: 'Minimum Order Quantity',
              ),
              ReusableTextButton(
                onPressed: () {
                  // Validation and update logic
                },
                backgroundColor: AppColors.secondary,
                icon: Icons.arrow_forward_outlined,
                buttonText: 'UPDATE',
                textStyle: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              ReusableTextButton(
                onPressed: () {
                  _showDeleteConfirmationDialog(context);
                },
                backgroundColor: AppColors.greylight,
                buttonText: 'DELETE',
                textStyle: const TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
