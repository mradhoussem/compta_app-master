import 'package:compta_app/entities/facture_class.dart';

abstract class DetailsEvent {}

class ShowDetails  extends DetailsEvent {
  final facture_class data;
  ShowDetails(this.data);

}
