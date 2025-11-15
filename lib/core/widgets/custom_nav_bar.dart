



import 'package:ecommerce/features/Store/presentation/pages/add_product_screen.dart';
import 'package:ecommerce/features/Store/presentation/pages/home_screen.dart';
import 'package:ecommerce/features/profile/presentation/pages/profile_screen.dart';

import 'package:flutter/material.dart';


import '../../features/Store/presentation/pages/store_screen.dart';
import '../model/bottom_nav_barItem.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 0;

  // Pages only

  // Icons and labels for the nav bar
  final List<BottomNavBarItem> _navItem = [



  BottomNavBarItem(icon: Icons.home, label:"home_screen", screen:HomeScreen()),
   BottomNavBarItem(icon:Icons.add,label:"Add",screen: AddProductScreen()),
    BottomNavBarItem(icon:Icons.store,label:"Store",screen:StoreScreen()),


    BottomNavBarItem(
      icon: Icons.person_off_rounded,
      label: "Profile",
      screen: ProfileScreen(),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: _selectedIndex,
              children: _navItem.map((item) => item.screen).toList(),
            ),

            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: 30,
                  horizontal: 15,
                ),
                child: _customNavBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF050301),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // evenly space all nav items

        children: List.generate(_navItem.length, (index) {
          final item = _navItem[index];
          final isSelected = _selectedIndex == index;

          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white10 : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    item.icon,
                    color: isSelected ? Colors.red : Colors.white,
                    size: 35,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: isSelected ? Colors.red : Colors.white,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
