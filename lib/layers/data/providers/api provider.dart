import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoping/layers/data/providers/remote/apiServices.dart';
import 'package:shoping/layers/domain/entity/product.dart';

final productsProvider = FutureProvider<List<Products>>((ref) async {
  final apiService = ApiService();
  final List<Map<String, dynamic>> productsData =
      await apiService.fetchProducts();

  final List<Products> products =
      productsData.map((data) => Products.fromJson(data)).toList();

  return products;
});
