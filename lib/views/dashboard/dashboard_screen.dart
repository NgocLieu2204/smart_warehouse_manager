import 'package:flutter/material.dart';
import 'package:smart_warehouse_manager/services/auth_service.dart';
import 'package:smart_warehouse_manager/views/products/product_list_screen.dart';
import 'package:smart_warehouse_manager/views/inventory/stock_transaction_screen.dart';
import 'package:smart_warehouse_manager/views/inventory/history_screen.dart';
import 'package:smart_warehouse_manager/views/reports/report_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              // AuthWrapper trong main.dart sẽ tự động điều hướng về màn hình Login
            },
            tooltip: 'Đăng xuất',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tổng quan',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Hàng 1: Các thẻ thống kê nhanh
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Sản phẩm',
                    value: '1,250', // TODO: Lấy dữ liệu thật từ Firestore
                    icon: Icons.inventory_2,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    context,
                    title: 'Sắp hết hàng',
                    value: '15', // TODO: Lấy dữ liệu thật từ Firestore
                    icon: Icons.warning_amber,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Chức năng',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Lưới các chức năng chính
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildFeatureCard(
                  context,
                  title: 'Quản lý sản phẩm',
                  icon: Icons.list_alt,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  title: 'Nhập / Xuất kho',
                  icon: Icons.sync_alt,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StockTransactionScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  title: 'Lịch sử giao dịch',
                  icon: Icons.history,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  title: 'Báo cáo & Thống kê',
                  icon: Icons.bar_chart,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReportScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget con cho thẻ thống kê
  Widget _buildStatCard(BuildContext context,
      {required String title,
      required String value,
      required IconData icon,
      required Color color}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(title, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }

  // Widget con cho thẻ chức năng
  Widget _buildFeatureCard(BuildContext context,
      {required String title, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}