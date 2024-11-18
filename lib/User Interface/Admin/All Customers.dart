import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import 'Customer Details.dart';

class CustomerListScreen extends StatefulWidget {
  @override
  _CustomerListScreenState createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<Map<String, String>> customers = [
    {
      'name': 'Customer One',
      'contact': '+1234567890',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Customer Two',
      'contact': '+0987654321',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Customer Three',
      'contact': '+1122334455',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Customer Four',
      'contact': '+5566778899',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Customer Five',
      'contact': '+6677889900',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Customer Six',
      'contact': '+6677889922',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Customer Seven',
      'contact': '+6677889933',
      'icon': 'assets/Icons/profile.svg'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredCustomers = customers
        .where((customer) =>
            customer['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CombinedTextWithLineWidget(text: 'CUSTOMERS', fontSize: 17),
            SizedBox(height: 10),
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
                  hintText: 'Search Customer',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            filteredCustomers.isEmpty
                ? Center(
                    child: Text(
                      'No customers found.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredCustomers.length,
                      itemBuilder: (context, index) {
                        return CustomerListItem(
                          svgPath: filteredCustomers[index]['icon']!,
                          name: filteredCustomers[index]['name']!,
                          contactNumber: filteredCustomers[index]['contact']!,
                          destinationScreen: CustomerDetailScreen(
                            // Update with actual destination screen
                            customerName: filteredCustomers[index]['name']!,
                            customerPhotoUrl:
                                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=411&h=381&fit=crop',
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CustomerListItem extends StatelessWidget {
  final String svgPath;
  final String name;
  final String contactNumber;
  final Widget destinationScreen;

  const CustomerListItem({
    Key? key,
    required this.svgPath,
    required this.name,
    required this.contactNumber,
    required this.destinationScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipOval(
              child: SvgPicture.asset(
                svgPath,
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
                    onTap: () async {
                      final phoneUrl = 'tel:$contactNumber';
                      if (await canLaunch(phoneUrl)) {
                        await launch(phoneUrl);
                      } else {
                        print('Could not launch phone number');
                      }
                    },
                    child: Text(
                      contactNumber,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward, color: AppColors.secondary),
          ],
        ),
      ),
    );
  }

  canLaunch(String phoneUrl) {}

  launch(String phoneUrl) {}
}
