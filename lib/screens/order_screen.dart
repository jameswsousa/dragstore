import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/loading_animation.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pedido Realizado"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 250,
                  height: 300,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      CustomLoadingWidget(),
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/lojavirtualjames.appspot.com/o/comprou.gif?alt=media&token=944bd6ad-ffcf-4d8d-afe6-eb302f9dea8c',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Perido realizado com sucesso",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              "Código do pedido: $orderId",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
