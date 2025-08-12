import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/auth/auth_event.dart';
import '../../views/products/product_list_screen.dart';
import '../../views/inventory/stock_transaction_screen.dart';
import '../../views/inventory/history_screen.dart';
import '../../views/reports/report_screen.dart';
import '../../widgets/buttton.dart'; // Đảm bảo bạn đã import NeumorphicButton

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0E5EC), // Nền Neumorphism
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Color(0xFF333A44), fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Ẩn nút back mặc định
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 8.0, bottom: 8.0),
            child: NeumorphicButton(
              onTap: () {
                // Gửi sự kiện LogoutRequested đến AuthBloc
                context.read<AuthBloc>().add(LogoutRequested());
              },
              width: 50,
              height: 50,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
              child: const Icon(Icons.logout, color: Colors.blueGrey),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tổng quan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333A44),
              ),
            ),
            const SizedBox(height: 20),
            // Các thẻ thống kê nhanh
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'Sản phẩm',
                    value: '1,250', // TODO: Lấy dữ liệu thật từ Firestore
                    icon: Icons.inventory_2_outlined,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildStatCard(
                    title: 'Sắp hết hàng',
                    value: '15', // TODO: Lấy dữ liệu thật từ Firestore
                    icon: Icons.warning_amber_rounded,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            const Text(
              'Chức năng',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333A44),
              ),
            ),
            const SizedBox(height: 20),
            // Lưới các chức năng chính
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildFeatureCard(
                  context: context,
                  title: 'Quản lý sản phẩm',
                  icon: Icons.list_alt_rounded,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
                  },
                ),
                _buildFeatureCard(
                  context: context,
                  title: 'Nhập / Xuất kho',
                  icon: Icons.sync_alt_rounded,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StockTransactionScreen()));
                  },
                ),
                _buildFeatureCard(
                  context: context,
                  title: 'Lịch sử giao dịch',
                  icon: Icons.history_rounded,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
                  },
                ),
                _buildFeatureCard(
                  context: context,
                  title: 'Báo cáo & Thống kê',
                  icon: Icons.bar_chart_rounded,
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

  // Widget con cho thẻ thống kê (Neumorphism Style)
  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EC),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFA3B1C6),
            offset: Offset(4, 4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(-4, -4),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333A44),
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  // Widget con cho thẻ chức năng (Neumorphism Style)
  Widget _buildFeatureCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return NeumorphicButton(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Theme.of(context).primaryColor),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF333A44),
              ),
            ),
          ),
        ],
      ),
    );
  }
}