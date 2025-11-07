import 'package:ecommerce/features/cart/presentation/pages/cart_screen.dart';
import 'package:go_router/go_router.dart';

final cartRoute = [
  GoRoute(
    path: '/cart',
    builder: (context, state) => CartScreen(),
  ),
];