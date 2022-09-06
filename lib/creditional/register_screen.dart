import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uolchatapp/creditional/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

  /// step -1
  FirebaseFirestore ref = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: [
                /// register Screen heading
                Text('Register Screen'),
                /// username container
                Container(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'User name',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),/// email container
                Container(
                  child: TextField(
                    controller:emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Email',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                /// password container
                Container(
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
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );

                      /// set user display name
                      var user=credential.user;
                      user!.updateDisplayName(nameController.text.trim());


                      /// step-2 set data
                      await ref.collection('User').doc(FirebaseAuth.instance.currentUser!.uid).set({
                        "uid":FirebaseAuth.instance.currentUser!.uid,
                        "name" : nameController.text.trim(),
                        "email" : emailController.text.trim(),
                        "status":"",
                      });
                    },
                    child: Text('Register User'),
                  ),
                ),
                /// register button container
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    child: Text('If You  have account ? Login'),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                ),

              ],
            ),
          )
        )
    );
  }

}

