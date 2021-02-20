import 'home.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_methods.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAuth _auth;
  Methods meth = new Methods();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Chat Clone", debugShowCheckedModeBanner: false,
     home: FutureBuilder(future: meth.getCurrentUser(), builder: (context, AsyncSnapshot<User> snapshot)
     {
       if(snapshot.hasData)
       {
         var x = snapshot.data.email;
         print("Data present is: $x");
        return Home();
      }
       else return SignIn();
     }
     )
    );
  }
}

