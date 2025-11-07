import 'package:ecommerce/core/widgets/custom_nav_bar.dart';
import 'package:go_router/go_router.dart';

final customnavbar =[
  GoRoute(
    path:'/custom_nav_bar',
    builder:(context, state) => CustomNavBar(),
    )
];