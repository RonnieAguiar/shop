import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}


// bool _showFavoriteOnly = false;

//   List<Product> get items {
//     return _showFavoriteOnly ?
//     _items.where((prod) => prod.isFavorite).toList()
//     : [..._items];
//   }

//   void showFavoriteOnly(){
//     _showFavoriteOnly = true;
//     notifyListeners();
//   }
  
//   void showAll(){
//     _showFavoriteOnly = false;
//     notifyListeners();
//   }