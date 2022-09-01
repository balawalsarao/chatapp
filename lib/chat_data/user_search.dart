import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchUserScreen extends StatefulWidget {
  const SearchUserScreen({Key? key}) : super(key: key);

  @override
  State<SearchUserScreen> createState() => _SearchUserScreenState();
}

class _SearchUserScreenState extends State<SearchUserScreen> {
  TextEditingController searchController = TextEditingController();
  /// step -1
  FirebaseFirestore ref = FirebaseFirestore.instance;

  Map<String,dynamic> userdata = {};

  bool isLoading = false;

  /// search function
  searchUserData()async{
    await ref.collection('User')
        .where("email",isEqualTo: searchController.text.trim(),)
        // .where("email",isNotEqualTo: searchController.text.trim())
        .get()
        .then((e) {
          setState(() {
              userdata = e.docs[0].data();
              // userdata.addAll(e.docs);
            });
        });
print('User Data ${userdata}');
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(10.0) ,
            child: Column(
              children: [
                /// search Bar COntainer
                Container(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'enter user email...',
                    ),
                  ),
                ),
                /// Search Button
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: searchUserData,

                    child: Text('Search User'),
                  ),
                ),
                /// Show User
                userdata.isNotEmpty
                    ? Container(
                    child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: Text(userdata['name']),
                            subtitle: Text(userdata['email']),
                          ),
                        )
                      ],
                    )
                )
                    : Container(child: Text('No Data Found'),),
              ],
            ),
          )
        )
    );
  }
}
