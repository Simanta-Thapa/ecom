import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';

import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_event.dart';
import 'package:ecommerce/features/profile/presentation/widget/profile_choice_chip.dart';

import 'package:ecommerce/features/profile/presentation/widget/profile_header.dart';
import 'package:ecommerce/features/profile/presentation/widget/profile_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile_tab.dart';
import '../bloc/profile_state.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
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

    const Color primaryDark = Color(0xFF141F32);
    const Color secondaryDark = Color(0xFF1F2A40);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is! AuthAuthenticated) {
          return const Center(child: Text("Please log in to view your profile."));
        }

        // 🚨 FIX 1: Wrap the entire layout in a Container
        // to ensure the background is the secondaryDark color,
        // thus covering the parent Scaffold's white background.
        return Container(
          color: primaryDark,
          child: SafeArea(
            // 🚨 FIX 2: Ensure the top padding is still applied
            // to push content below the Status Bar, but only if needed.
            // Since you're using a full-screen layout, let's use the Stack
            // for the color and rely on the parent Scaffold for SafeArea.
            // However, since this is a tab view, we only exclude the bottom
            // (for the BottomNavBar) if the parent Scaffold doesn't handle it.
            child: Stack(
                children:[
                  // The main content column
                  Column(
                      children:[
                        // This is the top 140px section. It should now be visible
                        // because the container beneath the stack has secondaryDark color.
                        const SizedBox(
                            height: 140,
                            child: ColoredBox(color: primaryDark)
                        ),

                        // 🚨 FIX 3: Use Expanded here so the Container takes the rest of the vertical space.
                        Expanded(
                          child: Container(
                            // Top padding needed to push content below the overlapping ProfileHeader
                            padding: const EdgeInsets.only(
                                top: 150
                            ),
                            // This color is now redundant but kept for clarity
                            decoration: const BoxDecoration(
                                color: secondaryDark
                            ),
                            child: Column(
                              children: const [
                                ListTile(
                                  leading: Icon(Icons.settings, color: Colors.white), // Added color for visibility
                                  title: Text("Settings", style: TextStyle(color: Colors.white)), // Added color for visibility
                                )
                              ],
                            ),
                          ),
                        )
                      ]
                  ),


                  // Profile Header overlay
                  Positioned(
                      top: 80,
                      left: 0, // Added to ensure horizontal centering
                      right: 0, // Added to ensure horizontal centering
                      child: ProfileHeader()
                  ),
                ]
            ),
          ),
        );
      },
    );
  }

}


