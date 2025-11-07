import 'package:flutter/material.dart';

class AppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const AppBar1({
    required this.title,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: BackButton(),
      title:Text(title),
    );
  }
  
  @override

Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}