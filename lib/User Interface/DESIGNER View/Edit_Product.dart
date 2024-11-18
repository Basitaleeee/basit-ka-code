// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lookbook/User%20Interface/DESIGNER%20View/photographer.dart';
// import 'package:lookbook/User%20Interface/DESIGNER%20View/product_provider/product.dart';
// import 'package:lookbook/User%20Interface/DESIGNER%20View/social_page.dart';
// import 'package:provider/provider.dart';
// import '../../Reusable/Combined Text+icon.dart';
// import '../../Reusable/Dropdownfield.dart';
// import '../../Reusable/Fonts.dart';
// import '../../Reusable/Text Button.dart';
// import '../../Reusable/app_colors.dart';
// import '../../Reusable/customText field.dart';
// import '../../Reusable/description textfield.dart';
//
// class EditProductScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final TextEditingController _categoryController = TextEditingController();
//     final TextEditingController _nameController = TextEditingController();
//     final TextEditingController _priceController = TextEditingController();
//     final TextEditingController _descriptionController =
//         TextEditingController();
//     final TextEditingController _quantityController = TextEditingController();
//     final TextEditingController _barcodeController = TextEditingController();
//     final TextEditingController _eventController = TextEditingController();
//     final TextEditingController _dateController = TextEditingController();
//     final TextEditingController _colorController = TextEditingController();
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Text(
//               'LOOK',
//               style: aStyleBlack14400.copyWith(
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 70.0),
//               child: Text(
//                 'BOOK',
//                 style: aStyleBlack14400.copyWith(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: 30.h),
//               CombinedTextWithLineWidget(text: 'Edit Product'),
//               SizedBox(height: 40.h),
//               Center(
//                 child: Center(
//                   child: Container(
//                     height: 400.h,
//                     width: 300.w,
//                     child: Image.asset('assets/Images/product1.png'),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               CustomDropdownField(
//                 controller: _categoryController,
//                 labelText: 'Category',
//                 items: ['Clothing', 'Shoes', 'Etc.'],
//               ),
//               SizedBox(height: 15.h),
//               CustomTextField(
//                 controller: _nameController,
//                 label: 'Dress Title',
//                 labelText: 'Dress Title',
//               ),
//               CustomTextField(
//                 controller: _priceController,
//                 label: 'Price',
//                 labelText: 'Price',
//               ),
//               CustomDescriptionTextField(
//                 controller: _descriptionController,
//                 maxLines: 10,
//                 minLines: 1,
//                 labelText: 'Description',
//                 hintText: 'Type here',
//               ),
//               SizedBox(height: 10.h),
//               CustomTextField(
//                 controller: _quantityController,
//                 label: 'Minimum Order Quantity',
//                 labelText: 'Minimum Order Quantity',
//               ),
//               Row(children: [
//                 Text('Add Social Links',
//                     style: tSStyleBlack18400.copyWith(fontSize: 15.sp)),
//                 GestureDetector(
//                   onTap: () {
//                     showSocialLinksBottomSheet(context);
//                   },
//                   child: Icon(Icons.add_circle_outline,
//                       color: AppColors.secondary, size: 20.sp),
//                 ),
//               ]),
//               SizedBox(height: 10.h),
//               CustomTextField(
//                 controller: _barcodeController,
//                 label: 'Barcode',
//                 labelText: 'Barcode',
//               ),
//               CustomTextField(
//                 controller: _eventController,
//                 label: 'Event',
//                 labelText: 'Event',
//               ),
//               ReusableTextButton(
//                 onPressed: () {
//                   // Validation
//                   if (_nameController.text.isEmpty ||
//                       _priceController.text.isEmpty ||
//                       _descriptionController.text.isEmpty ||
//                       _quantityController.text.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Please fill in all fields.')),
//                     );
//                     return;
//                   }
//
//                   // Collect product data for review
//                   productProvider.setProductData(
//                     name: _nameController.text,
//                     price: _priceController.text,
//                     description: _descriptionController.text,
//                     photographerName: '',
//                     images: productProvider.selectedImages.isNotEmpty
//                         ? productProvider.selectedImages
//                         : [],
//                     photographerEmail: '',
//                     photographerPhone: '',
//                     socialLinks: '',
//                   );
//
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Photographer(productId: Widget.productId, )),
//                   );
//                 },
//                 backgroundColor: AppColors.secondary,
//                 icon: Icons.arrow_forward_outlined,
//                 buttonText: 'UPDATE',
//                 textStyle: TextStyle(
//                   fontFamily: 'Quicksand',
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10.h),
//               ReusableTextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 backgroundColor: AppColors.greylight,
//                 //icon: Icons.arrow_back,
//                 buttonText: '                         DELETE',
//                 textStyle: TextStyle(
//                   fontFamily: 'Quicksand',
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
