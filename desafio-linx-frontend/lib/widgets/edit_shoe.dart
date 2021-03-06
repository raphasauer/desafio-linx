import 'package:flutter/material.dart';
import '../models/shoe.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class EditShoe extends StatelessWidget {
  EditShoe(
      {Key? key,
      required this.editShoe,
      required this.shoe,
      required this.updateHandler})
      : super(key: key) {
    loadShoe();
  }

  final modelNameController = TextEditingController();
  final brandNameController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final priceFormatter =
      CurrencyTextInputFormatter(decimalDigits: 2, locale: 'pt', symbol: 'R\$');

  final Function editShoe;
  final Function updateHandler;
  final Shoe shoe;

  void loadShoe() {
    modelNameController.text = shoe.modelName;
    brandNameController.text = shoe.brand;
    sizeController.text = shoe.size.toString();
    priceController.text = priceFormatter.format(shoe.price.toString()).toString();
    stockController.text = shoe.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollable: true,
      title: const Text('Editar calçado', textAlign: TextAlign.center),
      titleTextStyle: const TextStyle(
          color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              decoration:
                  const InputDecoration(hintText: "Nome do produto", counterText: ''),
              controller: modelNameController,
              maxLength: 25,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Marca do produto', counterText: ''),
              controller: brandNameController,
              maxLength: 25,
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: const InputDecoration(hintText: 'Estoque', counterText: ''),
              controller: stockController,
              maxLength: 3,
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(
                  signed: false, decimal: false),
              decoration: const InputDecoration(hintText: 'Tamanho', counterText: ''),
              controller: sizeController,
              maxLength: 2,
            ),
            TextField(
              inputFormatters: [
                priceFormatter,
              ],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Preço', counterText: ''),
              controller: priceController,
              maxLength: 13,
            ),
            ElevatedButton(
              child: const Text('Editar calçado'),
              onPressed: () {
                priceController.text =
                    priceFormatter.getUnformattedValue().toString();
                priceController.text =
                    priceController.text.replaceAll(',', '.');

                editShoe(
                    Shoe(
                        id: shoe.id,
                        stock: int.parse(stockController.text),
                        modelName: modelNameController.text,
                        brand: brandNameController.text,
                        size: int.parse(sizeController.text),
                        price: double.parse(priceController.text)),
                    updateHandler);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
