import 'package:compta_app/data/model/list_item.dart';
import 'package:compta_app/entities/facture_class.dart';
import 'package:compta_app/home_page.dart';
import 'package:compta_app/ui/details/details_bloc.dart';
import 'package:compta_app/ui/details/details_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../details/details_page.dart' as details_page;
import 'list_bloc.dart';
import 'list_state.dart';

class ListPage extends StatefulWidget {
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  final listBloc = kiwi.Container().resolve<ListBloc>();
  final _scrollController = ScrollController();
  GlobalKey<RefreshIndicatorState> refreshkey ;
  @override
  void initState() {
    super.initState();
    listBloc.getRefreshListPage_bloc();
    refreshkey = new GlobalKey<RefreshIndicatorState>();
  }

  @override
  void dispose() {
    super.dispose();
    listBloc.dispose();
  }

  Future<Null> refreshlist() async{
    await Future.delayed(Duration(microseconds: 500));
    listBloc.getRefreshListPage_bloc();
    return null;
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child:BlocBuilder(
        bloc: listBloc,
        builder: (context, ListState state) {
          if (state.listItems.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            return NotificationListener<ScrollNotification>(
              onNotification: _handleScrollNotification,
              child:
              RefreshIndicator(
                key:refreshkey ,
                onRefresh: () async {refreshlist();},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[

                    Padding(padding: EdgeInsets.only(top: 5,left: 10,right: 5),
                    child: Text("Fichiers",style: TextStyle(fontFamily: "Baloo2-ExtraBold",letterSpacing: 0.5,color: Colors.black87,fontSize: 40),),),

                    Padding(padding: EdgeInsets.only(top: 5,left: 5,right: 10,bottom: 10),
                      child:
                      TextField(
                          style: TextStyle(fontSize: 18.0),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              prefixIcon: Icon(FontAwesomeIcons.search),
                              hintText: "Rechercher...",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12, width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0)
                              ),

                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12, width: 32.0),
                                  borderRadius: BorderRadius.circular(25.0)))
                    ),)
                    ,


                  new Expanded(child:  ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black26,
                      );
                    },
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: calculateListItemCount(state),
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      return index >= state.listItems.length
                          ? _buildLoaderListItem()
                          : _buildDataListItem(state.listItems[index]);
                    },
                  ), ),

                ],

              ),),


              /**/
            );
          }
        },
      )

    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      listBloc.getNextListPage_bloc();
    }

    return false;
  }

  int calculateListItemCount(ListState state) {
    if (state.hasReachedEndOfResults) {
      return state.listItems.length;
    } else {
      // + 1 for the loading indicator
      return state.listItems.length + 1;
    }
  }

  Widget _buildLoaderListItem() {
    return Center(
      child:Container(padding: EdgeInsets.all(10),child: CircularProgressIndicator(),)

    );
  }

  Widget _buildDataListItem(ListItem item) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) =>
            Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(flex: 1,child:Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                          item.title,
                          style: TextStyle(
                            color: Color(0xff3f4a4c),
                            fontFamily: "Baloo2-ExtraBold",
                            fontSize: 25,
                            letterSpacing: .6,)
                      ),

                      Text(
                          "20-20-20",
                          style: TextStyle(
                            color: Color(0xffe84c3d),
                            fontFamily: "Baloo2-ExtraBold",
                            fontSize: 13,
                            letterSpacing: .6,)
                      ),


                      Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                          style: TextStyle(
                            color: Color(0xff3f4a4c),
                            fontFamily: "Baloo2-Regular",
                            fontSize: 18,
                            letterSpacing: .6,)
                      ),


                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[

                            Text(
                                "200.DT",
                                style: TextStyle(
                                  color: Color(0xff3f4a4c),
                                  fontFamily: "Baloo2-ExtraBold",
                                  fontSize: 18,
                                  letterSpacing: .6,)
                            ),

                            verticalLine(20),

                            GestureDetector(
                                onTap:(){},
                                child:Text(
                                    "EDITER",
                                    style: TextStyle(
                                      color: Color(0xffe84c3d),
                                      fontFamily: "Baloo2-ExtraBold",
                                      fontSize: 16,
                                      letterSpacing: .6,)
                                ),),




                          ]),


                    ]),),


                Flexible(flex: 0,child:
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      verticalLine(50),

                      GestureDetector(
                          onTap:(){

                            if(sizingInformation.deviceScreenType == DeviceScreenType.Mobile || sizingInformation.deviceScreenType == DeviceScreenType.Tablet){
                              Navigator.push(context,MaterialPageRoute(builder: (context) => details_page.details_page()),);
                            }
                            else{
                              details_page.details_pageState().showDetail_click(new facture_class(1, item.title, item.title));}

                          },child:Icon(Icons.remove_red_eye,size: 30,color: Color(0xff3f4a4c))),



                    ]),
                ),




            ]
          ),),

     ),);
  }

  Widget verticalLine(double height_size) => Padding(
    padding: EdgeInsets.only(left:15,right: 15.0),
    child: Container(
      width: 1.5,
      height: height_size,
      color: Colors.black12,
    ),
  );
}

