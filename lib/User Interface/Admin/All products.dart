import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import '../Customer View/Product Detail Screen.dart';
import '../../Reusable/Product Card.dart';

class AllProductsScreen extends StatefulWidget {
  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  // Search query state
  String searchQuery = '';

  // Sample product list
  List<Map<String, String>> products = [

    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash1.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/Images/splash2.png'},
    {'title': '21WN Reversible Ring', 'image': 'assets/images/product4.png'},
    // Add more products as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Filtering products based on search query
    List<Map<String, String>> filteredProducts = products
        .where((product) => product['title']!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CombinedTextWithLineWidget(text: 'PRODUCTS', fontSize: 17),
              SizedBox(height: 10),
              // Search Field
              Container(
                height: 45,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.grey1,
                    hintText: 'Search Product',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              CombinedTextWithLineWidget(text: "UK FASHION SHOW"),
              SizedBox(height: 16,),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerReviewScreen(
                            productId: products[index]['productId'] ?? 'no product ID',),
                        ),
                      );
                    },
                    child: ProductCardWidget(
                      title: filteredProducts[index]['title']!,
                      // image: filteredProducts[index]['image']!,
                      subtitle: 'Cardigan',
                      price: '\$120', imageUrl: '',
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
              CombinedTextWithLineWidget(text: "TEAR SHOW"),
              SizedBox(height: 16,),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.w,
                  mainAxisSpacing: 15.h,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerReviewScreen(
                            productId: products[index]['productId'] ?? 'no product ID',),
                        ),
                      );
                    },
                    child: ProductCardWidget(
                      title: filteredProducts[index]['title']!,
                      // image: filteredProducts[index]['image']!,
                      subtitle: 'Cardigan',
                      price: '\$120', imageUrl: '',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
