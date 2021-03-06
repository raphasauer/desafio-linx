import 'package:flutter/material.dart';
import 'package:i_shoes/models/shoe.dart';
import 'package:i_shoes/widgets/edit_shoe.dart';

class SimpleShoeWidget extends StatelessWidget {
  const SimpleShoeWidget(
      {Key? key,
      required this.changeView,
      required this.shoe,
      required this.editingHandler,
      required this.updateHandler})
      : super(key: key);

  final Function changeView;
  final Function editingHandler;
  final Function updateHandler;
  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(2.5),
        height: 115,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${shoe.brand} ${shoe.modelName}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Text('Tamanho: ${shoe.size}',
                          style: const TextStyle(
                              color: Colors.purple, fontSize: 16)),
                      Text(
                          'R\$ ${shoe.price.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          )),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: IconButton(
                            icon: const Icon(
                              Icons.expand_more,
                              color: Colors.purple,
                              size: 36,
                            ),
                            onPressed: () => changeView(),
                          ),
                        ),
                        TextButton(
                          child: const Icon(
                            Icons.edit,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditShoe(
                                      editShoe: editingHandler,
                                      shoe: shoe,
                                      updateHandler: updateHandler);
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
