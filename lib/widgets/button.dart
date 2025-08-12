import 'package:flutter/material.dart';

class NeumorphicButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final double height;
  final double width;
  final Color backgroundColor;
  final BorderRadius borderRadius;

  const NeumorphicButton({
    super.key,
    required this.onTap,
    required this.child,
    this.height = 50,
    this.width = double.infinity,
    this.backgroundColor = const Color(0xFFE0E5EC),
    BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? const BorderRadius.all(Radius.circular(25));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          boxShadow: const [
            // Shadow tối ở dưới/phải tạo hiệu ứng nổi
            BoxShadow(
              color: Color(0xFFA3B1C6),
              offset: Offset(4, 4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            // Shadow sáng ở trên/trái
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}