class facture_class {

  int id;
  String nom;
  String date;


  facture_class(this.id, this.nom, this.date);


  @override
  String toString() {
    return 'facture_class{id: $id, nom: $nom, date: $date}';
  }



}