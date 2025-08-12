import 'package:dio/dio.dart';
import 'package:smart_warehouse_manager/models/product_model.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository(this._dio);

  // Base path cho product API
  final String _productPath = '/api/product';

  Future<List<Product>> getAllProducts() async {
    try {
      // URL đầy đủ sẽ là: http://localhost:5000/api/product/getAllProduct
      final response = await _dio.get('$_productPath/getAllProduct');
      
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data;
        return data.map((item) => Product.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching products: $e');
      throw Exception('Failed to fetch products');
    }
  }

  Future<Product?> fetchProductById(String id) async {
    try {
      final response = await _dio.get('$_productPath/$id');
      return Product.fromJson(response.data);
    } catch (e) {
      print('Error fetching product by id: $e');
      return null;
    }
  }

  Future<bool> addProduct(Product product) async {
    try {
      // Endpoint để thêm sản phẩm mới
      await _dio.post('$_productPath/createProduct', data: product.toJson());
      return true;
    } catch (e) {
      print('Error adding product: $e');
      return false;
    }
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await _dio.put('$_productPath/${product.id}', data: product.toJson());
      return true;
    } catch (e) {
      print('Error updating product: $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      await _dio.delete('$_productPath/$id');
      return true;
    } catch (e) {
      print('Error deleting product: $e');
      return false;
    }
  }
}