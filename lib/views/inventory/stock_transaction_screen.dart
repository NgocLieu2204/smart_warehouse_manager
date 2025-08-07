import 'package:flutter/material.dart';

class StockTransactionScreen extends StatelessWidget {
  const StockTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nhập / Xuất kho')),
      body: const Center(child: Text('Giao diện nhập/xuất kho')),
    );
  }
}