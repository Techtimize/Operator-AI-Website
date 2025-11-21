// lib/cart/cart_provider.dart
import 'package:flutter/material.dart';
import 'cart_model.dart';
import '../widgets/cart_dialog.dart';



class CartProvider extends StatefulWidget {
  final Widget child;
  final CartModel model;

  const CartProvider({
    super.key,
    required this.child,
    required this.model,
  });

  // Access the state (and model) easily:
  static _CartProviderState? of(BuildContext context) {
    return context.findAncestorStateOfType<_CartProviderState>();
  }

  @override
  State<CartProvider> createState() => _CartProviderState();
}

class _CartProviderState extends State<CartProvider> {
  late final CartModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  // show cart dialog (calls our CartDialog widget)
  void openCart(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CartDialog(cartModel: model),
    );
  }

  // open checkout directly (if you want)
  void openCheckout(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CheckoutDialog(cartModel: model),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provide the model down the tree and rebuild when the model notifies listeners
    return AnimatedBuilder(
      animation: model,
      builder: (context, _) => widget.child,
    );
  }
}
