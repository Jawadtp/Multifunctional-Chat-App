import 'package:clone_app/firebase_methods.dart';
import 'package:clone_app/pageview/chat.dart';
import 'package:clone_app/pageview/chat_conversation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clone_app/models/usermodel.dart';
class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
{

  Methods meth = new Methods();
  String query="";
  User currentUser;
  TextEditingController controller=TextEditingController();
  List<UserModel> searchResult;

  searchResultView()
  {
    List<UserModel> mylist = query.isEmpty?[]:searchResult.where((user)
    {
      String username=user.username.toLowerCase();
      String name=user.name.toLowerCase();
      String q = query.toLowerCase();
      bool uNameMatch=username.contains(q);
      bool nameMatch=name.contains(q);
      return (uNameMatch || nameMatch);
    } ).toList();

    return ListView.builder(scrollDirection: Axis.vertical, shrinkWrap: true,
        itemCount: mylist.length, itemBuilder: (context, index)
    {
      return InkWell(onTap: () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return ChatConversation(receiver: mylist[index],);}));},child: CustomChatTile(name: mylist[index].name, photoURL: mylist[index].profilePhoto, subtitle: "Hello there", status: true,));
    });
  }


  @override
  void initState()
  {
    super.initState();
    meth.getCurrentUser().then((value)
    {
      currentUser=value;
      meth.getAllUsers(value).then((val)
      {
        setState(()
        {
          searchResult=val;
        });

      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(backgroundColor: Colors.white10, appBar: AppBar(elevation: 0.0, backgroundColor: Colors.lightBlue,

      ),body: Column(
        children: [
          Container(height: 70, color: Colors.lightBlue, padding: EdgeInsets.only(left: 20),child:
          Row(
            children: [
              Expanded(
                child: TextField(controller: controller, onChanged: (val){setState(() {
                  query=val;
                });},decoration: InputDecoration(hintText: "Search",hintStyle: TextStyle(color: Colors.white70),border: InputBorder.none),style: TextStyle(fontSize: 30,color: Colors.white70),),
              ),
              IconButton(icon: Icon(Icons.close,color: Colors.white,),onPressed: (){controller.clear();},),
            ],
          ),),
          SizedBox(height: 20,),
          searchResultView()
        ],
      ));
  }
}

