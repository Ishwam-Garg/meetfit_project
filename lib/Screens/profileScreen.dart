// @dart=2.9
import 'package:meetfit_project/Screens/Model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class profile extends StatefulWidget {
  final User user;

  profile(this.user);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  User user;
  String img="";
  Future<String> getImgurl(Profile profile)async{
    final ref = FirebaseStorage.instance.ref('images/${profile.email}');
    final p = await ref.getDownloadURL();
    setState(() {
      img = p;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user=widget.user;
    return WillPopScope(
      onWillPop: ()async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot return')),
        );
        return await false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              elevation: 10.0,
              child: Container(
                padding: EdgeInsets.only(top: 50,bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text("MeetMeFit",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.deepOrange),)),
              ),
            ),
            SizedBox(height: 20,width: 10,),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("data").get().asStream(),
                builder: (context,snapshot) {
                  if(snapshot.hasData)
                    {
                      DocumentSnapshot data = snapshot.data.docs[0];
                      Profile profile = Profile.fromJson(data.data());
                      return Container(
                        height: MediaQuery.of(context).size.height*0.7,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StreamBuilder(
                                stream: FirebaseStorage.instance.ref('images/${profile.email}/${profile.fname}').getDownloadURL().asStream(),
                                builder: (context,snapshot){
                                  if(snapshot.hasData)
                                    {
                                      String url = snapshot.data;
                                      return CircleAvatar(
                                        radius: 70,
                                        backgroundImage: url==null ? AssetImage("assets/images/profile.png") : NetworkImage(url),
                                        //backgroundColor: ,
                                      );
                                    }
                                  else
                                    return CircleAvatar(
                                    radius: 70,
                                    backgroundImage: AssetImage("assets/images/profile.png"),
                                    //backgroundColor: ,
                                  );

                                }),
                            SizedBox(height: 20,width: 10,),
                            Text(profile.name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                            SizedBox(height: 20,width: 10,),
                            Container(
                              margin: EdgeInsets.only(left: 20,right: 20),
                              padding: EdgeInsets.all(15),
                              width: MediaQuery.of(context).size.width-40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade600,width: 2),
                              ),
                              child: Text(profile.about,maxLines: 6,),
                            ),
                          ],
                        ),
                      );
                    }
                  else
                    return Center(child: CircularProgressIndicator(),);
                }),
          ],
        ),
      ),
    );
  }
}
