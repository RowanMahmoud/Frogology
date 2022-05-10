import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graduationproj1/modules/auth_service.dart';
import 'package:graduationproj1/modules/db_service.dart';
import 'package:graduationproj1/modules/message.dart';
import 'package:graduationproj1/modules/message_component.dart';
import 'package:graduationproj1/modules/users.dart';
import 'package:hexcolor/hexcolor.dart';
class ChatPage extends StatelessWidget {
  ChatPage ({Key key , this.user}) : super(key: key);
  final CUser user ;
  final msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar:
      AppBar(
        backgroundColor:  HexColor("#f29268"),
        systemOverlayStyle:SystemUiOverlayStyle(statusBarColor: HexColor("#f29268")),
        title: Text(
        user.name,
        style: TextStyle(
          color:Colors.white
        ),
      ) ,
        centerTitle: true,
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: DBServices().getMessage(user.uid),
                  builder: (context,s1){
                    if(s1.hasData)
                      {

                        // ignore: missing_return
                        return StreamBuilder<List<Message>>(
                            stream: DBServices().getMessage(user.uid,false),
                            builder: (context,s2)
                        {
                        if(s2.hasData)
                          {
                            var messages = [...s1.data,...s2.data];
                            messages.sort((i,j)=> i.createAt.compareTo(j.createAt));
                            messages =messages.reversed.toList();
                            return messages.isEmpty ?Center(
                              child: Text(
                                "No Messages"
                              ),
                            ):
                            ListView.builder (
                                itemCount: messages.length,
                                reverse: true,
                                itemBuilder: (context, index){
                              final msg = messages[index];
                              return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                  child: MessageComponent(msg: msg));

                            }
                            );
                          }
                          else
                            {
                            return Center(
                              child:CircularProgressIndicator() ,
                            );
                            }
                        }
                        );
                      }
                    else
                      {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                  },
                )
            ),
            Material(
              elevation: 100,
              borderRadius: BorderRadius.only(
                bottomLeft:Radius.circular(20) ,
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: Row(
                children : [
              Expanded(
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Message",
                    border:( InputBorder.none)
                   ,
                    contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    //   focusedBorder: OutlineInputBorder(
                    //     borderSide:  BorderSide(color: HexColor("#f29268"), width: 0.4),
                    //     borderRadius: BorderRadius.circular(50.0),
                    //   ),
                    // border: OutlineInputBorder(
                    //     borderSide:  BorderSide(color: HexColor("#f29268"), width: 0.4),
                    //     borderRadius: BorderRadius.circular(25.0),
                    //
                    // )
                  ),
                  controller: msgController,
                  maxLines: 5,
                  minLines: 1,
                ),
              ),
                  IconButton(onPressed: () async {
                    var msg=Message(content: msgController.text,createAt:Timestamp.now(), receiverUid: user.uid
                    , senderUid: AuthServices().user.uid);
                    msgController.clear();
                    await DBServices ().sendMessage(msg);
                  }, icon: Icon(Icons.send)
                  ,
                      color: HexColor("#f29268")
                  )
    ],
              ),
            ),
          ],
        ),
      )

      ,);
  }
}
