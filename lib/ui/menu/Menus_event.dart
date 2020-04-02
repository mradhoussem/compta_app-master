import 'package:compta_app/entities/facture_class.dart';

abstract class Menus_event {}

class ChangeMenu  extends Menus_event {
  final String data;
  ChangeMenu(this.data);

}
