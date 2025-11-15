import 'package:ecommerce/features/profile/presentation/widget/profile_list_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/bloc/auth_event.dart';

class ProfileMenuList extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems;
  const ProfileMenuList({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...menuItems.map(
          (item) => ProfileListTitle(
            icon: item['icon'] as IconData,
            title: item['title'] as String,
            onTap: item['onTap'] as void Function(),
          ),
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Log Out"),
          onTap: () {
            context.read<AuthBloc>().add(LogOut());
          },
        ),
      ],
    );
  }
}
