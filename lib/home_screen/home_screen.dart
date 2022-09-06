import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uolchatapp/chat_data/chat_room.dart';
import 'package:uolchatapp/chat_data/user_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver  {
  late double height;
  late double width;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    userStatus("online");
  }

 @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed){
      // online
      userStatus("online");
    }else{
      //offline
      userStatus("offline");
    }
  }

  /// update user status
  void userStatus(String status)async{
    await firebaseFirestore.collection('User').doc(auth.currentUser!.uid).update({
      "status":status,
    });

  }





  FirebaseAuth auth = FirebaseAuth.instance;
  /// step -1
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  ///Chat Id Function
  String roomChatId(String? user1, String? user2){ // user1= 123 & user2 = 456
    if(user1!.toLowerCase().codeUnits[0] > user2!.toLowerCase().codeUnits[0]){ // 123 > 456
      return "$user1$user2";
    }else{
      return "$user2$user1";
    }
  }
  @override

  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Home Screen'),
            actions: [
              /// search Button
              IconButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => const SearchUserScreen()),);

              }, icon: Icon(Icons.search)),

            ],
          ),
          body: Column(
            children: [
              Text('Welcome ${auth.currentUser!.email}'),
              /// Logout Button
              IconButton(onPressed: (){
                auth.signOut();
                Navigator.push(context,MaterialPageRoute(builder: (context) => const SearchUserScreen()),);
              },
                  icon: Icon(Icons.logout)),
              SizedBox(height: 100.0,),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: firebaseFirestore.collection('User').where("email",isNotEqualTo: FirebaseAuth.instance.currentUser!.email).snapshots(),
                    builder: (builder, snapshot){
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }else{
                        return Container(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context,index){
                              Map<String,dynamic> userData=snapshot.data!.docs[index].data();
                                return Card(
                                  child: ListTile(
                                    onTap: (){
                                      //ChatRoomScreen
                                      String chatId = roomChatId(FirebaseAuth.instance.currentUser!.uid, snapshot.data!.docs[index]['uid']);
                                      Navigator.push(context,MaterialPageRoute(builder: (context) =>
                                          ChatRoomScreen(
                                            userMap: userData,
                                            chatId: chatId,
                                          )),);

                                    },
                                    title: Text(snapshot.data!.docs[index]['name']),
                                    subtitle: Text(snapshot.data!.docs[index]['email']),
                                  ),
                                );
                              }),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          )
        ),
    );

  }
}

