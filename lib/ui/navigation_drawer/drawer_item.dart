import 'package:flutter/material.dart';


class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top:10,right: 10,left: 10,bottom: 10),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisSize: MainAxisSize.max,
         children: <Widget>[
           Column(children: <Widget>[
             Icon(icon,color: Colors.white,size: 25,),
             SizedBox(height: 5),
             Text( title, style: TextStyle(fontSize: 11,color: Colors.white),),

           ],),
           //SizedBox(height: 10),
           //horizontalLine(),

        ],
      ),
    );
  }
}
Widget horizontalLine() => Padding(
  padding: EdgeInsets.only(left: 10 , right: 10),
  child: Container(
    width: double.infinity,
    height: 2,
    decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(6.0),
       ),
  ),
);