import 'package:flutter/cupertino.dart';

class RouterUtils {
  //平移动画
  static dynamic pushTransititonsDetail(@required BuildContext context,@required Widget Nextactivity,{Function callBack(value)}) {
    Navigator.of(context).push(new PageRouteBuilder(pageBuilder: (context,animation, secondaryAnimation) {
      return Nextactivity;
    },transitionsBuilder:(context,animation, secondaryAnimation, child){
       return SlideTransition(
          // position: Tween(begin: const Offset(1.0, 0.0),end: const Offset(0.0, 0.0),).animate(animation),
         position: Tween(begin: const Offset(0.0, 1.0),end: const Offset(0.0, 0.0),).animate(animation),
         textDirection: TextDirection.ltr,
           child: child,
       );
    },transitionDuration: Duration(seconds: 1))).then((result){
       callBack(result);
    });
  }

  //缩放动画
  static dynamic pushScaleTransitionDetail(@required BuildContext context,@required Widget Nextactivity,{Function callBack(value)}) {
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return Nextactivity;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
        child: child,
      );
    },transitionDuration: Duration(seconds: 1))).then((result) {
      callBack(result);
    });
  }

    //旋转加缩放
  static dynamic pushRotation(@required BuildContext context,@required Widget Nextactivity,{Function callBack(value)}) {
    Navigator.of(context).push(new PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return Nextactivity;
        }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return RotationTransition(
        turns:Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: animation, curve:Curves.fastOutSlowIn)),
        child: ScaleTransition(
            scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: animation, curve:Curves.fastOutSlowIn)),
            child: child,
        ),
      );
    },transitionDuration: Duration(seconds: 1))).then((result) {
      callBack(result);
    });
  }

  //淡出淡出加缩放
  static dynamic pustFade(@required BuildContext context,@required Widget NextActivity){
    Navigator.of(context).push(PageRouteBuilder(pageBuilder:(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation){
       return NextActivity;
    },transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
       return FadeTransition(
           opacity:Tween(begin: 0.0,end:1.0).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
           child: ScaleTransition(scale: Tween(begin: 0.0,end: 1.0).animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
             child: child,
           ),

       );
    },transitionDuration: Duration(seconds: 1)));
   }

  }