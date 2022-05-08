import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduationproj1/modules/auth_service.dart';
import 'package:graduationproj1/modules/message.dart';
import 'package:graduationproj1/modules/users.dart';

class DBServices{
  var userCollection=FirebaseFirestore.instance.collection('users');
  var msgCollection=FirebaseFirestore.instance.collection('Messages');

  saveUser(CUser user)async{
    try{
      await userCollection.doc(user.uid).set(user.toJson());
    }catch(e){}
  }
  Stream<List<CUser>> get getDiscussionUser
  {
    return userCollection.where('uid',isNotEqualTo: AuthServices().user.uid).
    snapshots().map((event) => event.docs.map((e) => CUser.fromJson(e.data())).toList());
}
// ignore: non_constant_identifier_names
Stream<List<Message>> getMessage(String receiverUid,[bool myMessage=true])
{
  return msgCollection.where('senderUid', isEqualTo: myMessage?AuthServices().user.uid
  : receiverUid)
      .where('receiverUid' , isEqualTo: myMessage ? receiverUid :AuthServices().user.uid)
      .snapshots().map((event) => event.docs.map((e) => Message.fromJson(e.data(), e.id)).toList());
}

Future <bool> sendMessage(Message msg ) async
{
  try
  {
    await msgCollection.doc().set(msg.toJson());
    return true;
  }
  catch(e)
  {
    return false;
  }

}


 }