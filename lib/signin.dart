import 'home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_methods.dart';
import 'package:shimmer/shimmer.dart';

/*
class SignIn extends StatelessWidget
{
  Methods meth=new Methods();
  bool isLoading=false;
  authenticateUser(User user, BuildContext context) async
  {
    meth.authenticateUser(user).then((value)
    {
      if(value) meth.uploadData(user).then((value)
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => Home()));
      });
      else Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => Home()));
    });
  }
  initiateGoogleSignin(BuildContext context)
  {

    meth.signInWithGoogle().then((value)
    {
      print("Hey");
      if(value!=null) {

        isLoading=true;

        print(value.user.email);
        authenticateUser(value.user, context);

      }
      else print("NULL VALUE DETECTED.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: isLoading?CircularProgressIndicator():Container(child: FlatButton(child: Text("Login with Google"),onPressed: ()
    {
      initiateGoogleSignin(context);

    },),)),);
  }
}

*/

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
{
  Methods meth=new Methods();
  bool isLoading=false;
  authenticateUser(User user, BuildContext context) async
  {
    meth.authenticateUser(user).then((value)
    {
      if(value) meth.uploadData(user).then((value)
      {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext context) => Home()));
      });
      else Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => Home()));
    });
  }
  initiateGoogleSignin(BuildContext context)
  {

    meth.signInWithGoogle().then((value)
    {
      print("Hey");
      if(value!=null) {

        setState(()
        {
          isLoading=true;
        });


        print(value.user.email);
        authenticateUser(value.user, context);

      }
      else print("NULL VALUE DETECTED.");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white12,
      body: Center(child: isLoading?CircularProgressIndicator():Container(child: Shimmer.fromColors(baseColor: Colors.white, highlightColor: Colors.white12,
        child: TextButton(child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 40),),onPressed: ()
    {
        initiateGoogleSignin(context);

    },),
      ),)),);
  }
}

