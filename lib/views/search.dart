import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchTextEdittingController= new TextEditingController();
  DatabaseMethods databaseMethods= new DatabaseMethods();

  QuerySnapshot searchSnapshot;

  initiateSearch(){
    databaseMethods.getUserByUsername(searchTextEdittingController.text).then((val){
      setState(() {
        searchSnapshot =val;
      });
    });
  }

  //create chatroom and send user to coversation screen, pushreplacement
  createChatroomAndStartConversation(String userName){
    List <String> users = [userName, ];
    databaseMethods.createChatRoom(/*chatRoomId, chatRoomMap*/)
  }


  Widget searchlist(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
      shrinkWrap: true,
        itemBuilder: (context, index){
        return SearchTile (
          userName: searchSnapshot.documents[index].data['name'],
          userEmail: searchSnapshot.documents[index].data['email'],
        );
      }): Container();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: Color(0x54FFFFFF),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(child: TextField(
                    controller: searchTextEdittingController ,
                    style: TextStyle(
                  color: Colors.white
              ),
                    decoration: InputDecoration(
                      hintText: "search unsername...",
                      hintStyle: TextStyle(
                        color: Colors.white54
                      ),
                      border: InputBorder.none,
                    ),
                  )),
                  GestureDetector(
                    onTap: (){
                     initiateSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors:[
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF),
                            ]
                          ),
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child: Image.asset("assets/images/search_white.png")),
                  ),
                ],
              ),
            ),
            searchlist()
          ],
        ),
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;
  SearchTile({this.userName, this.userEmail});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text (userName, style: simpleTextStyle(),),
                Text (userEmail, style: tinyTextStyle(), )
              ],
            ),

          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)
                ),
                padding: EdgeInsets.symmetric(vertical: 16 , horizontal: 16),
                child: Text('Message', style: simpleTextStyle(),),
              ),
          ),

        ],
      )
    );
  }
}
