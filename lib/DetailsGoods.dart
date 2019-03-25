import 'package:flutter/material.dart';

class DetailsGoods extends StatelessWidget {

  String params;
  DetailsGoods({Key key,this.params}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品详情"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text('传过来参数是-->$params'),
      ),

    );
  }
}
