import 'package:flutter/material.dart';
import './shoe_widget.dart';
import '../models/shoe.dart';

class ShoeList extends StatelessWidget {
  const ShoeList({Key? key, required this.shoeList, required this.editingHandler}) : super(key: key);

  final Iterable<Shoe> shoeList;

  final Function editingHandler;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: shoeList.length,
        itemBuilder: (ctx, index) {
          return ShoeWidget(shoeList.elementAt(index), editingHandler);
        });
  }
}
