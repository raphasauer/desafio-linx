import 'package:flutter/material.dart';
import './shoe_widget.dart';
import '../models/shoe.dart';
import '../service/services.dart';

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
                  child: ShoeWidget(snapshot.data![index], updateShoeService, reloadHandler),
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(
          child: CircularProgressIndicator(),
          );
      },
    );
  }
}


