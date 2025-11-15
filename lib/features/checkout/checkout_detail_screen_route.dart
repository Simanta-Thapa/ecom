import 'package:ecommerce/features/checkout/presentation/pages/checkout_detail_screen.dart';
import 'package:go_router/go_router.dart';

import '../cart/domain/entities/cart.dart';

final checkoutDetailScreen = [
  GoRoute(
    path: '/checkoutDetailScreen',
    builder: (context, state) {
      final selectedItems = state.extra as List<CartEntity>;
      return CheckoutDetailScreen(selectedItems: selectedItems);
    },
  ),
];
