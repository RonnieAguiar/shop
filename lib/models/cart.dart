import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items => {..._items};

  int get itemsCount => _items.length;

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existItem) => CartItem(
                id: existItem.id,
                productId: existItem.productId,
                name: existItem.name,
                quantity: existItem.quantity + 1,
                price: existItem.price,
              ));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
                id: Random().nextDouble().toString(),
                productId: product.id,
                name: product.name,
                quantity: 1,
                price: product.price,
              ));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (existItem) => CartItem(
          id: existItem.id,
          productId: existItem.productId,
          name: existItem.name,
          quantity: existItem.quantity - 1,
          price: existItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
