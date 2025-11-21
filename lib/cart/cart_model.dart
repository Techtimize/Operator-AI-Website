import 'package:flutter/foundation.dart';

class CartProduct {
  final String id;
  final String name;
  final int originalPrice;
  final String installationText;
  final String subscriptionText;
  final String promoText;

  CartProduct({
    required this.id,
    required this.name,
    required this.originalPrice,
    required this.installationText,
    required this.subscriptionText,
    required this.promoText,
  });
}

class CartModel extends ChangeNotifier {
  final List<CartProduct> products;
  final Set<String> _selectedIds = {};

  CartModel({required this.products});

  List<CartProduct> get allProducts => List.unmodifiable(products);

  List<CartProduct> get selectedProducts =>
      products.where((p) => _selectedIds.contains(p.id)).toList();

  bool isSelected(String id) => _selectedIds.contains(id);

  int get selectedCount => _selectedIds.length;

  void toggleProduct(String id) {
    if (_selectedIds.contains(id)) _selectedIds.remove(id);
    else _selectedIds.add(id);
    notifyListeners();
  }

  void clear() {
    _selectedIds.clear();
    notifyListeners();
  }
}
