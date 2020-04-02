import 'dart:async';

import 'package:compta_app/ui/details/details_page.dart';
import 'package:compta_app/ui/list/list.dart';
import 'package:compta_app/ui/menu/MenunavigationBloc.dart';
import 'package:compta_app/ui/menu/Menus_event.dart';
import 'package:compta_app/ui/nav_bar/navigation_bar.dart';
import 'package:compta_app/ui/navigation_drawer/drawer_item.dart';
import 'package:compta_app/ui/navigation_drawer/navigation_drawer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'ui/Login_ui/login_mobile.dart';

void main() async {
  // Set default home.
  WidgetsFlutterBinding.ensureInitialized();
  Widget _defaultHome = new home_page();
  runApp(new MaterialApp(
    home: _defaultHome,
  ));
}


class home_page extends StatefulWidget {
  @override
  home_pageState createState() => home_pageState();

}
final bloc_nav = MenuNavigationDrawerBloc();

class home_pageState extends State<home_page> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc_nav.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    return ResponsiveBuilder(
      builder: (context, sizingInformation) =>
          Scaffold(
            drawer: sizingInformation.deviceScreenType == DeviceScreenType.Mobile || sizingInformation.deviceScreenType == DeviceScreenType.Tablet
                ? NavigationDrawer() : null,
            backgroundColor: Colors.white,
            body:SafeArea(child:
            sizingInformation.deviceScreenType == DeviceScreenType.Mobile || sizingInformation.deviceScreenType == DeviceScreenType.Tablet
                ? StreamBuilder(
                stream: bloc_nav.nomPage,
                initialData: "home",
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.data=="home") {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //Flexible(flex: 1,child: NavigationBar(),),
                      Flexible(flex:7,child: ListPage(),),

                    ],
                  );}

                  if (snapshot.data=="home2") {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        //Flexible(flex: 1,child: NavigationBar(),),
                        Flexible(flex:7,child: details_page(),),

                      ],
                    );}


                })  :
            /************************** Desktop StreamBuilder **************************/
            StreamBuilder(
                stream: bloc_nav.nomPage,
                initialData: "home",
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  print("Snaaaaaaaaaaaap : "+snapshot.data);
                if (snapshot.data=="home") {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      Flexible(flex: 0,child: NavigationBar()),
                      Flexible(flex: 2,child: ListPage(),),
                      Expanded(flex: 5,child:details_page()),

                    ],
                  );}
                if  (snapshot.data=="home2")  {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(flex: 0,child: NavigationBar()),

                    ],
                  );}
                })
          ),));
  }

  ChangeTHEpage(String name){bloc_nav.MenuEventSink.add(ChangeMenu(name));}


}





