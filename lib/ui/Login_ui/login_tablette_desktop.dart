import 'dart:async';
import 'dart:convert';
import 'package:compta_app/home_page.dart';
import 'package:compta_app/ui/list/list_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import '../../FadeAnimation.dart';
import 'inscription_mobile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert' as JSON;

import 'inscription_tablette_desktop.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);





var email_field = TextEditingController();
var password_field = TextEditingController();



class login_tablette_desktop extends StatefulWidget {
  @override
  _login_tablette_desktop createState() => _login_tablette_desktop();

}


bool loading = false;

class _login_tablette_desktop extends State<login_tablette_desktop> {

  @override
  void initState() {
    super.initState();

  }


  Widget build(BuildContext context) {
    return page_Content(context);
  }

}

Widget page_Content(BuildContext context){return Container(



  child: Scaffold(

    backgroundColor: Colors.transparent,

    resizeToAvoidBottomPadding: true,

    body: Container(

        color: Colors.transparent,


        child: new Stack(

          fit: StackFit.expand,

          children: <Widget>[



            Column(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,


              children: <Widget>[


                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset("assets/image_03.png",width: MediaQuery.of(context).size.width*0.45,),

                      ],

                    ),

                  ),
                ),




              ],
            ),

            SingleChildScrollView(


              child: Column(
                children: <Widget>[



                  /***********************************************/
                  Padding(padding: EdgeInsets.only(left: 20.0, right: 25.0, top: 0.0),
                    child: FadeAnimation(2,CardContent(context)),
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(2,SocialContent(context)),

                  SizedBox(
                    height: 20,
                  ),
                  /***********************************************/


                ],
              ),

            ),




          ],
        )

    ),

  ),
);}
Widget LOGOContent() {
  return Container(
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset("assets/compta_logo_white.png",width: 250,),
      ],

    ),
  );
}

Widget SocialContent(BuildContext context) {
  return Container(

    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [

        Container(
          width: 45.0,
          height: 45.0,
          margin: EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffe84c3d)),
          child: RawMaterialButton(

            shape: CircleBorder(),
            child: Icon(FontAwesomeIcons.google,size: 20,color: Colors.white) ,
            onPressed:() async {

              _handleSignIn_google(context);
              bool isSignedIn_google = await _googleSignIn.isSignedIn();
              print("isSignedIn_google________________"+isSignedIn_google.toString());
            },

          ),
        ),


      ],

    ),
  );
}


Widget ForgotContent() {
  return Container(

    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Forgot Password ?",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins-Medium",
            //    fontSize: ScreenUtil.getInstance().setSp(28)
          ),
        ),

      ],

    ),
  );
}




Widget CardContent(BuildContext context)

{
  final _formKey = GlobalKey<FormState>();
  return Column(

    children: <Widget>[

      Form(
          key: _formKey,
          child: Column(

              children: <Widget>[
                new Container(

                  width: 400,
                  margin: const EdgeInsets.only(top: 50),


                  child: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        LOGOContent(),

                        // Text("Login",style: TextStyle(fontFamily: "Poppins-Medium",fontSize: 30,fontWeight: FontWeight.w600),),
                        SizedBox(
                          height:30,
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 14),
                          controller: email_field,
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,

                          decoration: InputDecoration(
                              enabledBorder:UnderlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFe84c3d), width: 2.0),
                              ),
                              focusedBorder:UnderlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFe84c3d), width: 2.0),
                              ),
                              prefixIcon: Icon(FontAwesomeIcons.user,color: Color(0xFFe84c3d),size: 25,),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.black38, fontSize: 14.0,)),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          style: TextStyle(fontSize: 14),
                          controller: password_field,
                          validator: password_value,

                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder:UnderlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFe84c3d), width: 2.0),
                              ),
                              focusedBorder:UnderlineInputBorder(
                                borderSide: const BorderSide(color: Color(0xFFe84c3d), width: 2.0),
                              ),
                              prefixIcon: Icon(FontAwesomeIcons.key,color: Color(0xFFe84c3d),size: 23,),
                              hintText: "Mot de passe",
                              hintStyle: TextStyle(color: Colors.black38, fontSize: 14.0,)),

                        ),
                        SizedBox(
                          height: 20,
                        ),

                        ForgotContent(),

                        SizedBox(
                          height: 20,
                        ),
                         Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,

                            children: <Widget>[



                              Container(
                                height: 40,
                                margin: const EdgeInsets.only(bottom: 12.0),

                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      Color(0xFFe84c3d),
                                      Color(0xFFe84c3d)
                                    ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xFFe84c3d).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {
                                        if(_formKey.currentState.validate()){Login_methode(context);}
                                      },
                                      child: Center(

                                        child: Text("Se connecter",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins-Bold",
                                                fontSize: 16,
                                                letterSpacing: 1.0)),
                                      )
                                  ),
                                ),


                              ),


                            ],


                        ),


                      ],
                    ),
                  ),
                )
              ]
          )
      ),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[



          Container(
            width: 400,
            height: 40,
            margin: const EdgeInsets.only(bottom: 12.0),

            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xfff9a867),
                  Color(0xfff9a867)
                ]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff9a867).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => Inscription_tablette_desktop()),);

                  },
                  child: Center(

                    child: Text("S'inscrire",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins-Bold",
                            fontSize: 16,
                            letterSpacing: 1.0)),
                  )
              ),
            ),


          ),


        ],
      ),

    ],
  );

}

Widget horizontalLine() => Padding(
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  child: Container(
    width: 50,
    height: 1.5,
    color: Colors.white.withOpacity(.2),
  ),
);


/****************** Web Services ***********************/
bool exist;
Future Login_methode(BuildContext context) async {

}



String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Entrer un e-mail valide';
  else
    return null;
}

String password_value(String value) {

  if (value.isEmpty) {
    return 'Entrer une mot de passe valide';
  }

  else{
    return null;}

}



void _handleSignIn_google(BuildContext context) async {
  try {
    await _googleSignIn.signIn().then((value) => value != null ? {
      Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => home_page()),(Route<dynamic> route) => false,),print("correct : "+value.toString())} : print("wrong : "+value.toString()) );





  } catch (error) {
    print(error);
  }
}

Future<void> _handleSignOut_google() => _googleSignIn.disconnect();




