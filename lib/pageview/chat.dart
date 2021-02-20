import 'package:clone_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:clone_app/firebase_methods.dart';
import 'search.dart';
class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
{
  Methods meth = new Methods();
  Utils utils= new Utils();
  String currentUserID;
  String initials;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   meth.getCurrentUser().then((value)
   {
     setState(()
     {

       currentUserID=value.uid;
       initials = utils.getInitials(value.displayName);
     });
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent,
      title: Row(children:
      [
        IconButton(icon: Icon(Icons.notifications), onPressed: (){},),
        Spacer(),
        SizedBox(width: 30,),
        DPCircle(initials),

        Spacer(),
        IconButton(icon: Icon(Icons.search), onPressed: ()
        {
          Navigator.push(
              context, MaterialPageRoute(builder: (BuildContext context) => SearchScreen()));
        },),
        IconButton(icon: Icon(Icons.more_vert), onPressed: (){},),
      ],),
    ),
      backgroundColor: Colors.white10,
      body: ListView.builder(itemCount: 5, itemBuilder: (context, index)
      {
        return InkWell(onTap: (){},child: CustomChatTile(name: "Mohammed Jawad",subtitle: "Hey there, yo", status: true, photoURL: "https://lh3.googleusercontent.com/a-/AOh14GilcFkcWORpZP_leep5734FQxTP_Eq5JbLcE8FM=s96-c",));
      },),);

  }
}


class DPCircle extends StatelessWidget
{
  String text;
  DPCircle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(height: 40, width: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.white10),
    child: Stack( children:
    [
      Align(alignment: Alignment.center,
          child: Text(text==null?" ":text,style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.lightBlue),)),

      Align(alignment: Alignment.bottomRight,child: Container(height: 12, width: 12, decoration: BoxDecoration(shape: BoxShape.circle,
          border: Border.all(color: Colors.black,width: 2),color: Colors.green),),)
    ],),);
  }
}

class CustomChatTile extends StatelessWidget
{
  String photoURL, name, subtitle, uid;
  bool status;
  CustomChatTile({this.name, this.photoURL, this.subtitle, this.status, this.uid});
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children:
    [
          Stack(children:
          [
            Align(alignment: Alignment.center, child: Container(height:50,child: ClipRRect(child: Image.network(photoURL),borderRadius: BorderRadius.circular(100),)),),
            //Align(alignment: Alignment(10, 100), child: Container(height: 12, width: 12, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2),color: status?Colors.green:Colors.red),),),
            Positioned(top: 37, left: 37,child: Container(height: 12, width: 12, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2),color: status?Colors.green:Colors.red),)),

          ],),
          Container(padding: EdgeInsets.only(left: 10),
            child: Column( crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(name,style: TextStyle(color: Colors.white,fontSize: 18),),
              Text(subtitle,style: TextStyle(color: Colors.white38),),

            ],),
          ),

    ],),
          Container(margin: EdgeInsets.fromLTRB(60, 5, 0, 0),height: 0.5,  color: Colors.white10,),
        ],
      ),);
  }
}


