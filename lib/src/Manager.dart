
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../filesdatamap.dart';
import '../resources/R.dart';

import 'package:http/http.dart' as http;

import 'package:async/async.dart';

import 'dart:convert';

Future<bool> createAccount(String username,String password,String email) async{
  final response = await http.get(R.SERVERURL+'signup.php?username=$username&password=$password&email=$email');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    toast(json.decode(response.body)['status']);
    if(json.decode(response.body)['bool']== "true"){
      return true;
    }else{
      return null;
    }

  } else {
    // If that response was not OK, throw an error.
    toast("Unable to connect server");
  }
}
Future<bool> getfiles(String username)async{
  final response = await http.get(R.SERVERURL+'getdata.php?u=$username');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.

    print(json.decode(response.body)["0"]["url"]);
    
    R.totalfiles= json.decode(response.body).length;
  
   // json.decode(response.body);
    allFiles=new List();
try {
      for(int i=0;i<R.totalfiles;i++){
    allFiles.add(new filed(int.parse(json.decode(response.body)["${i.toString()}"]["id"]),
                              json.decode(response.body)["${i.toString()}"]["ext"],
                              json.decode(response.body)["${i.toString()}"]["filename"],
                              int.parse(json.decode(response.body)["${i.toString()}"]["filesize"]),
                              json.decode(response.body)["${i.toString()}"]["url"]));


     }

} catch (e) {
  print(e);
}

    toast("data filled succcessfully --:${allFiles[1].url}");
    return true;
  } else {
    // If that response was not OK, throw an error.
    toast("Unable to connect server");
    return false;
  }
 

}
Future<bool> loginAccount(String username,String pass)async{
  final response = await http.get(R.SERVERURL+'signin.php?username=$username&password=$pass');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    toast(json.decode(response.body)['status']);
    if(json.decode(response.body)['bool']== "true"){
      R.username=username;
      R.password=pass;
     await getfiles(username);
      return true;

    }else{
      return false;
    }

  } else {
    // If that response was not OK, throw an error.
    toast("Unable to connect server");
  }
  return false;

}

toast(String msg1){
  Fluttertoast.showToast(
      msg: msg1,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );

}