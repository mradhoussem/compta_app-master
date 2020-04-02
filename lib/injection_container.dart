import 'package:compta_app/ui/list/list_bloc.dart';
import 'package:kiwi/kiwi.dart';
import 'data/generator/list_data_source.dart';


void initKiwi() {
  Container().registerFactory((c) => ListDataSource());  // initialise th datasource
  Container().registerFactory((c) => ListBloc(c.resolve())); //c.resolve to get the datasource inside C witch is the container to pass it to listbloc
}