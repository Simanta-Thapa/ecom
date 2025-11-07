import 'package:ecommerce/features/profile/presentation/pages/update_profile.dart';
import 'package:go_router/go_router.dart';

final updateProfileRoute = [
  GoRoute(
    path: '/updateProfile',
    builder: (context, state) => const UpdateProfile(),
  ),
];
