// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meetfit_project/Screens/Login%20Screen.dart';

class SignUp extends StatefulWidget {
  //const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool obsecure_text = true; //for eye button
  String email = "";
  String pass = "";
  String cpass = "";
  String selectedImagePath;
  String url;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _cpassController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                        width: MediaQuery.of(context).size.width-30,
                        child: TextFormField(
                          validator: (value){
                            if(email=="")
                              return "Empty field";
                            else if(!EmailValidator.validate(email))
                              return "Invalid Email";
                            else
                              return null;
                          },
                          maxLines:  1,
                          obscureText: false,
                          controller: _emailController,
                          onChanged: (value){
                            setState(() {
                              email = value;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              email = value;
                            });
                          },
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.grey.shade500),
                          decoration: InputDecoration(
                            labelText: 'Email',
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
                      ),//Email
                      Container(
                        margin: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                        width: MediaQuery.of(context).size.width-30,
                        child: TextFormField(
                          maxLines:  1,
                          obscureText: obsecure_text,
                          controller: _passwordController,
                          validator: (value){
                            if(pass == "")
                              return "Empty field";
                            else if(pass.length<6)
                              return "Atleast 6 digit password required";
                            else if(pass.contains(' '))
                              return "Password with spaces not allowed";
                            else
                              return null;
                          },
                          onChanged: (value){
                            setState(() {
                              pass = value;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              pass = value;
                            });
                          },
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.grey.shade500),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  obsecure_text = !obsecure_text;
                                });
                              },
                              child: obsecure_text ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            ),
                            labelText: 'Password',
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
                      ), //pass
                      Container(
                        margin: EdgeInsets.only(left: 25,right: 25,top: 10,bottom: 10),
                        width: MediaQuery.of(context).size.width-30,
                        child: TextFormField(
                          validator: (value){
                            if(cpass == "")
                              return "Empty field";
                            else if(cpass.length<6)
                              return "Atleast 6 digit password required";
                            else if(cpass.contains(' '))
                              return "Password with spaces not allowed";
                            else
                              return null;
                          },
                          maxLines:  1,
                          obscureText: obsecure_text,
                          controller: _cpassController,
                          onChanged: (value){
                            setState(() {
                              cpass = value;
                            });
                          },
                          onSaved: (value){
                            setState(() {
                              cpass = value;
                            });
                          },
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.grey.shade500),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  obsecure_text = !obsecure_text;
                                });
                              },
                              child: obsecure_text ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            ),
                            labelText: 'Confirm Password',
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
                      ), //confirmpass
                      //button for saving
                      SizedBox(height: 20,width: 5,),
                      GestureDetector(
                        onTap: (){
                            if(_formKey.currentState.validate() && cpass == pass)
                              {
                                print("Yes");
                              }
                            else
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Invalid Fields')),
                                );
                              }
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade600,
                              width: 4,
                            ),
                          ),
                          child: Text(
                            "Signup",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade400),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-50,
                        margin: EdgeInsets.only(left: 25,right: 25,top: 20,bottom: 20),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already Have an account? ",style: TextStyle(color: Colors.grey.shade400,fontSize: 18),),
                              GestureDetector(
                                onTap: (){
                                  _emailController.clear();
                                  _passwordController.clear();
                                  _cpassController.clear();
                                  Navigator.pushReplacement(context, MaterialPageRoute<void>(
                                    builder: (BuildContext context) => Login(),
                                  ),);
                                },
                                child: Text("Login",style: TextStyle(color: Colors.grey.shade800,fontSize: 18,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
