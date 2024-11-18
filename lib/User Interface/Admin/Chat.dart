import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Reusable/Combined Text+icon.dart';
import '../../Reusable/app_colors.dart';
class ChatDetailScreen1 extends StatelessWidget {
  final String designerName;
  final String customerName;
  final String designerImage;
  final String customerImage;

  ChatDetailScreen1({
    Key? key,
    required this.designerName,
    required this.customerName,
    required this.designerImage,
    required this.customerImage,
  }) : super(key: key);

  final List<Map<String, String>> messages = [
    {'sender': 'designer', 'text': 'Hello! How can I assist you today?'},
    {'sender': 'customer', 'text': 'I wanted to discuss my recent order.'},
    {'sender': 'designer', 'text': 'Of course, any specific concerns?'},
    {'sender': 'customer', 'text': 'Yes, I have   the design.'},
    {'sender': 'designer', 'text': 'Sure! Let’s talk about the details.'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 10),
           CombinedTextWithLineWidget(text: "CONVERSATIONS"),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isDesigner = messages[index]['sender'] == 'designer';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: isDesigner
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isDesigner)
                          CircleAvatar(
                            backgroundImage: AssetImage(designerImage),
                            radius: 20,
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: isDesigner ? AppColors.grey1 : AppColors.secondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: isDesigner
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              Text(
                                isDesigner ? designerName : customerName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isDesigner ? Colors.white : Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                messages[index]['text']!,
                                style: TextStyle(
                                  color: isDesigner ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (!isDesigner)
                          CircleAvatar(
                            backgroundImage: AssetImage(customerImage),
                            radius: 20,
                          ),
                      ],
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
