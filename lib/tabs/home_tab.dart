import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: NetworkImage(
              //         'https://www.babybedding.com/images/fabric/bubblegum-gingham-fabric_large.jpg'), fit: BoxFit.cover),
              gradient: LinearGradient(colors: [
            Color(0xFF8A00FF),
            Color(0xFFE36C7C),
            Colors.yellow,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );
    return Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  "Novidades",
                  style: TextStyle(color: Colors.white),
                ),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection('home')
                  .orderBy('pos')
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverStaggeredGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    staggeredTiles: snapshot.data.documents.map((doc) {
                      return StaggeredTile.count(doc.data['x'], doc.data['y']);
                    }).toList(),
                    children: snapshot.data.documents.map((doc) {
                      return FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: doc.data['image'],
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
