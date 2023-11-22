class Asignatura {
  String? aid;
  String docente;
  double credito;
  String materia;
  String salon;


  Asignatura(
      {this.aid,
      required this.docente,
      required this.credito,
      required this.materia,
      required this.salon,});

  Map<String, dynamic> toMap() {
    return {
      'docente': docente,
      'credito': credito,
      'materia': materia,
      'salon': salon
    };
  }
}
