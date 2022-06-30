// @dart=2.9
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:meetfit_project/Screens/SignUpScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meetfit_project/Screens/profileScreen.dart';
class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  bool obsecure_text = true; //for eye button
  String email = "";
  String pass = "";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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
                  //button for saving
                  SizedBox(height: 20,width: 5,),
                  GestureDetector(
                    onTap: (){
                      if(_formKey.currentState.validate())
                      {
                          try{
                            FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
                            User user = FirebaseAuth.instance.currentUser;
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (BuildContext context)=>profile(user)));
                          }
                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error occurred')),
                            );
                          }
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
                        "Login",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey.shade400),
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
                          Text("Don't have an account? ",style: TextStyle(color: Colors.grey.shade400,fontSize: 18),),
                          GestureDetector(
                            onTap: (){
                              _emailController.clear();
                              _passwordController.clear();
                              Navigator.pushReplacement(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) => SignUp(),
                              ),);
                            },
                            child: Text("SignUp",style: TextStyle(color: Colors.grey.shade800,fontSize: 18,fontWeight: FontWeight.bold),),
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
