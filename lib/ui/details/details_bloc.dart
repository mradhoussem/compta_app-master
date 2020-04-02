import 'dart:async';

import 'package:compta_app/entities/facture_class.dart';

import 'details_event.dart';


class FactureBloc {

  final _factureStateController = StreamController<facture_class>.broadcast();
  StreamSink<facture_class> get _infacture => _factureStateController.sink;
  // For state, exposing only a stream which outputs data
  Stream<facture_class> get facture => _factureStateController.stream;

  final _factureEventController = StreamController<ShowDetails>.broadcast();
  // For events, exposing only a sink which is an input
  Sink<ShowDetails> get factureEventSink => _factureEventController.sink;

  FactureBloc() {
    // Whenever there is a new event, we want to map it to a new state
    _factureEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(ShowDetails event) {
    if (event is ShowDetails)
    _infacture.add(event.data);
  }

  void dispose() {
    _factureStateController.close();
    _factureEventController.close();
  }
}