import 'package:bloc/bloc.dart';
import 'package:compta_app/data/generator/list_data_source.dart';
import 'list_event.dart';
import 'list_state.dart';


class ListBloc extends Bloc<ListEvent, ListState> {
  ListDataSource _dataSource;

  ListBloc(this._dataSource);
 // ListBloc(this._dataSource);

  void getNextListPage_bloc() {
    dispatch(FetchNextPage());
  }

  void getRefreshListPage_bloc() {
    dispatch(RefreshPage());
  }



  @override
  ListState get initialState => ListState.initial();

  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    if (event is FetchNextPage) {
      try {

        final nextPageItems = await _dataSource.getNextListPage();
        print("nextPageItems : "+nextPageItems.toString());
        if(nextPageItems.length<15){
        yield ListState.success(currentState.listItems + nextPageItems);
        yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);}
        else{yield ListState.success(currentState.listItems + nextPageItems);}
      } on NoNextPageException catch (_) {
        yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);
      }
    }

    else if(event is RefreshPage)
      {
        final PageItems = await _dataSource.getListPageRefreshed();
        print("PageItems : "+PageItems.toString());
        yield ListState.success(PageItems);
            }


  }
}