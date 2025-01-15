import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContactTextField extends StatelessWidget {
  String label;
  TextEditingController controller;
  final TextInputType? type;
  final FormFieldValidator validator;
  Icon prefixIcon;
  ContactTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.type,
      required this.validator,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        validator: validator,
        keyboardType: type,
        controller: controller,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            label: Text(label),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            floatingLabelStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )),
      ),
    );
  }
}
