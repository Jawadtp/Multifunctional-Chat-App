import 'package:firebase_auth/firebase_auth.dart';
import 'package:clone_app/utils/utils.dart';
class UserModel
{
  String uid, name, email, username, status, profilePhoto;
  int state;

  UserModel({this.email,this.uid,this.username,this.name,this.profilePhoto,this.state,this.status});
  Utils utils=new Utils();
  Map convertToMap(UserModel user)
  {
    this.username=utils.getDisplayName(this.email);
    var m = Map<String, dynamic>();
    m['uid']=this.uid;
    m['name']=this.name;
    m['email']=this.email;
    m['username']=this.username;
    m['profile_photo']=this.profilePhoto;
    m['status']=this.status;
    m['state']=this.state;
    return m;
  }

  UserModel.fromMap(Map<String, dynamic> map)
  {
    this.email=map['email'];
    this.name=map['name'];
    this.username=map['username'];
    this.uid=map['uid'];
    this.profilePhoto=map['profile_photo'];
  }
}