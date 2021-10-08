// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import '../models/shoe.dart';
import 'simple_shoe_widget.dart';
import 'extended_shoe_widget.dart';

class ShoeWidget extends StatefulWidget {
  final Shoe shoe;
  final Function editingHandler;
  final Function updateHandler;

  const ShoeWidget(this.shoe, this.editingHandler, this.updateHandler);

  @override
  State<ShoeWidget> createState() => _ShoeWidgetState();
}

class _ShoeWidgetState extends State<ShoeWidget> {
  bool isExtended = false;

  void changeView() {
    setState(() {
      isExtended = !isExtended;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isExtended) {
      return ExtendedShoeWidget(
          changeView: changeView,
          shoe: widget.shoe,
          editingHandler: widget.editingHandler,
          updateHandler: widget.updateHandler);
    } else {
      return SimpleShoeWidget(
          changeView: changeView,
          shoe: widget.shoe,
          editingHandler: widget.editingHandler,
          updateHandler: widget.updateHandler);
    }
  }
}
