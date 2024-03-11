import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    try {
      final response = await _dio.get('https://dummyjson.com/products');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;

        final List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(responseData['products']);

        return products;
      } else {
        throw Exception('Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
