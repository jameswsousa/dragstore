import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/loading_animation.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  OrderTile(this.orderId);
  @override
  Widget build(BuildContext context) {
    return Card(
              color: Colors.purple[100],

      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CustomLoadingWidget(),
              );
            } else {
              int status=snapshot.data['status'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Código do Pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(_buildProductText(snapshot.data)),
                  SizedBox(
                    height: 4,
                  ),
                   Text(
                    "Status do Pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), SizedBox(
                    height: 4,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparação",status , 1),
                      Container(width: 40, height: 3, color: Colors.purple,),
                      _buildCircle("2", "Transporte", status, 2),
                      Container(width: 40, height: 3, color: Colors.purple,),

                      _buildCircle('3', "Entrega", status, 3),
                    ],
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n';
    for (LinkedHashMap p in snapshot.data['products']) {
      text +=
          '${p["quantity"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n';
    }
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;
    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple[100]),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        )
      ],
    );
  }
}
