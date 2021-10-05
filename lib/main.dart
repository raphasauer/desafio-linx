import 'package:flutter/material.dart';
import './widgets/shoe_list.dart';
import './widgets/add_shoe.dart';
import './models/shoe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<int, Shoe> _shoeMap = {
    1: Shoe(
        id: 1,
        modelName: 'Running shoes',
        brand: 'Adidas',
        size: 40,
        price: 179.99),
    2: Shoe(
        id: 2,
        modelName: 'Outdoor shoes',
        brand: 'Timberland',
        size: 38,
        price: 249.99),
  };

  final List<Shoe> _shoeList = [
    Shoe(
        id: 1,
        modelName: 'Running shoes',
        brand: 'Adidas',
        size: 40,
        price: 179.99),
    Shoe(
        id: 2,
        modelName: 'Outdoor shoes',
        brand: 'Timberland',
        size: 38,
        price: 249.99),
  ];

  void _addShoe(Shoe newShoe) {
    setState(() {
      _shoeMap[newShoe.id] = newShoe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iShoes'),
        centerTitle: true,
      ),
      body: ShoeList(shoeList: _shoeMap.values),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddShoe(addNewShoe: _addShoe);
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
