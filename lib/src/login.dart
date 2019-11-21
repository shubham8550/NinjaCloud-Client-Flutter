import 'package:flutter/material.dart';
import 'bloc.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:slider_button/slider_button.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return centerCard();
  }

  Widget centerCard() {
    return Center(
      child: Card(
        color: Colors.black12,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            //print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 500,
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                logoContener(),
                emailField(),
                passwordField(),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                ),
                submitButton(),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                ),
                slidersignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return StreamBuilder(
      stream: bloc.email,
      builder: (BuildContext, snapshot) {
        return TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'you@example.com',
            labelText: 'EMail Address',
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
      builder: (BuildContext, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          color: Colors.white70,
          onPressed: snapshot.hasData
              ? () {
                  print("value submitting");
                  bloc.submit();
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

  Widget slidersignup() {

    return SliderButton(


      action: () {
        ///Do something here
        //Navigator.of(context).pop();
        print("signup  slide"); //-------------signup here
      },
      label: Text(
        "Go to Signup",
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
