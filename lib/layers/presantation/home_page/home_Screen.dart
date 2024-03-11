import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoping/layers/data/providers/api%20provider.dart';
import 'package:shoping/layers/data/providers/remote/cart_provider.dart';
import 'package:shoping/layers/domain/entity/cart_iteam.dart';
import 'package:shoping/layers/domain/entity/product.dart';
import 'package:shoping/layers/presantation/cart_page/cart_screen.dart';
import 'package:shoping/layers/presantation/home_page/grid_card.dart';

final isGridViewProvider = StateNotifierProvider<GridViewNotifier, bool>((ref) {
  return GridViewNotifier();
});

class GridViewNotifier extends StateNotifier<bool> {
  GridViewNotifier() : super(false);

  void toggleView() {
    state = !state;
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsProvider);
    final cartItems = ref.watch(cartProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'E-commerce App',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          titleSpacing: 20,
          backgroundColor: const Color.fromARGB(255, 215, 208, 23),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScreen()));
                  },
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartItems.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        drawer: const Drawer(
          backgroundColor: Colors.white,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    ref.read(isGridViewProvider.notifier).toggleView();
                  },
                  icon: Icon(
                    ref.watch(isGridViewProvider)
                        ? Icons.list
                        : Icons.grid_view,
                  ),
                ),
              ],
            ),
            Expanded(
              child: productsAsyncValue.when(
                data: (products) {
                  final bool isGridView = ref.watch(isGridViewProvider);
                  return isGridView
                      ? SizedBox(
                          height: 400,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return ProductCard1(
                                products: product,
                              );
                            },
                          ),
                        )
                      : ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return buildProductItem(product, context, ref);
                          },
                        );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    Center(child: Text('Error: $error')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductItem(
      Products product, BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
      child: Container(
        height: 200,
        color: const Color.fromARGB(255, 246, 244, 244),
        child: ListTile(
          leading: Container(
            height: 200,
            color: Colors.white,
            child: ClipRRect(
              child: SizedBox(
                width: 120,
                height: 300,
                child: Image.network(
                  product.images![0],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          title: Text(product.title!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '₹ ${product.price}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              Text(
                product.description ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              RatingBar.builder(
                initialRating: product.rating ?? 0.0,
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                },
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Add to Cart"),
                        content: Text(
                            "Do you want to add ${product.title} to your cart?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              ref.read(cartProvider.notifier).addItem(
                                    CartItem(
                                      title: product.title ?? "",
                                      description: product.description ?? "",
                                      imageUrl: product.images != null &&
                                              product.images!.isNotEmpty
                                          ? product.images![0]
                                          : "",
                                      quantity: 1,
                                      price: product.price ?? 0.0,
                                    ),
                                  );
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'AddToCart',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
