// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/shoe.dart';

class EditShoe extends StatelessWidget {
  EditShoe({Key? key, required this.editShoe, required this.shoe})
      : super(key: key) {
    loadShoe();
  }

  final modelNameController = TextEditingController();
  final brandNameController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();

  final Function editShoe;
  final Shoe shoe;

  void loadShoe() {
    modelNameController.text = shoe.modelName;
    brandNameController.text = shoe.brand;
    sizeController.text = shoe.size.toString();
    priceController.text = shoe.price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollable: true,
      title: Text('Editar calçado', textAlign: TextAlign.center),
      titleTextStyle: TextStyle(
          color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "Nome do produto", counterText: ''),
              controller: modelNameController,
              maxLength: 25,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Marca do produto', counterText: ''),
              controller: brandNameController,
              maxLength: 25,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Tamanho', counterText: ''),
              controller: sizeController,
              maxLength: 2,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Preço', counterText: ''),
              controller: priceController,
              maxLength: 9,
            ),
            ElevatedButton(
              child: Text('Editar calçado'),
              onPressed: () {
                editShoe(Shoe(
                    id: shoe.id,
                    stock: 20,
                    modelName: modelNameController.text,
                    brand: brandNameController.text,
                    size: int.parse(sizeController.text),
                    price: double.parse(priceController.text)));
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
