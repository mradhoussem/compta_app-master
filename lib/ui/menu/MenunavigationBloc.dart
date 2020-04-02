import 'dart:async';
import 'Menus_event.dart';

class MenuNavigationDrawerBloc {
  final MenunavigationStateController = StreamController<String>.broadcast();

  StreamSink<String> get _MenuNavigationSink => MenunavigationStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<String> get nomPage => MenunavigationStateController.stream;

  final _MenuEventController = StreamController<ChangeMenu>.broadcast();
  // For events, exposing only a sink which is an input
  Sink<ChangeMenu> get MenuEventSink => _MenuEventController.sink;

  MenuNavigationDrawerBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _MenuEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ChangeMenu event) {
    if (event is ChangeMenu)
      _MenuNavigationSink.add(event.data);
  }

  void dispose() {
    MenunavigationStateController.close();
    _MenuEventController.close();
  }
}