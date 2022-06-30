//@dart=2.9
import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meetfit_project/Screens/profileScreen.dart';

class CreateProfile extends StatefulWidget {
  final String email;
  final String pass;

  CreateProfile(this.email,this.pass);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  String _email  = "",_pass = "",_name="",_about="",_imgurl = "",_fname = "",_loc="";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();

  Future <User>signUp(String email,String pass) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      return FirebaseAuth.instance.currentUser;
    }catch(e){
        print(e);
    }
  }

  Future<String> upload(String path,String fname,String email) async{
    try{
      final ref = FirebaseStorage.instance.ref('images/${email}/${fname}');
      await ref.putFile(File(path)).then((p){
        return p.ref.getDownloadURL();
      });
    }
    on firebase_core.FirebaseException catch(e){
      print(e);
    }
  }


  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _email = widget.email;
    _pass = widget.pass;
    //print(_email);print(_pass);
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cannot return')),
        );
        return await false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  SizedBox(height: 20,width: 20,),
                  GestureDetector(
                    onTap: ()async{
                      //print("YES");
                      final FilePickerResult res = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png','jpg','jpeg'],
                      );

                      if(res == null) //not picked
                          {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file selected")));
                      }
                      else
                      {
                        String path = "";
                        path = res.files.single.path;
                        _imgurl = path;
                        _fname = res.files.single.name;
                        //print(_fname);
                        //print(path);
                        setState(() {
                        });
                      }
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: _imgurl=="" ? AssetImage("assets/images/profile.png") : FileImage(File(_imgurl)),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: Colors.white,
                          child: Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.red,
                              child: Center(
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,width: 20,),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //NAME
                        Container(
                          margin: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          width: MediaQuery.of(context).size.width-30,
                          child: TextFormField(
                            validator: (value){
                              if(_name=="")
                                return "Empty field";
                              else if(_name.contains(new RegExp(r'[0-9]')))
                                return "Name cannot have numbers";
                              else
                                return null;
                            },
                            maxLines:  1,
                            obscureText: false,
                            controller: _nameController,
                            onChanged: (value){
                              setState(() {
                                _name = value;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                _name = value;
                              });
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.grey.shade500),
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold,fontSize: 18),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                          width: MediaQuery.of(context).size.width-30,
                          child: TextFormField(
                            validator: (value){
                              if(_about=="")
                                return "Empty field";
                              else
                                return null;
                            },
                            maxLines:  5,
                            obscureText: false,
                            controller: _aboutController,
                            onChanged: (value){
                              setState(() {
                                _about = value;
                              });
                            },
                            onSaved: (value){
                              setState(() {
                                _about = value;
                              });
                            },
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.grey.shade500),
                            decoration: InputDecoration(
                              hintText: "About...",
                              hintStyle: TextStyle(fontSize: 18,color: Colors.grey.shade500,fontWeight: FontWeight.bold),
                              //labelText: 'Email',
                              //labelStyle: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold,fontSize: 18),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,width: 20,),
                        GestureDetector(
                          onTap: ()async{
                            if(_formKey.currentState.validate() && _imgurl!="")
                              {
                                //print("yes");
                                signUp(_email,_pass).then((user){
                                  upload(_imgurl, _fname, _email);
                                  Map<String,dynamic> data ={
                                    'uid': user==null ? '' : user.uid,
                                    'email': _email,
                                    'about': _about,
                                    'name': _name,
                                  };
                                  FirebaseFirestore.instance.collection("Users").doc(user.uid).collection("data").add(data).whenComplete(() {
                                    print("Complete");
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (BuildContext context)=>profile(user)));
                                  });
                                });
                              }
                            else
                              {

                              }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            width: MediaQuery.of(context).size.width*0.5,
                            padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                            child: Center(
                              child: Text('Create profile',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.grey.shade500),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
