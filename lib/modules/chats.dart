// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter/material.dart';
import 'package:graduationproj1/modules/auth_service.dart';
import 'package:graduationproj1/modules/chattt.dart';
import 'package:graduationproj1/modules/db_service.dart';
import 'package:graduationproj1/shared/components/components.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'users.dart';
final _firestore=FirebaseFirestore.instance;

class Chats extends StatelessWidget {
  const Chats({key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    appBar: AppBar(
      title: Text('Chats...',
      style:
      // TextStyle(
      //     color:  HexColor("#819b6d"),
      // fontSize: 25,
      // ),
      Theme.of(context).textTheme.headline5,
       ),


    ),
    body: StreamBuilder <List<CUser>>(
      stream: DBServices().getDiscussionUser,
      // ignore: missing_return
      builder: (_,s){
        if(s.hasData)
          {
            final users = s.data;

            return  users.isEmpty?Center(
              child: Text('No one Available'),
            ):
            ListView.builder( itemCount: users.length,itemBuilder: (ctx,i){
              final user =users[i];
              return
              ListTile(onTap:(){
                navigateTo(context, ChatPage(user: user,));
              },
                leading: Container(alignment:Alignment.center ,
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle,color:Colors.grey.withOpacity(0.5)),
                child: Icon(Icons.person),
              ),title: Text(user.name

                ,
                  style:
                  Theme.of(context).textTheme.headline6,

                ),

                subtitle: Text(user.email
                ,
                style: Theme.of(context).textTheme.subtitle2,
                    ),

              );
            });
          }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      // children: [
      //   StreamBuilder<QuerySnapshot>(stream: _firestore.collection("chats").snapshots(),
      //     // ignore: missing_return
      //     builder: (context,snapshot){
      //       List <Text> messagewidget =[] ;
      //       final messages =snapshot.data.docs;
      //       for(var message in messages)
      //       {
      //         final chattext =message.get('title');
      //         final chatwidget = Text('$chattext');
      //         messagewidget.add(chatwidget);
      //
      //       }
      //       return Column(
      //           children: messagewidget
      //       );
      //     },
      //   )
      // ],
    ),
  );
  }
  }


