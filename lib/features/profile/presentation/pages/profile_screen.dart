import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_event.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';

import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_event.dart';

import 'package:ecommerce/features/profile/presentation/widget/profile_header.dart';

import 'package:ecommerce/features/profile/presentation/widget/profile_menu_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Only trigger once, not in build()
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<ProfileBloc>().add(FetchProfile(authState.user.uid));
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {"icon": Icons.person_2, "title": "Update Profile", 'onTap': () {}},

      {"icon": Icons.payment, "title": "Payment", 'onTap': () {}},

      {"icon": Icons.person_2, "title": "Address", 'onTap': () {}},

      {"icon": Icons.check_outlined, "title": "Resume Checkout", 'onTap': () {}},
    ];
    final screenHeight = MediaQuery.of(context).size.height; // get double
    final topHeight = screenHeight * (1 / 7);
    final bottomHeight = screenHeight * (6 / 7);

    final headerTop = topHeight + bottomHeight * -0.2;

    const Color primaryDark = Color(0xFF141F32);
    const Color secondaryDark = Color(0xFF1F2A40);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! AuthAuthenticated) {
          return const Center(
            child: Text("Please log in to view your profile."),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1, child: Container(color: primaryDark)),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.only(top: 250),
                    color: secondaryDark,
                    child: Column(
                      children: [
                        Expanded(child: ProfileMenuList(menuItems: menuItems)),

                      ],
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              top: topHeight,
              left: 0,
              right: 0,
              child: ProfileHeader(),
            ),
          ],
        );
      },
    );
  }
}
