import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:ninjacloud/src/Manager.dart';
import 'package:rxdart/rxdart.dart';

import 'Validators.dart';

class Block extends Validators {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get username => _username.stream.transform(validateUsername);



  Stream<String> get password => _password.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Observable.combineLatest2(username, password, (e, p) => true);

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeUsername => _username.sink.add;

  Function(String) get changepassword => _password.sink.add;
  submit(BuildContext context)async{
    final validUsername =_username.value;
    final validpassword= _password.value;
    
    //print('------------'+validUsername+'---'+validpassword);
    if(await loginAccount(validUsername, validpassword)==true){
      toast("Login Success");
       //await getfiles(validUsername);
       Navigator.pushNamed(context, '/home');
      
      
    }else{
      toast("Login Field");
    }
   
  }
  dispose() {
    _email.close();
    _password.close();
    _username.close();
  }
}

Block bloc = Block();
