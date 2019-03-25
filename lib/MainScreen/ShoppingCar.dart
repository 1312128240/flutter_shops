import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provider/CountProvide.dart';

class ShoppingCar extends StatefulWidget {
  @override
  _ShoppingCarState createState() => _ShoppingCarState();
}

class _ShoppingCarState extends State<ShoppingCar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Provide<Count>(
            builder: (context,child,scope){
              return Text("共享数据-->${scope.reduce()}");
            }
        )
      )
    );
  }
}
