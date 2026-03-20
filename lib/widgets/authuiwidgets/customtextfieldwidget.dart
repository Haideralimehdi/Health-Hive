// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../../utils/appconstant.dart';

class Customtextfieldwidget extends StatefulWidget {
  final String hinttext;
  final IconData icon;
  final TextInputType inputtype;
  // final bool obscuretext;
  final TextEditingController controller;
  final bool ispassword;
  final bool ispasswordvissible;

  const Customtextfieldwidget(
      {super.key,
      required this.hinttext,
      required this.icon,
      required this.inputtype,
      // required this.obscuretext,
      required this.controller,
      required this.ispassword,
      required this.ispasswordvissible});

  @override
  State<Customtextfieldwidget> createState() => _CustomtextfieldwidgetState();
}

class _CustomtextfieldwidgetState extends State<Customtextfieldwidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        cursorColor: AppConstant.Appsecondarycolor,
        controller: widget.controller,
        // obscureText: widget.obscuretext,
        keyboardType: widget.inputtype,
        decoration: InputDecoration(
          hintText: widget.hinttext,
          prefixIcon: Icon(
            widget.icon,
            color: AppConstant.Appsecondarycolor,
          ),
          suffixIcon: widget.ispassword
              ? GestureDetector(
                  onTap: () {
                    widget.ispasswordvissible;
                  },
                  child: Icon(
                    widget.ispasswordvissible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppConstant.Appsecondarycolor,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: AppConstant.Appsecondarycolor),
          ),
        ),
      ),
    );
  }
}
