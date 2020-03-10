



import 'package:flutter/material.dart';

import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:ninjacloud/src/Manager.dart';
import 'package:ninjacloud/src/bloc.dart';
import 'package:slider_button/slider_button.dart';

class signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    
    return centerCard(context);
  }

  Widget centerCard(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 450,
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                logoContener(),
                usernameField(),
                emailField(),
                passwordField(),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                ),
                submitButton(),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                ),
                slidersignup(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget usernameField() {
    return StreamBuilder(
      stream: bloc.username,
      builder: (BuildContext, snapshot) {
        return TextField(
          decoration: InputDecoration(
            hintText: 'Username',
            labelText: 'Username',
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeUsername,
        );
      },
    );
  }
  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext, snapshot) {
        return TextField(
          
          decoration: InputDecoration(
            hintText: 'example@example.com',
            labelText: 'Email',
            errorText: snapshot.error,
          ),
          onChanged: bloc.changeEmail,
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (BuildContext, snapshot) {
        return TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
          onChanged: bloc.changepassword,
        );
      },
    );
  }

  Widget submitButton() {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (BuildContext context, snapshot) {
        return RaisedButton(
          child: Text('SignUp'),
          color: Colors.white70,
          onPressed: snapshot.hasData
              ? () {
                  print("value submitting Signup");
                  bloc.signupsubmit(context);
                }
              : null,
        );
      },
    );
  }

//  Widget signUpbutton() {
//    return RaisedButton(
//      child: Text("Sign up"),
//      color: Colors.lightGreenAccent,
//      onPressed: () {
//        print("sign up pressed"); //----------signup here
//      },
//    );
//  }

  Widget logoContener() {
    return Container(
      width: 200,
      height: 80,
      margin: EdgeInsets.only(bottom: 10),
      child: Image(image: AssetImage('graphics/logo.png')),
    );
  }

  Widget slidersignup(BuildContext context) {

    return SliderButton(


      action: () {
        ///Do something here
        //Navigator.of(context).pop();
          Navigator.pushNamed(context, "/"); 
        print("signup  slide"); //-------------signup here
      },
      label: Text(
        "Go to Login",
        style: TextStyle(
            color: Color(0xff4a4a4a),
            fontWeight: FontWeight.w500,
            fontSize: 17),
      ),
      icon: Text(
        "x",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 44,
        ),
      ),
    );
  }
}
