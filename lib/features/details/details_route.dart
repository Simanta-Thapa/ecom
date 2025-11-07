
import 'package:ecommerce/features/details/presentation/screens/details_screen.dart';
import 'package:go_router/go_router.dart';

final detailRoute = [
  GoRoute(
    path: '/details/:productId',
    builder: (context, state) {
      final productId = state.pathParameters['productId']!; // non-null because URL contains it
      return DetailsScreen(productId: productId);
    },
  ),
];