import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return CartScreen();
        }));
        
      },backgroundColor: Theme.of(context).primaryColor,
      child: Icon(Icons.shopping_cart, color: Colors.white,),
    );
  }
}
