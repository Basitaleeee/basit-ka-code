import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Fonts.dart';
import 'app_colors.dart';

class OrDivider extends StatelessWidget {
   OrDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text("OR", style:tSStyleBlack14400.copyWith(fontSize: 16.0,
          color: AppColors.primaryColor
          )),

        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
        ),
      ],
    );
  }
}
