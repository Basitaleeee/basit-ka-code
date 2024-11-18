import 'package:flutter/material.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/customText field.dart';
import '../../Reusable/error message.dart';
import '../../reusable/Button.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController categoryNameController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _addCategory() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      // Perform the category addition logic here
      // For example, save category to Firestore or any local storage

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category added successfully!')),
      );

      // Clear the form after adding the category
      categoryNameController.clear();
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
          // Close Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          CustomTextField(
            controller: categoryNameController,
            labelText: "Category Name",
            obscureText: false,
            suffixIcon: null,
            label: 'Type',
          ),
          ErrorMessage(errorText: _errorMessage),
          SizedBox(height: screenHeight * 0.02),
          RoundedButton(
            text: "ADD",
            isLoading: _isLoading,
            onPressed: _addCategory,
          ),
        ],
      ),
    );
  }
}

// Function to display the Add Category screen as a bottom sheet
void showAddCategoryBottomSheet(BuildContext context) {
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
        child: AddCategoryScreen(),
      );
    },
  );
}
