import 'package:flutter/material.dart';
import './widgets/shoe_list.dart';
import './widgets/add_shoe.dart';
import './models/shoe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

var _shoesUrl = Uri.http('192.168.0.33:5000', '/api/shoe/');

enum HttpRequestStatus { notDone, done, error }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iShoe',
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
  final Map<int, Shoe> _shoeMap = {};

  void _addShoe(Shoe newShoe) {
    setState(() {
      _shoeMap[newShoe.id] = newShoe;
    });
  }

  void _updateShoe(Shoe updatedShoe) {
    setState(() {
      _shoeMap.update(updatedShoe.id, (value) => updatedShoe);
    });
  }

  void _getShoeList() {
    setState(() {});
  }

  void _addShoeService(Shoe newShoe) async {
    var httpRequestStatus = await createShoe(newShoe);
    if (httpRequestStatus == HttpRequestStatus.done) {
      setState(() {});
    }
  }

  Future createShoe(Shoe newShoe) async {
    var httpRequestStatus = HttpRequestStatus.notDone;
    final response = await http.post(_shoesUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'id': newShoe.id,
          'modelname': newShoe.modelName,
          'brand': newShoe.brand,
          'stock': newShoe.stock,
          'size': newShoe.size,
          'price': newShoe.price
        }));
    if (response.statusCode == 200) {
      print(response.body.toString());
      httpRequestStatus = HttpRequestStatus.done;
    } else {
      httpRequestStatus = HttpRequestStatus.error;
    }

    return httpRequestStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iShoes'),
        centerTitle: true,
      ),
      body: ShoeList(
          shoeList: _shoeMap.values,
          editingHandler: _updateShoe,
          reloadHandler: _getShoeList),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddShoe(addNewShoe: _addShoeService);
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
