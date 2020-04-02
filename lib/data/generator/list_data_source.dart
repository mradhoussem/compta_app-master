import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:built_collection/built_collection.dart';
import 'package:compta_app/data/model/list_item.dart';
import 'package:compta_app/entities/facture_class.dart';
import '../../ui/details/details_page.dart' as details_page;

class ListDataSource {
  static const int ITEMS_PER_PAGE = 15;
  static final _randomGenerator = Random();
  int _shownPagesCount = 0;
  List<String> list_des_factures = new List();


  /*Future<BuiltList<ListItem>> getNextListPage() async {
    await Future.delayed(Duration(milliseconds: 750));

    /********************************************************************************************/
    list_des_factures.clear();
    print("ccccccccccc");
    final response = await http.get("http://192.168.1.7/Tizenwebservices/profile.php?action=login&numberofrows="+_shownPagesCount.toString());
    print("dddddddddddd");

      var results = json.decode(response.body);
      results.forEach((list) {
        print("eeeeeeeeeeeeeee");
        (list as Map<String, dynamic>).forEach((key, value) {
          print("ffffffffffffffff");
          if(key=="firstname")list_des_factures.add(value);
        });
      });
    print("ggggggggggggggggg");
    details_page.details_pageState().showDetail_click(new facture_class(1, list_des_factures[0], list_des_factures[0]));

    /********************************************************************************************/


    _shownPagesCount=_shownPagesCount+15;

    print("list_des_factures length :" + list_des_factures.length.toString());

    if (list_des_factures.length==0) {
      //throw NoNextPageException();
    }

    if(list_des_factures.length<15){return BuiltList.of(
      List.generate(list_des_factures.length, _generateListItem),
    );}

    else{return BuiltList.of(
      List.generate(ITEMS_PER_PAGE, _generateListItem),
    );}

  }*/

  Future<BuiltList<ListItem>> getNextListPage() async {
    await Future.delayed(Duration(milliseconds: 500));
    /********************************************************************************************/
    list_des_factures.clear();
    //_shownPagesCount=0;
    final response = await http.get("http://192.168.1.5/Tizenwebservices/profile.php?action=login&numberofrows="+_shownPagesCount.toString());
    var results = json.decode(response.body);
    results.forEach((list) {
      (list as Map<String, dynamic>).forEach((key, value) {
        if(key=="firstname")list_des_factures.add(value);
      });
    });

    /********************************************************************************************/


    _shownPagesCount=_shownPagesCount+15;

    print("list_des_factures length refresh:" + list_des_factures.length.toString());

    if (list_des_factures.length==0) {
      //throw NoNextPageException();
    }

    if(list_des_factures.length<15){return BuiltList.of(
      List.generate(list_des_factures.length, _generateListItem),
    );}

    else{return BuiltList.of(
      List.generate(ITEMS_PER_PAGE, _generateListItem),
    );}

  }

  Future<BuiltList<ListItem>> getListPageRefreshed() async {

    /********************************************************************************************/
    list_des_factures.clear();
    _shownPagesCount=0;
    final response = await http.get("http://192.168.1.5/Tizenwebservices/profile.php?action=login&numberofrows="+_shownPagesCount.toString());
    var results = json.decode(response.body);
    results.forEach((list) {
      (list as Map<String, dynamic>).forEach((key, value) {
        if(key=="firstname")list_des_factures.add(value);
      });
    });
    details_page.details_pageState().showDetail_click(new facture_class(1, list_des_factures[0], list_des_factures[0]));

    /********************************************************************************************/


    _shownPagesCount=_shownPagesCount+15;

    print("list_des_factures length refresh:" + list_des_factures.length.toString());

    if (list_des_factures.length==0) {
      //throw NoNextPageException();
    }

    if(list_des_factures.length<15){return BuiltList.of(
      List.generate(list_des_factures.length, _generateListItem),
    );}

    else{return BuiltList.of(
      List.generate(ITEMS_PER_PAGE, _generateListItem),
    );}

  }

  ListItem _generateListItem(int index) {

    return ListItem((b) => b
      ..title = list_des_factures[index]
      ..colorInt = _randomGenerator.nextInt(0xFFFFFFFF));
  }
}

class NoNextPageException implements Exception {}