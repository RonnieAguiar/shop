import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';

import '../models/cart.dart';
import '../models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 25,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.headline6?.color,
                      ),
                    ),
                  ),
                  const Spacer(),
                  CartButtom(cart: cart)
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(items[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class CartButtom extends StatefulWidget {
  const CartButtom({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<CartButtom> createState() => _CartButtomState();
}

class _CartButtomState extends State<CartButtom> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading ? const CircularProgressIndicator() : TextButton(
      style: TextButton.styleFrom(
        textStyle: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      onPressed: widget.cart.itemsCount == 0
          ? null
          : () async {
              setState(() => _isLoading = true);

              await Provider.of<OrderList>(context, listen: false)
                  .addOrder(widget.cart);
              widget.cart.clear();

              setState(() => _isLoading = false);
            },
      child: const Text('COMPRAR'),
    );
  }
}
