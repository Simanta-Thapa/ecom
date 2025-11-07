import 'package:ecommerce/features/settings/presentation/screens/settings_screen.dart';
import 'package:go_router/go_router.dart';

final settingRoute = [
  GoRoute(
    path:'/settings',
    builder:(context, state) => SettingsScreen(),
    )
];