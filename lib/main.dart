import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart/cart_model.dart';
import 'app.dart'; // your MainApp file

void main() {
  final products = [
    CartProduct(
      id: 'ai-sales',
      name: 'AI Sales',
      originalPrice: 800,
      installationText: 'Installation',
      subscriptionText: '360 AED/month',
      promoText: "Free installation November '25",
    ),
    CartProduct(
      id: 'ai-marketing',
      name: 'AI Marketing',
      originalPrice: 800,
      installationText: 'Installation',
      subscriptionText: '360 AED/month',
      promoText: "Free installation November '25",
    ),
    CartProduct(
      id: 'ai-customer-service',
      name: 'AI Customer Service',
      originalPrice: 800,
      installationText: 'Installation',
      subscriptionText: '360 AED/month',
      promoText: "Free installation November '25",
    ),
  ];

  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(products: products),
      child: const MainApp(),
    ),
  );
}
