import 'package:flutter/material.dart';

class IsVisable with ChangeNotifier{

   bool visable=false;

   IsVisable({this.visable});

   setVisable(bool b){
     visable=!b;
     notifyListeners();
   }
}