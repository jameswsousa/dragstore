import 'package:flutter/material.dart';
import 'package:loja_virtual/tabs/home_tab.dart';
import 'package:loja_virtual/tabs/orders_tab.dart';
import 'package:loja_virtual/tabs/places_tab.dart';
import 'package:loja_virtual/tabs/product_tab.dart';
import 'package:loja_virtual/widgets/cart_button.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pagecontroller,
      children: <Widget>[
        Scaffold(
          floatingActionButton: CartButton(),
          body: HomeTab(),
          drawer: CustomDrawer(_pagecontroller),
        ),
        Scaffold(
          floatingActionButton: CartButton(),
          appBar: AppBar(
            title: Text(
              "Produtos",
            ),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pagecontroller),
          body: ProductTab(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pagecontroller),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pagecontroller),
        )
      ],
    );
  }
}
