import 'package:flutter/material.dart';
import 'package:flutter_shop/Utils/HttpClient.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_shop/Utils/HttpUrl.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_shop/DetailsGoods.dart';
import 'package:flutter_shop/provider/ProvideWidget.dart';

List beanList=[];

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  String bean="首页数据";
  int currentpage=1;
  GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
   // print("设备信息${ScreenUtil.screenHeight}&&${ScreenUtil.screenWidth}&&${ScreenUtil.statusBarHeight}&&${ScreenUtil.bottomBarHeight}&&${ScreenUtil.pixelRatio}");
    var formData={'lon':'115.02932','lat':'35.76189'};

    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
        centerTitle: true,
      ),
      body:FutureBuilder(
          future: RequestData(httpUrl['HomePageUrl'],params: formData),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data=jsonDecode(snapshot.data.toString());
              print("网络数据$data");
              List lists=data['data']['slides'];
              //  List<Map> gridLists=(data['data']['category']
              //as是类型转换,cast
              List gridLists=(data['data']['category'] as List).cast();
              //小广告
              String adPicture=data['data']['advertesPicture']['PICTURE_ADDRESS'];
              //拨打电话
              String phoneNumber=data['data']['shopInfo']['leaderPhone'];
              String phonePic=data['data']['shopInfo']['leaderImage'];
              //推荐列表
              List<Map> recomList=(data['data']['recommend'] as List).cast();
              //楼层组件
              String floor1Title=data['data']['floor1Pic']['PICTURE_ADDRESS'];
              List<Map> floor1List=(data['data']['floor1'] as List).cast();

              String floor2Title=data['data']['floor2Pic']['PICTURE_ADDRESS'];
              List<Map> floor2List=(data['data']['floor2'] as List).cast();

              String floor3Title=data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor3List=(data['data']['floor3'] as List).cast();


              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  moreInfo: '加载中',
                  noMoreText: '',
                  showMore: true,
                  loadReadyText: '上拉加载',
                ),
                refreshHeader: ClassicsHeader(
                  key: _headerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,

                ),


                child: ListView(
                  children: <Widget>[
                    SwiperWidge(swiperList: lists),
                    TopGridView(gridList:gridLists,),
                    ImageBanner(imgUrl: adPicture,),
                    CallPic(pic: phonePic,phoneNo: phoneNumber,),
                    Recomend(beanList: recomList,),
                    Floor(floorList: floor1List,floorTitle: floor1Title,),
                    Floor(floorList: floor2List,floorTitle: floor2Title,),
                    Floor(floorList: floor3List,floorTitle: floor3Title,),

                    Hot(),

                  ],

                ),

                loadMore:() async{
                  RequestData(httpUrl['homePageBelowConten'],params:{'page',currentpage}).then((val){
                    var result=json.decode(val.toString());
                    List<Map> newList=(result['data'] as List).cast();
                    setState(() {
                      beanList.addAll(newList);
                      currentpage++;
                    });

                  });

                },

                onRefresh: ()async{
                  Fluttertoast.showToast(
                    msg: "下拉刷新",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,

                  );
                },
              );


            }else{
              Text("正在加载");
            }
          },

        ) ,

      );

  }


}

class SwiperWidge extends StatelessWidget {

  List swiperList;

  SwiperWidge({Key key, this.swiperList}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.screenWidth,
      child: Swiper(
        itemCount: swiperList.length,
        itemBuilder: (context, index) {
          return Image.network(
            swiperList[index]['image'], fit: BoxFit.fill,);
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
         margin: const EdgeInsets.only(top: 5.0,bottom: 5.0),
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
                 child: InkWell(
                   child: Column(
                     children: <Widget>[
                       Image.network(item["image"],width: ScreenUtil.getInstance().setWidth(95),),
                       Text(item['mallCategoryName']),
                     ],
                   ),
                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                        return DetailsGoods(params:item['mallCategoryName'],);
                     }));
                   },
                 )


               );
             }).toList(),
         ),
      );
    }
  }

  //小广告条
  class ImageBanner extends StatelessWidget{
    String imgUrl;
    ImageBanner({Key key, this.imgUrl}):super(key:key);

     @override
     Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
       color: Colors.white,
       child: Image.network(imgUrl),
      );
    }
  }

  //拨打电话
 class CallPic extends StatelessWidget{

  String pic;
  String phoneNo;
  CallPic({Key key,this.pic,this.phoneNo}):super(key:key);


   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
          child: Image.network(pic),
          onTap: (){
              _call();
          },
       );

  }

  void _call() async{
     String tell='tel:'+phoneNo;
     if(await canLaunch(tell)){
       launch(tell);
     }else{
       print("url异常");
     }
  }
 }

 //推荐
 class Recomend extends StatelessWidget{
  
  List beanList;
  Recomend({Key key,this.beanList}):super(key:key);
  

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Container(
      margin: EdgeInsets.only(top: 6.0),
      child: InkWell(
        child: Column(
          children: <Widget>[
            _title(),
            lists(),
          ],
        ),
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>ProvideWidget()));
        },
      )


    );


  }
  
  Widget _title(){
     return Container(
       padding: const EdgeInsets.all(5.0),
       alignment: Alignment.centerLeft,
       decoration: BoxDecoration(
         color: Colors.white,
         border:Border(
           bottom: BorderSide(color: Colors.grey,width: 0.5)
         )
       ),

       child: Text('商品推荐',style: TextStyle(color: Colors.red,fontSize: 13.0),)
           
     );

  }

  Widget lists(){
     return Container(
           height: ScreenUtil.getInstance().setHeight(410),
           child: ListView.builder(
           itemCount: beanList.length,
           itemBuilder: (context,index){
             return Container(
                 height: ScreenUtil.getInstance().setHeight(320),
                 width: ScreenUtil.getInstance().setHeight(330),
                 margin: EdgeInsets.only(right: 1.0),
                 color: Colors.white,
                 child:Column(
                   children: <Widget>[
                     Image.network(beanList[index]['image'],),
                     Text("¥${beanList[index]['mallPrice']}"),
                     Text("¥${beanList[index]['price']}",
                       style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey)),
                   ],
                 ) ,
               );

           },
           scrollDirection: Axis.horizontal,
         )
       );

  }


  
 }
 
 //楼层组件
 class Floor extends StatelessWidget{

  List floorList;
  String floorTitle;
  Floor({Key key,this.floorList,this.floorTitle}):super(key:key);


 @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        height: 332.0,
        child: Column(
           children: <Widget>[
             Image.network(floorTitle),

             Row(
               children: <Widget>[
                 Expanded(child: Container(
                  // height: 200.0,
                   child: Column(
                     children: <Widget>[
                       Image.network(floorList[0]['image']),
                       Image.network(floorList[1]['image']),
                     ],
                   ),
                 )),

                 Expanded(child: Container(//height: 200.0,
                          child: Column(
                            children: <Widget>[
                              Image.network(floorList[2]['image']),
                              Image.network(floorList[3]['image']),
                              Image.network(floorList[4]['image']),
                            ],
                          ),
                 )),
               ],
             )
           ],
        ),
    );
  }
 }

 //火爆专区
class Hot extends StatefulWidget {
  @override
  _HotState createState() => _HotState();
}

class _HotState extends State<Hot> {

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('火爆专区',style: TextStyle(fontSize: 13.0),),
          ),
          _wrap(),
        ],
      );

  }

  Widget _wrap(){
     if(beanList.length!=0){
       return Wrap(
         spacing: 1,
         children:beanList.map((bean){
           return Container(
             color: Colors.white,
             width: ScreenUtil.getInstance().setWidth(370),
             child: Column(
               children: <Widget>[
                 Image.network(bean['image'],width: ScreenUtil.getInstance().setWidth(370),),
                 Text(bean['name'],style: TextStyle(color: Colors.pink),maxLines: 1,overflow: TextOverflow.ellipsis,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text('¥${bean['mallPrice']}'),
                     Text('¥${bean['price']}',style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),)
                   ],
                 )
               ],
             ),
           );
         }).toList(),
       );

     }else{
       return Text("");
     }
  }

}










