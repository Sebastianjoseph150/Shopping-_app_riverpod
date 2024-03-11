import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoping/layers/domain/entity/cart_iteam.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    state = [...state, item];
  }

  void removeItem(CartItem item) {
    state = state.where((cartItem) => cartItem != item).toList();
  }

  void increaseQuantity(CartItem item) {
    final index = state.indexOf(item);
    if (index != -1) {
      final updatedItem = item.copyWith(quantity: item.quantity + 1);
      state = List.from(state)..[index] = updatedItem;
    }
  }

  void decreaseQuantity(CartItem item) {
    final index = state.indexOf(item);
    if (index != -1 && item.quantity > 1) {
      final updatedItem = item.copyWith(quantity: item.quantity - 1);
      state = List.from(state)..[index] = updatedItem;
    }
  }

  double calculateTotalAmount() {
    double totalAmount = 0;

    for (var item in state) {
      totalAmount += item.price * item.quantity;
    }

    return totalAmount;
  }

  // Other methods for calculating total amount, etc.
}
