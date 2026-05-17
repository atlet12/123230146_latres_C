import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<ProductsResponse> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products?limit=100'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return ProductsResponse.fromJson(json);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Product> fetchProductById(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/$id'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Product.fromJson(json);
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
