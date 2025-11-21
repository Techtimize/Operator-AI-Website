import 'package:flutter/foundation.dart';
import 'package:new_public_website/cart/cart_model.dart';

class CartUiState {
  final List<CartProduct> items;
  final double subtotal;
  final double discount;
  final double total;
  final bool isLoading;
  final String? errorMessage;

  const CartUiState({
    required this.items,
    required this.subtotal,
    required this.discount,
    required this.total,
    this.isLoading = false,
    this.errorMessage,
  });

  // copyWith method
  CartUiState copyWith({
    List<CartProduct>? items,
    double? subtotal,
    double? discount,
    double? total,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CartUiState(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  // initial empty state
  factory CartUiState.initial() {
    return const CartUiState(
      items: [],
      subtotal: 0,
      discount: 0,
      total: 0,
      isLoading: false,
      errorMessage: null,
    );
  }
}
