//@dart=2.9
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meetfit_project/Screens/SignUpScreen.dart';
import 'package:meetfit_project/Screens/profileScreen.dart';


class Root extends StatefulWidget {

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {

  Future<User> getCurrentUser()async{
    return await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: getCurrentUser(),
        builder: (context,AsyncSnapshot<User> snapshot){
          if(snapshot.hasData)
          {
            User user = snapshot.data;
            print(snapshot.data);
            return profile(user);
          }

          return SignUp();
        });
  }
}
