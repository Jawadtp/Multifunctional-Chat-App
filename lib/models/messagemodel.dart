import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Message
{
  String senderid, receiverid, type, message, photoURL;
  FieldValue timestamp;

  Message({this.senderid, this.receiverid, this.type, this.message, this.timestamp});
  Message.image({this.senderid, this.receiverid, this.type, this.message, this.timestamp, this.photoURL});

  Map getMap()
  {
    Map mymap = new Map<String, dynamic>();
    mymap['receiverID']=this.receiverid;
    mymap['senderID']=this.senderid;
    mymap['type']=this.type;
    mymap['message']=this.message;
  //  mymap['photoURL']=this.photoURL;
    mymap['timestamp']=this.timestamp;
    return mymap;
  }

  Message getMessageFromMap(Map<String, dynamic> mymap)
  {
    Message m = new Message();
 //   m.photoURL=mymap['photoURL'];
    m.timestamp=mymap['timestamp'];
    m.type=mymap['type'];
    m.senderid=mymap['senderID'];
    m.receiverid=mymap['receiverID'];
    m.message=mymap['message'];
    return m;
  }
}