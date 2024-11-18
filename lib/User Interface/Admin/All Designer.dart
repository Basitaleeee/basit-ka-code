import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/Fonts.dart';
import '../../Reusable/app_colors.dart';
import '../Customer View/Logout Screen.dart';
import 'Designer Details.dart';

class DesignerListScreen extends StatefulWidget {
  @override
  _DesignerListScreenState createState() => _DesignerListScreenState();
}

class _DesignerListScreenState extends State<DesignerListScreen> {
  List<Map<String, String>> designers = [
    {
      'name': 'Designer One',
      'contact': '+1234567890',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Designer Two',
      'contact': '+0987654321',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Designer Three',
      'contact': '+1122334455',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Designer Four',
      'contact': '+5566778899',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Designer Five',
      'contact': '+6677889900',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Designer Six',
      'contact': '+6677889922',
      'icon': 'assets/Icons/profile.svg'
    },
    {
      'name': 'Designer Seven',
      'contact': '+6677889933',
      'icon': 'assets/Icons/profile.svg'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredDesigners = designers
        .where((designer) =>
            designer['name']!.toLowerCase().contains(searchQuery.toLowerCase()))
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
            CombinedTextWithLineWidget(text: 'DESIGNERS', fontSize: 17),
            SizedBox(height: 10),
            _buildSearchField(),
            SizedBox(height: 16),
            Expanded(
              child: _buildDesignerList(filteredDesigners),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
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
          hintText: 'Search Designer',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDesignerList(List<Map<String, String>> filteredDesigners) {
    return ListView.builder(
      itemCount: filteredDesigners.length,
      itemBuilder: (context, index) {
        return DesignerListItem(
          svgPath: filteredDesigners[index]['icon']!,
          name: filteredDesigners[index]['name']!,
          contactNumber: filteredDesigners[index]['contact']!,
          destinationScreen: DesignerDetailScreen(
            designerName: 'JHONE',
            designerPhotoUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=411&h=381&fit=crop',
          ), // Replace with actual screen if needed
        );
      },
    );
  }
}

class DesignerListItem extends StatelessWidget {
  final String svgPath;
  final String name;
  final String contactNumber;
  final Widget destinationScreen;

  const DesignerListItem({
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
                    onTap: () {
                      print('Tapped on contact number: $contactNumber');
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
}
