import 'package:compta_app/entities/facture_class.dart';
import 'package:flutter/material.dart';

import 'details_bloc.dart';
import 'details_event.dart';


class details_page extends StatefulWidget {
  @override
  details_pageState createState() => details_pageState();
}
final blocdetails = FactureBloc();

class details_pageState extends State<details_page> {

  @override
  void dispose() {
    super.dispose();
    //blocdetails.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0XFFf8f8f1),
      child: Column(children: <Widget>[
        StreamBuilder(
          stream: blocdetails.facture,
          builder: (BuildContext context, AsyncSnapshot<facture_class> snapshot) {
            if(!snapshot.hasData){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Empty',
                  ),
                ],
              );}
            else{
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${snapshot.data.nom}',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ],
              );}
          },
        ),

      ],
      ),
    );
  }
  showDetail_click(facture_class f){blocdetails.factureEventSink.add(ShowDetails(f));}
}
