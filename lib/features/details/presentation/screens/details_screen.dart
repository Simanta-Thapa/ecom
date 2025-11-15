import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:ecommerce/features/cart/presentation/bloc/cart_state.dart';
import 'package:ecommerce/features/cart/presentation/pages/cart_screen.dart';
import 'package:ecommerce/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecommerce/features/details/bloc/detail_bloc.dart';
import 'package:ecommerce/features/details/bloc/detail_event.dart';
import 'package:ecommerce/features/details/bloc/detail_state.dart';
import 'package:ecommerce/features/details/presentation/widgets/details_tab_bar.dart';
import 'package:ecommerce/features/cart/presentation/widget/animated_add_to_cart.dart';
import 'detail_product_image.dart';

class DetailsScreen extends StatefulWidget {
  final String productId;

  const DetailsScreen({required this.productId, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _quantity = 1;
  String? _uid;
  final GlobalKey _imageKey = GlobalKey();
  final ValueNotifier<String> _selectedTab = ValueNotifier("description");

  @override
  void initState() {
    context.read<DetailBloc>().add(FetchProductDetails(widget.productId));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authState = context.watch<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      _uid = authState.user.uid;
    }
  }

  void _incrementQuantity() => setState(() => _quantity++);
  void _decrementQuantity() {
    if (_quantity > 1) setState(() => _quantity--);
  }

  // 🪄 The animation function
  void _runAddToCartAnimation(Uint8List productImage, CartAnimationType type) {
    final overlay = Overlay.of(context);
    final RenderBox imageBox =
    _imageKey.currentContext!.findRenderObject() as RenderBox;
    final startPosition = imageBox.localToGlobal(Offset.zero);

    final endPosition = Offset(
      startPosition.dx,
      startPosition.dy - 120,
    );

    String text;
    switch (type) {
      case CartAnimationType.adding:
        text = "Adding to cart...";
        break;
      case CartAnimationType.success:
        text = "Added!";
        break;
      case CartAnimationType.failure:
        text = "Failed!";
        break;
    }

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => AnimatedAddToCart(
        start: startPosition,
        end: endPosition,
        image: productImage,
        text: text,
        type: type,
        onComplete: () => overlayEntry.remove(),
      ),
    );

    overlay.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.success) {
              final productData = state.detailEntity;
              if (productData == null) {
                return const Center(child: Text("Problem loading data"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                   
                    const SizedBox(height: 16),
                    Text(productData.name,
                        style: Theme.of(context).textTheme.headlineSmall),

                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _selectedTab,
                        builder: (context, value, _) {
                          return Container(
                            color:AppTheme.secondaryDark,
                            child: Column(
                              children: [
                                DetailsTabBar(
                                  selectedTab: value,
                                  onTabSelected: (tab) =>
                                  _selectedTab.value = tab,
                                ),
                                if (value == 'description')
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(productData.description),
                                  )
                                else
                                  const Text('More content here...'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🛒 Add to Cart button
                    BlocBuilder<CartBloc,CartState>(
                        builder:(context,state){


                          final detailState = context.read<DetailBloc>().state;
                          if (!detailState.success || detailState.detailEntity == null) {
                            return const SizedBox(); // or a placeholder
                          }

                          final productData = detailState.detailEntity!;
                          final isInCart = state.inCart[productData.name] ?? false;


                          return ElevatedButton(
                            onPressed: isInCart ? null : () async {
                              final cartData = CartEntity(
                                userUid: _uid ?? '',
                                id: productData.name,
                                name: productData.name,
                                image: productData.image,
                                size: 'M',
                                sizenum: 1,
                                color: 'Black',
                                price: productData.price,
                                qty: _quantity,
                              );

                              // Step 1: show adding animation
                              _runAddToCartAnimation(
                                  base64Decode(productData.image),
                                  CartAnimationType.adding);

                              // Step 2: simulate backend result
                              try {
                                context
                                    .read<CartBloc>()
                                    .add(AddCart(_uid!, cartData));

                                await Future.delayed(
                                    const Duration(milliseconds: 900));
                                _runAddToCartAnimation(base64Decode(productData.image),
                                    CartAnimationType.success);
                              } catch (_) {
                                _runAddToCartAnimation(base64Decode(productData.image),
                                    CartAnimationType.failure);
                              }
                            },
                            child: Text(isInCart ? "inCart" : "Add to Cart"  ),
                          );
                    }
                    ),

                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
