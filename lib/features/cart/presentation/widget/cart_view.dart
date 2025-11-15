import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/cart.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import 'cart_item.dart';

typedef CartActionCallback = void Function(String cartId);

class CartView extends StatelessWidget {
  final String uid;
  final Set<String> selectedIds;
  final Function(String) onToggleSelect;
  final CartActionCallback onAdd;
  final CartActionCallback onRemove;

  const CartView({
    super.key,
    required this.uid,
    required this.selectedIds,
    required this.onToggleSelect,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) =>
      previous.cart != current.cart || previous.status != current.status,
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.isFailure) {
          return Center(child: Text(state.errorMessage ?? "Failed to load cart"));
        }

        final cart = state.cart;

        if (cart.isEmpty) {
          return const Center(child: Text("Your cart is empty"));
        }

        return ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context, index) {
            final item = cart[index];

            return Dismissible(
              key: ValueKey(item.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) {
                context
                    .read<CartBloc>()
                    .add(RemoveCartItem(uid: uid, cartId: item.id));
              },
              child: BlocSelector<CartBloc, CartState, CartEntity?>(
                selector: (state) => state.cart.firstWhere(
                      (c) => c.id == item.id,
                  orElse: () => item,
                ),
                builder: (context, currentItem) {
                  if (currentItem == null) return const SizedBox.shrink();

                  return CartItem(
                    key: ValueKey(currentItem.id),
                    item: currentItem,
                    uid: uid,
                    onAdd: () => onAdd(currentItem.id),
                    onRemove: () => onRemove(currentItem.id), 
                    selected:selectedIds.contains(currentItem.id),
                    onSelected:()=> onToggleSelect(currentItem.id),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
