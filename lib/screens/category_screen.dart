import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data['title']),
              centerTitle: true,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.grid_on),
                  ),
                  Tab(
                    icon: Icon(Icons.list),
                  )
                ],
                indicatorColor: Colors.white,
              ),
            ),
            body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection('products')
                  .document(snapshot.documentID)
                  .collection('items')
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        GridView.builder(
                          padding: EdgeInsets.all(4),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  childAspectRatio: 0.65),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                            ProductData data = ProductData.fromDocument(
                                snapshot.data.documents[index]);
                                data.category=this.snapshot.documentID;
                            return ProductTile('grid', data);
                          },
                        ),
                        ListView.builder(
                          padding: EdgeInsets.all(4),
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (BuildContext context, int index) {
                             ProductData data = ProductData.fromDocument(
                                snapshot.data.documents[index]);
                                data.category=this.snapshot.documentID;
                            return ProductTile(
                                'list',
                               data);
                          },
                        )
                      ]);
                }
              },
            )));
  }
}
