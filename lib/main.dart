

import 'package:ecommerce/di/injection.dart' as di;
import 'package:ecommerce/features/Store/presentation/bloc/shop_bloc.dart';


import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';


import 'package:ecommerce/features/auth/bloc/auth_state.dart';

import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:ecommerce/features/details/bloc/detail_bloc.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_bloc.dart';
import 'package:ecommerce/features/favorite/presentation/bloc/favorite_event.dart';


import 'package:ecommerce/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecommerce/features/profile/presentation/bloc/profile_event.dart';
import 'package:ecommerce/routes/app_route.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // --- Repositories ---


  // --- UseCases ---

  // --- BLoCs ---

  await di.init();


  final authBloc = di.sl<AuthBloc>();
  final profileBloc = di.sl<ProfileBloc>();
  final favoriteBloc = di.sl<FavoriteBloc>();
  final cartBloc = di.sl<CartBloc>();
  final shopBloc = di.sl<ShopBloc>();
  final detailBloc = di.sl<DetailBloc>();
  final checkoutBloc = di.sl<CheckoutBloc>();



  runApp(
    MyApp(

      authBloc: authBloc,
      favoriteBloc: favoriteBloc,
      shopBloc: shopBloc,
      profileBloc: profileBloc,
      cartBloc: cartBloc,
      detailBloc:detailBloc,
      checkoutBloc:checkoutBloc,

    ),
  );
}

class MyApp extends StatelessWidget {

  final AuthBloc authBloc;
  final FavoriteBloc favoriteBloc;
  final ProfileBloc profileBloc;
  final CartBloc cartBloc;
  final ShopBloc shopBloc;
  final DetailBloc detailBloc;
  final CheckoutBloc checkoutBloc;


  const MyApp({
    super.key,
    required this.authBloc,
    required this.profileBloc,
    required this.cartBloc,
    required this.detailBloc,

    required this.favoriteBloc,
    required this.shopBloc,
    required this.checkoutBloc,

  });


  @override
  Widget build(BuildContext context) {

    final appRouter = AppRouter(authBloc);


    return  MultiBlocProvider(
      providers: [
        // Feature Blocs provided via GetIt singletons
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<ProfileBloc>.value(value: profileBloc),
        BlocProvider<FavoriteBloc>.value(value: favoriteBloc),
        BlocProvider<CartBloc>.value(value: cartBloc),
        BlocProvider<ShopBloc>.value(value:shopBloc),
        BlocProvider<DetailBloc>.value(value:detailBloc),
        BlocProvider<CheckoutBloc>.value(value:checkoutBloc),
        // Shared Bloc created here

      ],
     
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              final uid = state.user.uid;

              context.read<FavoriteBloc>().add(FetchFavoriteList(uid: uid));
              context.read<ProfileBloc>().add(FetchProfile(uid));
            }
          },
          child: MaterialApp.router(
            title: 'E-Commerce App',
            routerConfig: appRouter.router,
            debugShowCheckedModeBanner: false,

          ),
        ),
      
    );
  }
}
