// import 'package:ecommerce/features/home/presentation/screens/home_screen.dart';
// import 'package:ecommerce/features/profile/presentation/screens/profile_screen.dart';
// import 'package:ecommerce/features/settings/presentation/screens/settings_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';


// class MainScreen extends StatelessWidget {
//   final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

 

//   List<Widget> _buildScreens() {
//     return [
//       HomeScreen(),
//       ProfileScreen(),
//       SettingsScreen(),
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.home),
//         title: ("Home"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.person),
//         title: ("Profile"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Icon(Icons.settings),
//         title: ("Settings"),
//         activeColorPrimary: Colors.blue,
//         inactiveColorPrimary: Colors.grey,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       confineToSafeArea: true,
//       backgroundColor: Colors.white,
//       handleAndroidBackButtonPress: true,
//       resizeToAvoidBottomInset: true,
//       stateManagement: true,
//       navBarStyle: NavBarStyle.style1, // choose your style
//     );
//   }
// }
