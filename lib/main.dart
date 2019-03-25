import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/MainScreen/HomePage.dart';
import 'package:flutter_shop/MainScreen/CategoryPage.dart';
import 'package:flutter_shop/MainScreen/ShoppingCar.dart';
import 'package:flutter_shop/MainScreen/MyPage.dart';
import 'package:flutter_shop/bean/category.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provider/CountProvide.dart';
import 'package:flutter_shop/provider/IsVisable.dart';
import 'package:flutter_shop/provider/RightCategoryProvider.dart';
import 'package:flutter_shop/bean/RightCategory.dart';
//入口初始化provider



void main(){
      List<BxMallSubDto> bxMallSubDto=[];
      List<RightCategoryData> rightList=[];
     var providers= Providers()
    ..provide(Provider.function((context)=>new Count(num: 0,num2: 0,bxMallSubDto:bxMallSubDto)))
    ..provide(Provider.function((context)=>IsVisable(visable: false)))
    ..provide(Provider.function((context)=>RightCategoryProvider(rightList,0,'4','')));
     runApp(ProviderNode(child: MyApp(), providers: providers));
  //runApp(MyApp());
}

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
           // appBar: AppBar(title: Text("百姓生活"),),
           // body: _ActivityList()[currenIndex],

            body:IndexedStack(
              children: _ActivityList(),
              index: currenIndex,
            ),

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
   _ActivityList<Widget>()=>[
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

 

