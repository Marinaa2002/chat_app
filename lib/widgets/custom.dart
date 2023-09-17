import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.hint, this.onChanged, this.validator, this.obsecure = false});

  String? hint;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  bool obsecure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: TextFormField(
        validator: validator,
        /*validator: (value) {
          if(value!.isEmpty){
            return 'Field is required';
          }
        },*/
        onChanged: onChanged,
        obscureText: obsecure,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: '$hint',
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),

        ),
      ),
    );
  }
}
