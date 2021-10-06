import 'package:flutter/material.dart';
import './shoe_widget.dart';
import '../models/shoe.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

var _shoesUrl = Uri.http('192.168.0.33:5000', '/api/shoe/');

enum HttpRequestStatus { notDone, done, error }

class ShoeList extends StatelessWidget {
  const ShoeList(
      {Key? key,
      required this.shoeList,
      required this.editingHandler,
      required this.reloadHandler})
      : super(key: key);

  final Iterable<Shoe> shoeList;

  final Function editingHandler;

  final Function reloadHandler;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Shoe>>(
      future: getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return Dismissible(
                  key: Key(item.id.toString()),
                  onDismissed: (direction) async {
                    var httpRequestStatus = await deleteShoe(item.id);
                    if (httpRequestStatus == HttpRequestStatus.done) {
                      snapshot.data!.removeAt(index);
                      reloadHandler();
                    }
                  },
                  background: Container(color: Colors.red),
                  child: ShoeWidget(snapshot.data![index], editingHandler),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner
        return const CircularProgressIndicator();
      },
    );
  }
}

Future<List<Shoe>> getAll() async {
  final response = await http.get(_shoesUrl);
  List responseJson = json.decode(response.body.toString());
  List<Shoe> userList = createShoeList(responseJson);
  return userList;
}

List<Shoe> createShoeList(List data) {
  List<Shoe> list = [];

  for (int i = 0; i < data.length; i++) {
    int id = data[i]["id"];
    String modelName = data[i]["modelname"];
    String brand = data[i]["brand"];
    int stock = data[i]["stock"];
    int size = data[i]["size"];
    double price = data[i]["price"];
    Shoe newShoe = Shoe(
        id: id,
        modelName: modelName,
        brand: brand,
        stock: stock,
        size: size,
        price: price);
    list.add(newShoe);
  }

  return list;
}

Future deleteShoe(int id) async {
  var httpRequestStatus = HttpRequestStatus.notDone;
  final url = Uri.http('192.168.0.33:5000', '/api/shoe/$id');
  final response = await http.delete(url);
  if (response.statusCode == 200) {
    print(response.body.toString());
    httpRequestStatus = HttpRequestStatus.done;
  } else {
    httpRequestStatus = HttpRequestStatus.error;
  }

  return httpRequestStatus;
}


