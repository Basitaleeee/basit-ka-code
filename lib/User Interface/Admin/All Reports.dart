import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int selectedCategory = 0; // 0 = Designer, 1 = Customer, 2 = Product
  String searchQuery = '';

  List<Map<String, String>> designerReports = [

    {'name': 'Designer One', 'contact': '+1234567890', 'icon': 'assets/Icons/profile.svg'},
    {'name': 'Designer Two', 'contact': '+0987654321', 'icon': 'assets/Icons/profile.svg'},
  ];
  List<Map<String, String>> customerReports = [

    {'name': 'Customer One', 'contact': '+1234567890', 'icon': 'assets/Icons/profile.svg'},
    {'name': 'Customer Two', 'contact': '+0987654321', 'icon': 'assets/Icons/profile.svg'},
  ];
  List<Map<String, String>> productReports = [

    {'name': 'Product One', 'contact': '+1234567890', 'icon': 'assets/Icons/profile.svg'},
    {'name': 'Product Two', 'contact': '+0987654321', 'icon': 'assets/Icons/profile.svg'},
  ];
//change 1
  List<Map<String, String>> getCurrentReports() {
    List<Map<String, String>> reports;
    switch (selectedCategory) {
      case 0:
        reports = designerReports;
        break;
      case 1:
        reports = customerReports;
        break;
      case 2:
        reports = productReports;
        break;
      default:
        reports = [];
    }
    return reports.where((report) =>
    report['name']?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> reports = getCurrentReports();

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
        child: Column(
          children: [
            CombinedTextWithLineWidget(text: "REPORTS"),
            SizedBox(height: 10),
            // Search Text Field
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
                  hintText: 'Search Reports',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: AppColors.grey1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCategoryContainer('Designer', 0),
                  buildCategoryContainer('Customer', 1),
                  buildCategoryContainer('Product', 2),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  var report = reports[index];
                  return ReportListItem(
                    name: report['name'] ?? 'No Name',
                    contactNumber: report['contact'] ?? 'No Contact',
                    image: report['image'] ?? 'assets/images/placeholder.svg', // Default image if null
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryContainer(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = index;
          searchQuery = ''; // Reset search when changing category
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        decoration: BoxDecoration(
          color: selectedCategory == index ? AppColors.white : AppColors.grey1,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selectedCategory == index ? AppColors.secondary : AppColors.text4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class ReportListItem extends StatelessWidget {
  final String name;
  final String contactNumber;
  final String image;

  const ReportListItem({
    Key? key,
    required this.name,
    required this.contactNumber,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            child: SvgPicture.asset(
              image, // Ensure you have a valid SVG path
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Tapped on contact number: $contactNumber');
                    // You can add actions like opening the dialer or navigating to a new screen
                  },
                  child: Text(
                    contactNumber,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
          ),
          Icon(Icons.arrow_forward, color: AppColors.secondary),
        ],
      ),
    );
  }
}
