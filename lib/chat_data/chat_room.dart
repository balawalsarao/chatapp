import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoomScreen extends StatefulWidget {

   Map<String, dynamic> userMap={};
   String chatId;

   ChatRoomScreen({Key? key,required this.userMap,required this.chatId}) : super(key: key);

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {


  TextEditingController sendController = TextEditingController();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  /// Send Message Function
  void setMessageData()async {
    Map<String,dynamic> message={
      "message" : sendController.text.trim(),
      "sendby":FirebaseAuth.instance.currentUser!.email,
      "time":FieldValue.serverTimestamp(),
    };
    await firebaseFirestore
        .collection('UserChat')
        .doc(widget.chatId)
        .collection('chat')
        .add(message);

    sendController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // title: Text(widget.userMap['name']),
            title: StreamBuilder(
              stream: firebaseFirestore.collection('User').doc(widget.userMap['uid']).snapshots(),
              builder: (context,snapShot){
                if(!snapShot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return Container(
                    child: Column(
                      children: [
                        Text(widget.userMap['name']),
                        Text(widget.userMap['status'],style: TextStyle(fontSize: 12.0),),
                      ],
                    ),
                  );
                }
              },
            ),

          ),
          body:  StreamBuilder<QuerySnapshot>(
            stream: firebaseFirestore
                .collection('UserChat')
                .doc(widget.chatId)
                .collection('chat')
                .orderBy('time',descending: false)
                .snapshots(),
            builder: (builder,snapShot){
              if(!snapShot.hasData){
                return Center(child: CircularProgressIndicator(),);
              }else{
                return Container(
                  child: ListView.builder(
                    itemCount: snapShot.data!.docs.length,
                      itemBuilder: (context,index){
                    return Container(
                      alignment: snapShot.data!.docs[index]['sendby'] == FirebaseAuth.instance.currentUser!.email
                      ?Alignment.centerRight
                      :Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Text(snapShot.data!.docs[index]['message']),
                      ),
                    );
                  }
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.all(10.0) ,
            height: MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                /// TextField
                Expanded(
                  child: TextField(
                    controller: sendController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'type message here ... ',
                    ),
                  ),
                ),
                /// Send Button Icon
                Container(
                  child: IconButton(
                    onPressed:setMessageData,
                    icon: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}

