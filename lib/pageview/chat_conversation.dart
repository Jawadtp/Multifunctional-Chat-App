import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:clone_app/models/usermodel.dart';
import 'package:clone_app/models/messagemodel.dart';
import 'package:clone_app/firebase_methods.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class ChatConversation extends StatefulWidget
{
  UserModel receiver;

  ChatConversation({this.receiver});
  @override
  _ChatConversationState createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation>
{
  bool isTyping=false;
  TextEditingController controller=new TextEditingController();
  var keyboardVisibilityController = KeyboardVisibilityController();
  Methods meth = new Methods();
  UserModel sender;

  sendMessage()
  {
    String msg=controller.text;
    Message message=Message(message: msg, senderid: sender.uid, receiverid: widget.receiver.uid, timestamp: FieldValue.serverTimestamp(),
    type: 'text',);
    setState(() {
      isTyping=false;
    });
    meth.addMessageToDB(message);
    controller.clear();
  }

  addMediaModal(context)
  {
    showModalBottomSheet(context: context, elevation: 0, backgroundColor: Colors.black, builder: (context)
    {
      return Column(children:
      [
        Container(padding: EdgeInsets.symmetric(vertical: 15),child: Row(children:
        [
          FlatButton(child: Icon(Icons.close,color: Colors.white, size: 18,), onPressed: (){Navigator.maybePop(context);},),
          Text("Content and tools",style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),)
        ],),),

       modalTile("Media", "Share photos and videos", Icons.photo),
        modalTile("File", "Share files", Icons.insert_drive_file),
        modalTile("Contact", "Share contacts", Icons.contacts),
        modalTile("Location", "Share location", Icons.location_on),
        modalTile("Schedule call", "Arrange a call and get reminders", Icons.timer),
        modalTile("Create poll", "Share polls", Icons.poll),
      ],);
    });
  }

  Widget modalTile(String title, String subtitle, IconData icon)
  {
    return Container(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), child: Row(mainAxisAlignment: MainAxisAlignment.start,
      children:
      [
        Icon(icon, color: Colors.white, size: 35,),
        SizedBox(width: 20,),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text(title,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            Text(subtitle,style: TextStyle(color: Colors.white70,fontSize: 15),),

          ],)
      ],),);
  }
  Widget typeMessageBar()
  {
    return Container(padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(children:
    [
      InkWell(onTap: (){addMediaModal(context);},child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Container(padding: EdgeInsets.all(5),color: Colors.lightBlue,child: Icon(Icons.add,size: 17, color: Colors.white,)))),

      SizedBox(width: 7,),

      Expanded(child: TextField(onChanged: (val)
      {
        if(val.length>0 && val.trim()!="") setState(() {isTyping=true;});
        else setState(() {isTyping=false;});

        },style: TextStyle(color: Colors.white70), controller: controller,
        decoration: InputDecoration(hintText: "Enter a message", hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50)),borderSide: BorderSide.none),contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        filled: true, fillColor: Colors.white12, suffixIcon: InkWell(onTap: (){}, child: Icon(Icons.insert_emoticon,color: Colors.white,),),
      ),),),

      SizedBox(width: 5,),
      isTyping?Container():Padding(padding:EdgeInsets.symmetric(horizontal: 5),child: Icon(Icons.mic,color: Colors.white,),),
      isTyping?Container():Icon(Icons.camera_alt, color: Colors.white,),
      !isTyping?Container():ClipRRect(borderRadius: BorderRadius.circular(50),child: Container(margin: EdgeInsets.symmetric(horizontal: 0),padding: EdgeInsets.all(0),color: Colors.lightBlue,child: IconButton(icon: Icon(Icons.send,size: 18, color: Colors.white,),onPressed: ()
      {
          sendMessage();
      },))),

    ],),);
  }

  Widget singleMessageTile(String message, bool displayLeft)
  {
    return   displayLeft?Row(
      children: [
        Container(constraints:BoxConstraints(maxWidth: 300),decoration:BoxDecoration(color:  Colors.white12,borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomRight: Radius.circular(15))),margin:EdgeInsets.fromLTRB(10, 10, 5, 2.6),padding:EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text(message,style: TextStyle(color: Colors.white,fontSize: 18),),),
        Spacer(),
      ],
    ):  Row(
      children: [
        Spacer(),
        Container(constraints:BoxConstraints(maxWidth: 300),decoration:BoxDecoration(color:  Colors.lightBlue,borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15),bottomRight: Radius.circular(15))),margin:EdgeInsets.fromLTRB(10, 10, 5, 2.6),padding:EdgeInsets.fromLTRB(10, 10, 10, 10),child: Text(message,style: TextStyle(color: Colors.white,fontSize: 18),),),
      ],
    );

  }

  Widget listOfMessages()
  {
    return StreamBuilder(stream: FirebaseFirestore.instance.collection("messages").doc(sender.uid).collection(widget.receiver.uid).orderBy("timestamp",descending: false).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot)
    {
      return snapshot==null || !snapshot.hasData?Container():
       // Container(constraints: BoxConstraints(maxHeight: keyboardVisibilityController.isVisible?MediaQuery.of(context).size.height/2.5:MediaQuery.of(context).size.height/1.28),
  /*      child: */ ListView.builder(itemCount: snapshot.data.docs.length, scrollDirection: Axis.vertical, shrinkWrap:true,itemBuilder: (context, index)
        {
          return singleMessageTile(snapshot.data.docs[index].get('message'), snapshot.data.docs[index].get('senderID')!=sender.uid);
        },);
    //  );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keyboardVisibilityController=new KeyboardVisibilityController();
    meth.getCurrentUser().then((value)
    {
      setState(()
      {
        sender = UserModel(uid: value.uid, name: value.displayName, profilePhoto: value.photoURL);
      });

    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(backgroundColor: Colors.white10,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent,
        title: Text(widget.receiver.name),actions:
    [
      IconButton(icon: Icon(Icons.video_call),onPressed: (){},),
      IconButton(icon: Icon(Icons.call),onPressed: (){},),
    ],),
      body: Container(child: Stack(children: [
        Container(child: listOfMessages(), padding: EdgeInsets.only(bottom: 80),),
      Container(child: Column(children:
      [
        Spacer(),
        typeMessageBar(),
        SizedBox(height: 10,),
      ],))

      ],),)






/*
      Column(children: [
        Divider(color: Colors.white24,),
        listOfMessages(),

        Spacer(),
        typeMessageBar(),
        SizedBox(height: 10,),
      ],), */
      );
  }
}
