import 'package:flutter/material.dart';
import 'package:smart_warehouse_manager/views/products/add_edit_product_screen.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => const AddEditProductScreen()));
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Danh sách sản phẩm sẽ hiển thị ở đây.'),
        // TODO: Sử dụng StreamBuilder để hiển thị danh sách sản phẩm từ FirestoreService
      ),
    );
  }
}