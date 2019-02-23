import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/MainScreen/HomePage.dart';
import 'package:flutter_shop/MainScreen/CategoryPage.dart';
import 'package:flutter_shop/MainScreen/ShoppingCar.dart';
import 'package:flutter_shop/MainScreen/MyPage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currenIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currenIndex=0;

  }

  @override
  Widget build(BuildContext context) {

    _getData();

    return Container(
        child: MaterialApp(
           debugShowCheckedModeBanner: false,
           theme: ThemeData(
             primaryColor: Colors.pink,
           ),
          home: Scaffold(
            appBar: AppBar(title: Text("AAAA"),),
            body: _ActivityList()[currenIndex],
            bottomNavigationBar: BottomNavigationBar(
                items: _bottomList(),
                type: BottomNavigationBarType.fixed,
                currentIndex: currenIndex,
                onTap: (i){
                  setState(() {
                    currenIndex=i;
                  });
                },

            ),

          ),
        ),
    );
  }

   void _getData(){

   }
   _ActivityList()=>[
     HomePage(),CategoryPage(),ShoppingCar(),MyPage(),
   ];

  
   _bottomList()=>[
     BottomNavigationBarItem(
       title: Text("首页"),
       icon: Icon(Icons.home),
     ),
     BottomNavigationBarItem(
         title: Text("分类"),
         icon: Icon(Icons.class_)
     ),
     BottomNavigationBarItem(
         title: Text("购物车"),
         icon: Icon(Icons.shopping_cart)
     ),
     BottomNavigationBarItem(
         title: Text("我的"),
         icon: Icon(Icons.supervised_user_circle)
     ),
   ];
}

 

