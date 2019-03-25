import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/category.dart';


class Count with ChangeNotifier{

   var num=0;
   int num2=1;


   Count({this.num,this.num2,this.bxMallSubDto});


   List<BxMallSubDto> bxMallSubDto=[];

   add(){
     num++;
     notifyListeners();
   }

   reduce(){
     num2--;
     notifyListeners();
   }


    getTopCategoryList(List<BxMallSubDto> lists){
          BxMallSubDto  dto=new BxMallSubDto(mallSubId:"00",mallCategoryId: "00",mallSubName: "全部" );

          bxMallSubDto=[dto];

          bxMallSubDto.addAll(lists);


          notifyListeners();
   }

}


