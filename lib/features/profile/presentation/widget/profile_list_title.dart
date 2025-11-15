import 'package:flutter/material.dart';

class ProfileListTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const ProfileListTitle({super.key,required this.icon,required this.title,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap:onTap,
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Icon(Icons.chevron_right, color: Colors.white54),

    );
  }
}
