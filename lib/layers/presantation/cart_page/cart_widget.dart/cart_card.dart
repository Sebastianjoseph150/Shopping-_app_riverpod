import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoping/layers/data/providers/remote/cart_provider.dart';
import 'package:shoping/layers/domain/entity/cart_iteam.dart';

class ProductCards extends ConsumerWidget {
  final String? imageUrl;
  final String productName;
  final String productPrice;
  final String productDis;
  final int productQuantity;

  const ProductCards({
    required this.imageUrl,
    required this.productDis,
    required this.productQuantity,
    required this.productName,
    required this.productPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
      child: Card(
        color: Color.fromARGB(255, 255, 253, 253),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 90,
                  height: 90,
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color.fromARGB(255, 227, 226, 226),
                              child: const Center(
                                child: Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Text('1 piece', style: TextStyle(fontSize: 10)),
                    const SizedBox(height: 8),
                    Text(
                      '₹$productPrice',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    const Text(
                      'In stock',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      cartNotifier.removeItem(CartItem(
                        imageUrl: imageUrl!,
                        title: productName,
                        price: double.parse(productPrice),
                        description: productDis,
                        quantity: productQuantity,
                      ));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  Container(
                    width: 110,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          color: Colors.black,
                          onPressed: () {
                            cartNotifier.decreaseQuantity(CartItem(
                              imageUrl: imageUrl!,
                              title: productName,
                              price: double.parse(productPrice),
                              description: productDis,
                              quantity: productQuantity,
                            ));
                          },
                        ),
                        const SizedBox(width: 2),
                        Text(
                          productQuantity.toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 2),
                        IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.black,
                          onPressed: () {
                            cartNotifier.increaseQuantity(CartItem(
                              imageUrl: imageUrl!,
                              title: productName,
                              price: double.parse(productPrice),
                              description: productDis,
                              quantity: productQuantity,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
