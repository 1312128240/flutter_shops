import 'package:flutter/material.dart';
import 'package:flutter_shop/Utils/HttpUrl.dart';
import 'package:flutter_shop/Utils/HttpClient.dart';
import 'dart:convert';
import 'package:flutter_shop/bean/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provider/CountProvide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/provider/IsVisable.dart';
import 'package:flutter_shop/bean/RightCategory.dart';
import 'package:flutter_shop/provider/RightCategoryProvider.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  List<CategoryDataList> beanlist = [];


  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
        centerTitle: true,
      ),
      body:Row(
          children: <Widget>[

            LeftList(lists: beanlist,),

            Stack(
              children: <Widget>[

                Column(
                  children: <Widget>[
                    RightTopList(),
                    Provide<RightCategoryProvider>(builder:(context,child,cls){
                       if(cls.lists.length!=0){
                         return RightGrildView();

                       }else {
                         return Text("暂无数据");
                       }
                    }
                    )

                  ],
                ),
                PoPWidget(),
              ],
            )


          ],
        ),

    );

  }



 //左边商品列表
  void getData() async {
    await RequestData(httpUrl['getCategory']).then((val) {
      var result = json.decode(val.toString());

      Category bean = Category.fromJson(result);

      setState(() {
        beanlist = bean.CategorydataList;
        Provide.value<Count>(context).getTopCategoryList(beanlist[0].bxMallSubDto);
      });
    });
  }

}

/**
 *
 * 左边listview
 */
class LeftList extends StatefulWidget{
  List lists;

  LeftList({Key key, this.lists}) :super(key: key);

  @override
  _LeftListState createState() => _LeftListState();
}


class _LeftListState extends State<LeftList> {

  int currentIndex=0;
  String mallCategoryId;
  String mallCategorySubId;

  @override
  void initState() {
    super.initState();
    //默认值
    _getRightData(context,true,'4','');
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: ScreenUtil.getInstance().setWidth(180),
      child: ListView.builder(
        itemCount:widget.lists.length,
        itemBuilder: (context, index) {
          return leftListItem(context, index);
        },

      ),
    );
  }


  leftListItem(context, index) =>

      InkWell(
        child:Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 5.0),
                decoration: BoxDecoration(
                  color:_changeBgColor(index)?Colors.black12:Colors.white,
                  // color:,
                    border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0),
                      right: BorderSide(color: Colors.black12, width: 1.0),
                    )
                ),
                height: ScreenUtil.getInstance().setHeight(100),

                child: Text(widget.lists[index].mallCategoryName,
                  style: TextStyle(fontSize: ScreenUtil.getInstance().setSp(28)),),
              ),


        onTap: () {
          var childList = widget.lists[index].bxMallSubDto;
          Provide.value<Count>(context).getTopCategoryList(childList);

         setState(() {
            currentIndex=index;

            mallCategoryId=widget.lists[currentIndex].mallCategoryId;
           // Provide.value<RightCategoryProvider>(context).setCategoryId(mallCategoryId,'');


           /* mallCategoryId=widget.lists[currentIndex].mallCategoryId;*/
            Provide.value<RightCategoryProvider>(context).getCategoryRightData(true,[],mallCategoryId);
            _getRightData(context,true,mallCategoryId,'');


          });


        },
      );


  _changeBgColor (index) {
    if(currentIndex==index){
      return true;
    }else{
      return false;
    }
  }
}


/**
 * 顶部条listviwe
 */
class RightTopList extends StatelessWidget{
 //  int  ClickIndex=0;
   bool vissable=false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


      return Row(

        children: <Widget>[

         Provide<Count>(builder:(context,child,cls){
           return  Container(
             height: ScreenUtil.getInstance().setHeight(75),
             width: ScreenUtil.getInstance().setWidth(500),
             decoration: BoxDecoration(
                 color: Colors.white,
                 border: Border(
                     bottom: BorderSide(width: 1.0,color: Colors.black12)
                 )
             ),
             child: ListView.builder(
               itemBuilder: (context,index){
                 return Container(
                   alignment:Alignment.centerLeft,
                   padding: EdgeInsets.only(left: 5.0,right: 5.0),
                   child: Provide<RightCategoryProvider>(
                       builder:(context,child,cls2){
                         return  InkWell(
                           child: Text(cls.bxMallSubDto[index].mallSubName,
                             style: TextStyle(color: _ChangeTextColor(cls2.clickposition,index)?Colors.pink:Colors.black),),
                           onTap: (){

                             Provide.value<RightCategoryProvider>(context).setClickPosition(index,cls.bxMallSubDto[index].mallSubId);

                             _getRightData(context,false, cls2.categoryId, cls.bxMallSubDto[index].mallSubId);

                           },
                         );

                       }
                   )



                 );
               },
               itemCount: cls.bxMallSubDto.length,
               scrollDirection: Axis.horizontal,

             ),

           );
         }),

         InkWell(
           child:Icon(Icons.arrow_downward),
           onTap:(){
             Provide.value<IsVisable>(context).setVisable(vissable);
             vissable=!vissable;
           },
         )
    ],
    );
  }


   _ChangeTextColor(clickposition,itemposition)=>clickposition==itemposition?true:false;
}


//右边商品listviw
class RightGrildView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<RightCategoryProvider>(
        builder:(context,child,cls){
          return Container(
              width: ScreenUtil.getInstance().setWidth(545),
              height:ScreenUtil.getInstance().setWidth(990),
              child: ListView.builder(
                itemCount: cls.lists.length,
                itemBuilder:(context,index){
                  return _item(cls.lists[index]);
                },

              )
          );
        });
  }

  Widget _item(RightCategoryData bean){
    return Container(
      height: ScreenUtil.getInstance().setHeight(350),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color:Colors.black12,width: 0.5))
      ),
      child: Column(
        children: <Widget>[
          Image.network(bean.image,width: 100.0,height: 100.0,),

          Container(
            alignment: Alignment.centerLeft,
            child:Text(bean.goodsName,style: TextStyle(color: Colors.pink),),
          ),

          Container(height: ScreenUtil.getInstance().setHeight(30),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('¥${bean.oriPrice}',),
              Text('¥${bean.presentPrice}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12.0,
                  decoration: TextDecoration.lineThrough,),
              ),
            ],
          )
        ],
      ),
    );
  }
}

//隐藏或显示控件
class PoPWidget extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Provide<IsVisable>(
        builder: (context,child,cls){
          return AnimatedOpacity(
              opacity:cls.visable?1.0:0.0,
              duration: Duration(milliseconds: 500),
              child:Container(
                margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(75)),
                width: ScreenUtil.getInstance().setHeight(545),
                height: 150.0,
                color: Colors.amber,
              ),
          );


        }

    );
  }
}




   //获取右边商品列表
   _getRightData(BuildContext context,bool b,String categoryId,String categorySubId) {

  var map={
    "categoryId":categoryId,
    "categorySubId":categorySubId,
    'page':'1'
  };
  RequestData(httpUrl['getCategoryRight'],params: map).then((result){
    var bean=json.decode(result.toString());
    List<RightCategoryData>  lists= RightGoods.fromJson(bean).data;
    if(lists.length!=0){
      Provide.value<RightCategoryProvider>(context).getCategoryRightData(b,lists,categoryId);

    }else{
      Provide.value<RightCategoryProvider>(context).getCategoryRightData(b,[],categoryId);
    }

  });
}


