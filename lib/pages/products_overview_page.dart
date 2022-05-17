import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/product_grid.dart';
import '../models/product_list.dart';

enum FilterOptions{
  favorite,
  all,
}

class ProductsOverviewPage extends StatelessWidget {
  const ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Minha Loja')),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (FilterOptions selectedValue){
              selectedValue == FilterOptions.favorite ?
              provider.showFavoriteOnly()
              : provider.showAll();
            },
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
