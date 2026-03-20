// ignore_for_file: use_super_parameters

// import 'package:doctor_app/utils/appconstant.dart';
import 'package:flutter/material.dart';

import '../../utils/appconstant.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileOptionTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppConstant.Appsecondarycolor),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: MediaQuery.of(context).size.width * 0.04,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
      onTap: onTap,
    );
  }
}
