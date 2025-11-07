import 'package:ecommerce/features/auth/presentation/screens/authoption.dart';
import 'package:ecommerce/features/auth/presentation/screens/login.dart';
import 'package:ecommerce/features/auth/presentation/screens/register.dart';
import 'package:ecommerce/features/auth/presentation/screens/splash.dart';
import 'package:go_router/go_router.dart';

List<GoRoute> authRoutes = [
  GoRoute(path: '/',builder:(_,_)=>SplashScreen()),
  GoRoute(path: '/login',builder:(_,_)=>LoginScreen()),
  GoRoute(path: '/register',builder:(_,_)=>RegisterScreen()),
  GoRoute(path: '/auth-options',builder:(_,_)=>Authoption()),

];