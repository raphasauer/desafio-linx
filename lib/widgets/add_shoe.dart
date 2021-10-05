// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/shoe.dart';

class AddShoe extends StatelessWidget {
  AddShoe({Key? key, required this.addNewShoe}) : super(key: key);

  final modelNameController = TextEditingController();
  final brandNameController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();

  final Function addNewShoe;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollable: true,
      titleTextStyle: TextStyle(
          color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
      title: Text(
        'Adicionar calçado',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Nome do produto"),
              controller: modelNameController,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Marca do produto'),
              controller: brandNameController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Tamanho'),
              controller: sizeController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Preço'),
              controller: priceController,
            ),
            ElevatedButton(
              child: Text('Inserir calçado'),
              onPressed: () {
                addNewShoe(Shoe(
                    id: DateTime.now().millisecondsSinceEpoch,
                    modelName: modelNameController.text,
                    brand: brandNameController.text,
                    size: int.parse(sizeController.text),
                    price: double.parse(priceController.text)));
                    modelNameController.clear();
                    brandNameController.clear();
                    sizeController.clear();
                    priceController.clear();
              },
            )
          ],
        ),
      ),
    );
  }
}
