import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200  ,
      height: 200,
      child: FlareActor(
        'assets/flare/gear.flr',
        animation: 'spin',
        fit: BoxFit.contain,
      ),
    );
  }
}
