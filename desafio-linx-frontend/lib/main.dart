import 'package:flutter/material.dart';
import './widgets/shoe_list.dart';
import './widgets/add_shoe.dart';
import './service/services.dart';

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

  void _reloadPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iShoes'),
        centerTitle: true,
      ),
      body: ShoeList(
          reloadHandler: _reloadPage),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddShoe(addNewShoe: addShoeService, updateHandler: _reloadPage);
                });
          },
          child: const Icon(Icons.add)),
    );
  }
}
