import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';
import 'package:ecommerce/features/cart/domain/entities/cart.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecommerce/features/cart/presentation/bloc/cart_event.dart';

import 'package:ecommerce/features/details/bloc/detail_bloc.dart';
import 'package:ecommerce/features/details/bloc/detail_event.dart';
import 'package:ecommerce/features/details/bloc/detail_state.dart';
import 'package:ecommerce/features/details/presentation/widgets/details_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/core/widgets/favorite.dart';
import 'package:ecommerce/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce/features/auth/bloc/auth_state.dart';
import 'package:ecommerce/features/details/presentation/widgets/details_button.dart';

import '../../../Store/domain/entities/shop_entity.dart';

class DetailsScreen extends StatefulWidget {
  final String productId;

  const DetailsScreen({required this.productId, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int _quantity = 1; // Quantity selector
  String? _uid;
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

  void _incrementQuantity() {
    setState(() => _quantity++);
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final product = widget.product;
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    developer.log('CartBloc found: ${context.read<CartBloc>()}');
    debugPrint("REbuilds the widgets");

    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.success) {
              final productData = state.detailEntity;
              if (productData == null) {
                return Center(child: Text("Problem loading data"));
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(15),
                      child: Image.memory(
                        base64Decode(productData.image),
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: screenHeight * 0.40,
                      ),
                    ),

                    Text(productData.name),

                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _selectedTab,
                        builder: (context, value, _) {
                          return Container(
                            decoration: BoxDecoration(color: Color(0xFFF5F5F5)),
                            child: Column(
                              children: [
                                DetailsTabBar(
                                  selectedTab: value,
                                  onTabSelected: (tab) =>
                                      _selectedTab.value = tab,
                                ),
                                if (value == 'description')
                                  Text(productData.description)
                                else
                                  Text('2 tab'),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        developer.log(
                          'CartBloc found in button : ${context.read<CartBloc>()}',
                        );
                        final cartData = CartEntity(
                          userUid: '',
                          id: productData.name,
                          name: productData.name,
                          image: productData.image,
                          size: 'adfasdf',
                          sizenum: 4343,
                          color: 'adfsf',
                          price: productData.price,
                          qty: 1,
                        );
                        context.read<CartBloc>().add(AddCart(_uid!, cartData));
                      },
                      child: Text("Add to Cart"),
                    ),
                  ],
                ),
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }

  // ------------------- WIDGET BUILDERS -------------------
  //
  // Widget _buildProductImage(ProductEntity product, double screenHeight, bool isWide) {
  //   final imageHeight = isWide ? screenHeight * 0.6 : screenHeight * 0.4;
  //   try {
  //     final bytes = base64Decode(product.image);
  //     return ClipRRect(
  //       borderRadius: BorderRadius.circular(16),
  //       child: Image.memory(
  //         bytes,
  //         height: imageHeight,
  //         width: double.infinity,
  //         fit: BoxFit.cover,
  //       ),
  //     );
  //   } catch (_) {
  //     return Container(
  //       height: imageHeight,
  //       width: double.infinity,
  //       color: Colors.grey[200],
  //       child: const Icon(Icons.image, size: 50),
  //     );
  //   }
  // }

  // Widget _buildBackAndFavorite() {
  //   return Positioned(
  //     top: 16,
  //     left: 0,
  //     right: 0,
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 8),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           BackButton(),
  //           Favorite(product: widget.product),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildTitleAndQuantity(ProductEntity product, double screenWidth) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Expanded(
  //         child: Text(
  //           product.name,
  //           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
  //             fontWeight: FontWeight.bold,
  //           ),
  //           maxLines: 2,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ),
  //       _buildQuantitySelector(screenWidth),
  //     ],
  //   );
  // }
  //
  // Widget _buildQuantitySelector(double screenWidth) {
  //   final iconSize = screenWidth * 0.06; // Scale icon size
  //   final textStyle = Theme.of(context)
  //       .textTheme
  //       .bodyLarge
  //       ?.copyWith(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.045);
  //
  //   return Row(
  //     children: [
  //       IconButton(
  //         icon: Icon(Icons.remove, size: iconSize),
  //         onPressed: _decrementQuantity,
  //       ),
  //       Text(_quantity.toString(), style: textStyle),
  //       IconButton(
  //         icon: Icon(Icons.add, size: iconSize),
  //         onPressed: _incrementQuantity,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildReviewsSection() {
  //   return Text(
  //     "Reviews",
  //     style: Theme.of(context).textTheme.titleMedium,
  //   );
  // }

  // Widget _buildDescription(ProductEntity product) {
  //   return Text(
  //     product.description,
  //     style: Theme.of(context).textTheme.bodyMedium,
  //   );
  // }

  // Widget _buildColorSelector(ProductEntity product, double screenWidth) {
  //   // Placeholder colors
  //   final colors = [Colors.red, Colors.green, Colors.blue];
  //   final circleSize = screenWidth * 0.07;
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Choose Color",
  //         style: Theme.of(context).textTheme.titleMedium,
  //       ),
  //       const SizedBox(height: 8),
  //       Row(
  //         children: colors
  //             .map(
  //               (color) => Container(
  //             margin: const EdgeInsets.only(right: 8),
  //             width: circleSize,
  //             height: circleSize,
  //             decoration: BoxDecoration(
  //               color: color,
  //               shape: BoxShape.circle,
  //               border: Border.all(color: Colors.black12),
  //             ),
  //           ),
  //         )
  //             .toList(),
  //       ),
  //     ],
  //   );
  // }
}
