import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 100,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: NetworkImage(
                  snapshot.data['icon'],
                ),
                fit: BoxFit.fitHeight)),
      ),
      title: Padding(
        padding: const EdgeInsets.all(15),
        child: Text(
          snapshot.data['title'],
          style: TextStyle(fontSize: 20, color: Color(0xff103981), fontWeight: FontWeight.w500),
        ),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CategoryScreen(snapshot)));
      },
    );
  }
}
