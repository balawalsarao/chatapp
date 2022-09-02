import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uolchatapp/creditional/login_screen.dart';
import 'package:uolchatapp/home_screen/home_screen.dart';

class checkUserScreen extends StatelessWidget {
  const checkUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if(auth.currentUser!=null){
      return HomeScreen();
      // return LoginScreen();
    }else{
      return LoginScreen();
    }
  }
}

