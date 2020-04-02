import 'package:compta_app/injection_container.dart';
import 'package:compta_app/shared_pref.dart';
import 'package:compta_app/ui/list/list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home_page.dart';
import 'ui/Login_ui/login_mobile.dart';
import 'ui/Login_ui/login_tablette_desktop.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

void main() async {
  // Set default home.
  WidgetsFlutterBinding.ensureInitialized();
  initKiwi();
  bool isSignedIn_google = await _googleSignIn.isSignedIn();
  print("_isLoggedIn_google : "+isSignedIn_google.toString());

  Widget _defaultHome;
  var facebook_connection_shared = await SharedPreferences_class().getFacebook_connection_shared_pref();
  print("facebook_connection_shared : " + facebook_connection_shared.toString());
  if (isSignedIn_google == true || facebook_connection_shared == "connected") {
    _defaultHome = new home_page();
  }
  else{
    _defaultHome = new MyApp();
  }


  runApp(new MaterialApp(
    home: _defaultHome,
  ));
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WidgetPage(),
    );
  }
}

class WidgetPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    if(width>600)
    return login_tablette_desktop();
    return login_mobile();

  }
}
