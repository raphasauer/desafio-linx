import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/shoe.dart';

//IP do server local
var _shoesUrl = Uri.http('192.168.0.33:5000', '/api/shoe/');

enum HttpRequestStatus { notDone, done, error }

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

Future updateShoe(Shoe updatedShoe) async {
  var httpRequestStatus = HttpRequestStatus.notDone;
  final response = await http.put(_shoesUrl,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'id': updatedShoe.id,
        'modelname': updatedShoe.modelName,
        'brand': updatedShoe.brand,
        'stock': updatedShoe.stock,
        'size': updatedShoe.size,
        'price': updatedShoe.price
      }));
  if (response.statusCode == 200) {
    print(response.body.toString());
    httpRequestStatus = HttpRequestStatus.done;
  } else {
    httpRequestStatus = HttpRequestStatus.done;
  }
  return httpRequestStatus;
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

Future updateShoeService(Shoe updatedShoe, Function updatePage) async {
  var httpRequestStatus = await updateShoe(updatedShoe);
  if (httpRequestStatus == HttpRequestStatus.done) {
    updatePage();
  }
}
