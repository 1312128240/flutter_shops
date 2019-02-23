import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/Utils/config.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result="网络访问数据";
  @override
  Widget build(BuildContext context) {
    return Container(

      child:SingleChildScrollView(
        child:Column(
          children: <Widget>[
            RaisedButton(onPressed: (){
              /*_getData().then((result){
               print("网络结果数据"+result);
             });*/
              _getData().then((val){
                setState(() {
                  result=val.toString();
                  print("极客数据$val");
                });
              });
            },
              child: Text("点击我访问网络"),),
            Text(result),
          ],
        ),
      )


    );
  }
  Future _getData() async {

   try{
      Dio dio=new Dio();
      dio.options.headers=Headers;
      Response response=await dio.get("https://time.geekbang.org/serv/v1/column/newAll");
     return response.data;
     // var status=bean['data']['_req']['header']['user-agent'];
      // return result.toString();
    }catch (e){
       print("失败原因${e.toString()}");
    }
  }

}
