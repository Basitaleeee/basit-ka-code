import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'app_colors.dart';

class CustomerCustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomerCustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap, required int selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> navItems = [
      {'icon': 'assets/Icons/HomeIcon2.svg', 'label': 'Home'},
      {'icon': 'assets/Icons/MessageIcon.svg', 'label': 'Chat'},

      {'icon': 'assets/Icons/NotificationIcon2.svg', 'label': 'Notification'},
      {'icon': 'assets/Icons/ProfileIcon2.svg', 'label': 'Profile'},
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: navItems.map((item) {
        int index = navItems.indexOf(item);
        return BottomNavigationBarItem(
          icon: item['icon'] != ''
              ? SvgPicture.asset(
            item['icon'],
            color: currentIndex == index
                ? AppColors.secondary
                : Colors.grey,
            width: 24.w,
            height: 24.h,
          )
              : SizedBox.shrink(),
          label: currentIndex == index ? item['label'] : '', // Show label only if the item is selected
        );
      }).toList(),
    );
  }
}