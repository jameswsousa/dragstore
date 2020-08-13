import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/screens/login_screen.dart';
import 'package:loja_virtual/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;
  CustomDrawer(this.pageController);
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFFF55A2),
            Colors.white,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.only(
                  top: 16,
                  left: 16,
                  bottom: 8,
                ),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text(
                        "Flutter's\nDragging",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                      top: 25,
                      left: 0,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          print(model.isLoggedIn());
                          print(model.userData);
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Olá, ${!model.isLoggedIn() ? "" : model.userData['name']}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!model.isLoggedIn()) {
                                     Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return LoginScreen();
                                    }));
                                  } else return model.signOut();
                                },
                                child: Text(
                                  !model.isLoggedIn()
                                      ? "Entre ou cadastre-se   >"
                                      : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Início", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.location_on, "Lojas", pageController, 2),
              DrawerTile(
                  Icons.playlist_add_check, "Meus Pedidos", pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
