import 'HttpUrl.dart';
import 'package:dio/dio.dart';
import 'dart:io';

 Future RequestData(url,{params}) async{
   Response response=null;
   Dio dio=null;
   try{
     dio=new Dio();
     dio.options.contentType=ContentType.parse('application/x-www-form-urlencoded');  //数据被编码为名称/值对。这是标准的编码格式。
     response=await dio.post(url,data: params);
     if(response.statusCode==200){
       return response.data;
     }else{
       print("返回状态${response.statusCode}");
     }
   }catch (e){
     print("网络异常${e.toString()}");
   }

 }