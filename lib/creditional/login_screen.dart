import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              /// login Screen heading
              Text('Login Screen'),
              /// email container
              Container(
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                  ),
                ),
              ),
              /// password container
              Container(
                margin: EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                  ),
                ),
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
                      Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()),);
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

