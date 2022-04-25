import 'package:flutter/material.dart';
import 'package:shop/providers/counter.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Exemplo Contador'),
        ),
      ),
      body: Column(
        children: [
          Text(provider?.state.value.toString() ?? '0'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
              setState(() => provider?.state.inc());
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: (){
              setState(() => provider?.state.dec());
            },
          ),
        ],
      ),
    );
  }
}
