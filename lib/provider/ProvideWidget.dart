import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provider/CountProvide.dart';

class ProvideWidget extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("状态管理"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Provide<Count>(builder: (context,child,cls){
               return Text("状态管理${cls.num2}");
            }),

            RaisedButton(
                onPressed:(){
                  Provide.value<Count>(context).reduce();
                },
                child: Text("点击我"),
            )
          ],
        ),
      ),
    );
  }
}