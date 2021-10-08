import 'package:flutter/material.dart';
import './shoe_widget.dart';
import '../models/shoe.dart';
import '../service/services.dart';

class ShoeList extends StatelessWidget {
  const ShoeList(
      {Key? key, required this.reloadHandler})
      : super(key: key);


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
                  background: Container(
                    child: Card(
                      color: Colors.red[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  child: ShoeWidget(
                      snapshot.data![index], updateShoeService, reloadHandler),
                );
              });
        } else if (snapshot.hasError) {
          return const Center(
              child: Icon(
            Icons.cloud_off,
            size: 100,
            color: Colors.purple,
          ));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
