import 'package:ecommerce/features/cart/cart_route.dart';
import 'package:ecommerce/features/details/details_route.dart';
import 'package:ecommerce/features/profile/update_profile_route.dart';
import 'package:ecommerce/routes/setting_route.dart';
import 'package:go_router/go_router.dart';

import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import '../features/auth/presentation/auth_bloc_notifier.dart';
import '../features/auth/presentation/screens/splash.dart';
import '../features/checkout/checkout_detail_screen_route.dart';
import 'auth_routes.dart';
import 'custom_nav_bar_route.dart';


class AppRouter {
  final AuthBloc _authBloc;

  AppRouter(this._authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: AuthBlocNotifier(_authBloc),
    redirect: (context, state) {
      final isLoggedIn = _authBloc.state is AuthAuthenticated;

      // Paths for login/register/auth options
      const authPaths = ['/login', '/register', '/auth-options'];

      // 1️⃣ Splash screen logic
      if (state.matchedLocation == '/') {
        if (isLoggedIn) return '/custom-nav-bar'; // Go home if already authenticated
        return null; // Show splash screen if not logged in
      }

      // 2️⃣ Non-authenticated users trying to access protected pages
      if (!isLoggedIn && !authPaths.contains(state.matchedLocation)) {
        return '/auth-options'; // Redirect to auth options
      }

      // 3️⃣ Authenticated users trying to access login/register/auth screens
      if (isLoggedIn && authPaths.contains(state.matchedLocation)) {
        return '/custom-nav-bar'; // Redirect to home
      }

      // 4️⃣ Otherwise, no redirect needed
      return null;
    },
    routes: [
      ...authRoutes,         // login, register, auth options
      ...customNavBarRoute,  // home, cart, profile, favorite
      ...settingRoute,     // settings
      ...cartRoute,
      ...checkoutDetailScreen,
      ...detailRoute,
      ...updateProfileRoute,
      GoRoute(
        path: '/',
        builder: (context, state) => SplashScreen(), // Splash screen
      ),
    ],
  );
}
