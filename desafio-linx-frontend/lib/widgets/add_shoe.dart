import 'package:flutter/material.dart';
import '../models/shoe.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../service/services.dart';

class AddShoe extends StatelessWidget {
  AddShoe({Key? key, required this.addNewShoe, required this.updateHandler})
      : super(key: key);

  final idController = TextEditingController();
  final modelNameController = TextEditingController();
  final brandNameController = TextEditingController();
  final stockController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();
  final priceFormatter =
      CurrencyTextInputFormatter(decimalDigits: 2, locale: 'pt', symbol: 'R\$');

  final Function addNewShoe;
  final Function updateHandler;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollable: true,
      titleTextStyle: const TextStyle(
          color: Colors.purple, fontSize: 20, fontWeight: FontWeight.bold),
      title: const Text(
        'Adicionar calçado',
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        height: 340,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Código de referência", counterText: ''),
              controller: idController,
              maxLength: 25,
            ),
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
              keyboardType: const TextInputType.numberWithOptions(signed: false),
              decoration: const InputDecoration(hintText: 'Preço', counterText: ''),
              controller: priceController,
              maxLength: 9,
            ),
            ElevatedButton(
              child: const Text('Inserir calçado'),
              onPressed: () {
                priceController.text =
                    priceFormatter.getUnformattedValue().toString();
                priceController.text =
                    priceController.text.replaceAll(',', '.');
                if (!isIdTaken(int.parse(idController.text))) {
                  addNewShoe(
                      Shoe(
                          id: int.parse(idController.text),
                          stock: int.parse(stockController.text),
                          modelName: modelNameController.text,
                          brand: brandNameController.text,
                          size: int.parse(sizeController.text),
                          price: double.parse(priceController.text)),
                      updateHandler);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Código de referência já cadastrado'), backgroundColor: Colors.red[800],));
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
