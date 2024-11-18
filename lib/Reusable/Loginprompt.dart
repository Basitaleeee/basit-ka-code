import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../User Interface/SignIn.dart';

class ReusableLoginPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "Already have an account?",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: RichText(
              text: TextSpan(
                text: "LOGIN",
                style: const TextStyle(color: Colors.blue, fontSize: 15),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Lookbook1()),
                    );
                  },
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
