import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoping/layers/data/providers/remote/cart_provider.dart';
import 'package:shoping/layers/domain/entity/cart_iteam.dart';
import 'package:shoping/layers/presantation/cart_page/cart_widget.dart/cart_card.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final cartItems = ref.watch(cartProvider);
    final subTotal = cartNotifier.calculateTotalAmount();

    const gstRate = 0.18;
    final gstAmount = subTotal * gstRate;
    final totalAmount = subTotal + gstAmount;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 30,
          backgroundColor: Color.fromARGB(255, 215, 208, 23),
        ),
        body: _buildCartBody(cartItems, subTotal, gstAmount, totalAmount, ref),

      ),
    );
  }

  Widget _buildCartBody(List<CartItem> cartItems, double subTotal,
      double gstAmount, double totalAmount, WidgetRef ref) {
    final cartItems1 = ref.watch(cartProvider);

    if (cartItems1.isEmpty) {
      return const Center(
        child: Text('Your cart is empty'),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems1.length,
              itemBuilder: (context, index) {
                final item = cartItems1[index];
                return ProductCards(
                  imageUrl: item.imageUrl,
                  productName: item.title,
                  productPrice: item.price.toString(),
                  productDis: item.description,
                  productQuantity: item.quantity,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Subtotal: ₹ ${subTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'GST (18%): ₹ ${gstAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Total Amount: ₹ ${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }

  void _checkout(WidgetRef ref) {}
}
