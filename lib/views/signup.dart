import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/chatroom_screen.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/helper/authenticate.dart';


//import 'package:chat_app/widgets/widget.dart';
class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp(this.toggleView);


  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLaoding = false;

  AuthMethods authMethods= new AuthMethods();
  DatabaseMethods databaseMethods= new DatabaseMethods();

  final formkey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUp(){
    if(formkey.currentState.validate()){

      Map<String, String> userInfoMap = {
        'name' : userNameTextEditingController.text,
        'email' : emailTextEditingController.text,
      };

      setState(() {
        isLaoding= true;
      });

      authMethods.signUpwithEmailAndPassword(emailTextEditingController.text,
          passwordTextEditingController.text).then((val){
          //  print("${val.uid}");

        databaseMethods.uploadUserInfo(userInfoMap);
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => ChatRoom()
            ));
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLaoding? Container(
        child: Center(child: CircularProgressIndicator()),
      ) :
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height -50,
          alignment: Alignment.bottomCenter,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    validator: (val){
    return val.isEmpty || val.length<2 ? "Please provide a valid username" : null;
                    },
                    controller: userNameTextEditingController,
                    style:  simpleTextStyle(),
                    decoration: textFieldInputDecoration('username'),
                  ),
                  TextFormField(
                    validator: (val){
                      return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                      null : "Enter correct email";
                    },
                    controller: emailTextEditingController,
                    style:  simpleTextStyle(),
                    decoration: textFieldInputDecoration('email'),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (val){
                      return val.length>6 ?null : "Please provide a password with 6+ character";
                    },
                    controller: passwordTextEditingController,
                    decoration: textFieldInputDecoration('password'),
                    style:  simpleTextStyle(),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('Forgot Password?', style: simpleTextStyle(),),
                    ),),
                  SizedBox(height: 16,),
                  GestureDetector(
                    onTap: (){
                      signMeUp();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [const Color(0xff007EF4),
                                const Color(0xff2A75BC)]
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text('Sign Up', style:mediumTextStyle(),
                      ),),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Text('Sign up with Google', style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,),
                    ),),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account? " , style: mediumTextStyle(),),
                      GestureDetector(
                          onTap: (){
                            widget.toggleView();
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('SignIn now', style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ),);
  }
}




/*          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  children: <Widget>[
                     Column(
                      children: <Widget>[
                        TextFormField(
                          controller: userNameTextEditingController,
                          style:  simpleTextStyle(),
                          decoration: textFieldInputDecoration('username'),
                        ),
                        TextFormField(
                          controller: emailTextEditingController,
                          style:  simpleTextStyle(),
                          decoration: textFieldInputDecoration('email'),
                        ),
                        TextFormField(
                          controller: passwordTextEditingController,
                          decoration: textFieldInputDecoration('password'),
                          style:  simpleTextStyle(),
                        ),
                      ],
                        SizedBox(height: 8,),
                        Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text('Forgot Password?', style: simpleTextStyle(),),
                        ),),
                        SizedBox(height: 16,),
                        Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [const Color(0xff007EF4),
                                const Color(0xff2A75BC)]
                          ),
                          borderRadius: BorderRadius.circular(30)
                      ),
                        child: Text('Sign Up', style:mediumTextStyle(),
                      ),),
                        SizedBox(height: 16,),
                        Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                       decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)
                      ),
                          child: Text('Sign up with Google', style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,),
                      ),),
                       SizedBox(height: 16,),
                       Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        Text("Already have an account? " , style: mediumTextStyle(),),
                        Text('SignIn now', style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline),),
                      ],
                    ),
                       SizedBox(height: 50,),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}*/
