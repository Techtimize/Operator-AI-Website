// lib/widgets/cart_button.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../cart/cart_provider.dart';
import '../cart/cart_model.dart';
import '../utils/app_reponsiveness/responsive_utils.dart';
import '../utils/app_reponsiveness/app_spaces.dart';

class CartButton extends StatelessWidget {
  final double size;

  const CartButton({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    final cartState = CartProvider.of(context)?.model;
    final count = cartState?.selectedCount ?? 0;
    final isMobile = ResponsiveUtils.isMobile(context);

    return GestureDetector(
      onTap: () => CartProvider.of(context)?.openCart(context),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFFEBF5FF), const Color(0xFFDCEEFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.blue.shade100),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              LucideIcons.shoppingCart,
              size: isMobile ? 18 : 20,
              color: Colors.blue.shade700,
            ),
            if (count > 0)
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$count',
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
