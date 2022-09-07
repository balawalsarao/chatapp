import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uolchatapp/common/text_field_widget.dart';
import 'package:uolchatapp/constant/color.dart';
import 'package:uolchatapp/home_screen/home_screen.dart';

import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController=TextEditingController(text: 'admin@gmail.com');
  TextEditingController passwordController=TextEditingController(text: '123456');

  TextWidget _textWidget = TextWidget();
  ColorWidget _colorWidget = ColorWidget();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              /// login Screen heading

              _textWidget.textWidget('Login Screen', 18.0, FontWeight.bold, _colorWidget.primaryColor),
              /// email container
              Container(
                child: _textWidget.textFieldWidget(emailController, 'email'),
              ),
              /// password container
              Container(
                margin: EdgeInsets.all(10.0),
                child: _textWidget.textFieldWidget(passwordController, 'password'),
              ),
              /// login button container
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () async{
                    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                    );
                    if(credential.user !=null){
                      Get.to(HomeScreen());
                      // Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()),);
                    }else{
                      print('Check internet connection first_name');
                    }
                  },
                  child: Text('Login User'),
                ),
              ),
              /// register button container
              Container(
                child: InkWell(
                  child: Text('If You don\'t  have account ? Regsiter'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                ),
              ),

            ],
          ),
        )
    );
  }
}

