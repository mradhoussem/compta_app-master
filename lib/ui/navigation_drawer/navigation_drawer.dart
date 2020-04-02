import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../home_page.dart' as home_page;
import '../../main.dart';
import '../../shared_pref.dart';
import 'drawer_item.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);
final facebookLogin = FacebookLogin();

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      SafeArea(child:
      Container(

      padding: const EdgeInsets.only(top:10,right: 10,left: 10),

      decoration: BoxDecoration(
          color: Color(0xff262626),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)]),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[


            Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,children: <Widget>[

              GestureDetector(onTap:(){home_page.home_pageState().ChangeTHEpage("home");},
                  child:DrawerItem('Factures', FontAwesomeIcons.fileAlt) ),


              GestureDetector(onTap:(){home_page.home_pageState().ChangeTHEpage("home2");},
                  child: DrawerItem('About', Icons.help) ),


            ],),

        GestureDetector(onTap:() async {
          await _googleSignIn.signOut();
          await facebookLogin.logOut();
          await SharedPreferences_class().setFacebook_connection_shared_pref("not connected");
          Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp()),);

        },child:DrawerItem('Déconnexion', FontAwesomeIcons.signOutAlt),),




          ],
        ),
    ));
  }
}