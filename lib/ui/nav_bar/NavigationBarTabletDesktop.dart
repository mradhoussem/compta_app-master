import 'package:compta_app/main.dart';
import 'package:compta_app/ui/navigation_drawer/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../home_page.dart' as home_page;
import '../../shared_pref.dart';
import '../../ui/list/list_page.dart' as list_page;

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class NavigationBarTabletDesktop extends StatefulWidget {
  @override
  NavigationBarTabletDesktop_State createState() => NavigationBarTabletDesktop_State();
}

class NavigationBarTabletDesktop_State extends State<NavigationBarTabletDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:5,right: 2,left: 2),
      color: Color(0xff262626),
      height: MediaQuery.of(context).size.height,
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
            Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MyApp()),(Route<dynamic> route) => false,);

          },
              child: DrawerItem('Déconnexion', FontAwesomeIcons.signOutAlt) ),




        ],
      ),
    );
  }
}
