import 'package:cloud_firestore/cloud_firestore.dart';
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
  void setMessageData(){

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.userMap['name']),
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

