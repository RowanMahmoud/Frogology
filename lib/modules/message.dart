
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduationproj1/modules/auth_service.dart';

class Message  {
  String uid;
  String content;
  String senderUid;
  String receiverUid;
  Timestamp createAt;
  Message({
    this.content,
    this.uid,
    this.createAt,
    this.receiverUid,
    this.senderUid
});
  Message.fromJson(Map <String,dynamic> json, String id)
  {
    uid = id;
    content =json ['content'];
    createAt =json ['createAt'];
    receiverUid =json ['receiverUid'];
    senderUid =json ['senderUid'];
  }
  Map <String, dynamic> toJson ()
  {
  return {
    'content':content,
    'createAt':createAt,
    'receiverUid':receiverUid,
    'senderUid':senderUid,
  } ;
  }
  bool get isMe => AuthServices().user.uid==senderUid;





}
