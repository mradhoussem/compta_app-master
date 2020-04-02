import 'dart:async';
import 'dart:convert';
import 'package:compta_app/home_page.dart';
import 'package:compta_app/shared_pref.dart';
import 'package:compta_app/ui/list/list_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
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


GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

Map userProfile_facebook;
final facebookLogin = FacebookLogin();
bool _isLoggedIn_facebook = false;


var email_field = TextEditingController();
var password_field = TextEditingController();







class login_mobile extends StatefulWidget {
  @override
  _login_mobile createState() => _login_mobile();

}


class _login_mobile extends State<login_mobile> {

  @override
  void initState() {
    super.initState();
  }

  bool loading = true;

  @override
  Widget build(BuildContext context){


    email_field.clear();
    password_field.clear();


    return Container(

     /* decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffffffff),Color(0xffffffff),Color(0xffffffff),Color(0xFFf2f2b9), ])

      ),
*/
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

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.asset("assets/image_02.png",width: 350,),

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
    );


  }




}

Widget LOGOContent() {
  return Container(
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Image.asset("assets/compta_logo_white.png",width: 150,),
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
              color: Color(0xff3b5998)),
          child: RawMaterialButton(

              shape: CircleBorder(),
              child: Icon(FontAwesomeIcons.facebookF,size: 20,color: Colors.white) ,
              onPressed : (){
                _loginWithFB(context);
              }
          ),
        ),
        Text("  Ou  ",style: TextStyle(color: Colors.black54),),
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
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 30),

                  child: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        LOGOContent(),

                        SizedBox(
                          height: 50,
                        ),


                        Padding(
                          padding: EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            children: <Widget>[
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
                            ],
                          ),
                        ),


                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(2, ForgotContent()),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(padding: EdgeInsets.only(left: 20,right: 20),
                          child: Column(
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

                        ),


                      ],
                    ),
                  ),
                )
              ]
          )
      ),
      Padding(padding: EdgeInsets.only(left: 20,right: 20),
        child: Container(
          height: 40,
          margin: const EdgeInsets.only(bottom: 12.0),

          decoration: BoxDecoration(
              color: Color(0xfff9a867),
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
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Inscription_mobile()),);
                },
                child: Center(

                  child: Text("Inscription",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Bold",
                          fontSize: 16,
                          letterSpacing: 1.0)),
                )
            ),
          ),


        ),),
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


_loginWithFB(BuildContext context) async{

  /*final facebookLogin = new FacebookLogin();
  facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;*/
  final result = await facebookLogin.logIn(['email']);


  switch (result.status) {
    case FacebookLoginStatus.loggedIn:
      final token = result.accessToken.token;
      final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
      final profile = JSON.jsonDecode(graphResponse.body);
      print(profile);
      userProfile_facebook = profile;
      _isLoggedIn_facebook = true;
      Navigator.push(context,MaterialPageRoute(builder: (context) => home_page()),);
      SharedPreferences_class().setFacebook_connection_shared_pref("connected");
      break;

    case FacebookLoginStatus.cancelledByUser:
      _login_mobile().setState(() => _isLoggedIn_facebook = false );
      break;
    case FacebookLoginStatus.error:
      print(result.errorMessage);
      _isLoggedIn_facebook = false;
      break;
  }

}

_logout(){
  facebookLogin.logOut();
  _isLoggedIn_facebook = false;

}

