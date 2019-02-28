import 'HttpUrl.dart';
import 'package:dio/dio.dart';
import 'dart:io';

 Future getHomePageData() async{
   try{
     Dio dio=new Dio();
     dio.options.contentType=ContentType.parse('application/x-www-form-urlencoded');  //数据被编码为名称/值对。这是标准的编码格式。
     var formData={'lon':'115.02932','lat':'35.76189'};
     print("走这里,11");
     Response response=await dio.post(httpUrl['HomePageUrl'],data: formData);

     if(response.statusCode==200){
       return response.data;
     }else{
       print("返回状态${response.statusCode}");
     }
    }catch (e){
      print("网络异常${e.toString()}");
    }


 }