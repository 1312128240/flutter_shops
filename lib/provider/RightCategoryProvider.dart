import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/RightCategory.dart';

class RightCategoryProvider with ChangeNotifier{

  RightCategoryProvider(this.lists,this.clickposition,this.categoryId,this.categorySubId);

  List<RightCategoryData> lists=[];
  int clickposition=0;

  String categoryId="4";
  String categorySubId="";


  getCategoryRightData(bool b,List<RightCategoryData> beanlist,String cId,){
    //此方法表示点击了左边listview的位置，
    //所以要切换右边的顶部样，将索引回归到0
      if(b){
        clickposition = 0;
      }

        categoryId=cId;
        lists=beanlist;

        notifyListeners();
      }


  setClickPosition(int i,String subId){
    clickposition=i;
    categorySubId=subId;
    notifyListeners();
  }

}