// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/shoe.dart';

class ShoeWidget extends StatelessWidget {

  final Shoe shoe;

  ShoeWidget(this.shoe);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2.5),
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(shoe.modelName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),),
                  Text(shoe.brand,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16,
                    color: Colors.orange,

                  )),
                ],
              ),
              Text('Tamanho: ${shoe.size}', style: TextStyle(color: Colors.purple, fontSize: 16)),
              Text('R\$ ${shoe.price}', style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                                    color: Colors.purple,

              )),
            ],
          ),
        ),
      ),
    );
  }
}