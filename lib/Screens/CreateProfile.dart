//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
class CreateProfile extends StatefulWidget {
  final String email;
  final String pass;

  CreateProfile(this.email,this.pass);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  String _email  = "",_pass = "",_name="",_about="",_imgurl = "";
  TextEditingController _nameController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();




  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _email = widget.email;
    _pass = widget.pass;
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
                      print("YES");
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
                        String path = "",fname="";
                        path = res.files.single.path;
                        _imgurl = path;
                        fname = res.files.single.name;
                        print(fname + " " + path);
                      }
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: _imgurl=="" ? AssetImage("assets/images/profile.png") : AssetImage(_imgurl),
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
                          onTap: (){
                            if(_formKey.currentState.validate())
                              {

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
