import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({this.onTap, this.buttonName});

  VoidCallback? onTap;
  String? buttonName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: double.maxFinite,
          height: 50,
          child: Center(child: Text('$buttonName', style: TextStyle(color: Color(0xff2B475E), fontSize: 20),)),
        ),
      ),
    );
  }
}
