import 'package:dio/dio.dart';
import 'package:smart_warehouse_manager/models/product_model.dart';


class ProductRepository {
  final Dio _dio;


  ProductRepository(this._dio);

  Future<List<Product>> getAllProducts() async {
    // Fetch all products from the API
    try {
      final response = await _dio.get('/products/getAllProduct');
      final List<dynamic> data = response.data;
      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<Product?> fetchProductById(String id) async {
    try {
      final response = await _dio.get('/products/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      print('Error fetching product by id: $e');
      return null;
    }
  }

  Future<bool> addProduct(Product product) async {
    try {
      await _dio.post('/products', data: product.toJson());
      return true;
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await _dio.put('/products/${product.id}', data: product.toJson());
      return true;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await _dio.delete('/products/$id');
      return true;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }
}

