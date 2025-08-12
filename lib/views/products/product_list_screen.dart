import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse_manager/views/products/add_edit_product_screen.dart';
import 'package:smart_warehouse_manager/blocs/product/product_bloc.dart';
import 'package:smart_warehouse_manager/blocs/product/product_state.dart';
import 'package:smart_warehouse_manager/models/product_model.dart'; // model Product

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddEditProductScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'Có lỗi xảy ra')),
            );
          }
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } 
          else if (state is ProductLoaded) {
            // Nếu state.products đã là List<Product> thì không cần map lại từ JSON
            final List<Product> products = state.products;

            if (products.isEmpty) {
              return const Center(child: Text('Không có sản phẩm nào.'));
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    leading: product.imageUrl.isNotEmpty
                        ? Image.network(
                            product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.inventory),
                    title: Text(product.name),
                    subtitle: Text(
                        'Số lượng: ${product.quantity} - Vị trí: ${product.location}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddEditProductScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } 
          else {
            return const Center(child: Text('Không tìm thấy sản phẩm.'));
          }
        },
      ),
    );
  }
}
