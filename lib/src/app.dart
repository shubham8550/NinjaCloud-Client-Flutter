import 'package:flutter/material.dart';
import 'package:ninjacloud/screen/home.dart';
import 'package:ninjacloud/signup/signup.dart';
import 'package:ninjacloud/src/login.dart';


class app extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
     // home:login_page()
     onGenerateRoute: (RouteSettings settings){
       if(settings.name == '/home'){
         return MaterialPageRoute(builder: (context){
           return home_page();
         },
        );
       }else if(settings.name == '/signup'){
         return MaterialPageRoute(builder: (context){
           return signup_page();
         },
        );
       }else{
          return MaterialPageRoute(builder: (context){
           return login_page();
         },
        );
       }

     },
    );
  } 
  login_page(){
    return   Scaffold(
        //backgroundColor: Color.alphaBlend(Colors.indigo, Colors.white),
        resizeToAvoidBottomPadding: false,
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("graphics/animebg.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: Login() /* add child content here */,
        ), 
    ); 
  }

  signup_page(){
    return   Scaffold(
        //backgroundColor: Color.alphaBlend(Colors.indigo, Colors.white),
        resizeToAvoidBottomPadding: false,
        body:Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("graphics/animebg.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: signup() /* add child content here */,
        ), 
    ); 
  }




}
