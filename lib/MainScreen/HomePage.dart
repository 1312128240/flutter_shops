import 'package:flutter/material.dart';
import 'package:flutter_shop/Utils/HttpClient.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String bean="首页数据";
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    print("设备信息${ScreenUtil.screenHeight}&&${ScreenUtil.screenWidth}&&${ScreenUtil.statusBarHeight}&&${ScreenUtil.bottomBarHeight}&&${ScreenUtil.pixelRatio}");
    return Container(
         color: Colors.black12,
         child: SingleChildScrollView(
           child: FutureBuilder(
             future: getHomePageData(),
             builder: (context,snapshot){
               if(snapshot.hasData){
                 var data=jsonDecode(snapshot.data.toString());
                 print("网络数据$data");
                 List lists=data['data']['slides'];
               //  List<Map> gridLists=(data['data']['category']
                 //as是类型转换,cast
                 List gridLists=(data['data']['category'] as List).cast();
                 return Column(
                   children: <Widget>[
                     SwiperWidge(swiperList: lists),
                     TopGridView(gridList:gridLists,),
                   ],
                 );
               }else{
                 Text("正在加载");
               }
             },

           ) ,
         )


    );
  }
}

class SwiperWidge extends StatefulWidget {
  @override
  _SwiperWidgeState createState() => _SwiperWidgeState();
   List swiperList;
   
  SwiperWidge({Key key,@required this.swiperList}):super(key:key);
  
  
}

class _SwiperWidgeState extends State<SwiperWidge> {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.screenWidth,
      child: Swiper(
        itemCount: widget.swiperList.length,
        itemBuilder: (context, index) {
          return Image.network(
            widget.swiperList[index]['image'], fit: BoxFit.fill,);
        },
        autoplay: true,
        pagination: SwiperPagination(),
      ),
    );
  }
  }

  class TopGridView extends StatelessWidget {
    List gridList;
    TopGridView({Key key,this.gridList}):super(key:key);
    @override
    Widget build(BuildContext context) {
      if(gridList.length>10){
        gridList.removeRange(10, gridList.length);
      }
      return Container(
         height: 150.0,
         padding: const EdgeInsets.only(top: 5.0),
         margin: const EdgeInsets.only(top: 5.0),
         color: Colors.white,
         child: GridView.count(
             primary: false,
             crossAxisCount: 5,
             crossAxisSpacing: 5.0,
             mainAxisSpacing: 5.0,
             physics: new NeverScrollableScrollPhysics(),
             children: gridList.map((item){
               return InkWell(
                 onTap: (){
                   print("点击跳转");
                 },
                 child: Column(
                   children: <Widget>[
                     Image.network(item["image"],width: ScreenUtil.getInstance().setWidth(95),),
                     Text(item['mallCategoryName']),
                   ],
                 ) ,
               );
             }).toList(),
         ),
      );
    }
  }









