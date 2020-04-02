import 'package:compta_app/ui/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';

import 'navigation_bar.dart';

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu,size: 40,),
            onPressed: () {print("show navigation");Scaffold.of(context).openDrawer();},
          ),
        ],
      ),
    );
  }
}