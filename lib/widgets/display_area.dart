import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buoi2danghoangquoc/providers/calculator_provider.dart';
import 'package:buoi2danghoangquoc/utils/constants.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end, // Đẩy text xuống dưới cùng
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Biểu thức (Nhỏ hơn)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              provider.expression.isEmpty ? "0" : provider.expression,
              style: TextStyle(
                fontSize: 32,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Kết quả (To và nổi bật)
          Text(
            provider.result,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}