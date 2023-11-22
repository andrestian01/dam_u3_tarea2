import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u3_tarea2_19400657/services/asignatura.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;
final CollectionReference crAsignatura = db.collection('asignatura');


Future<List<Map<String, dynamic>>> getAsignatura() async {
  final List<Map<String, dynamic>> asignatura = [];

  final QuerySnapshot qAsig = await crAsignatura.get();

  await Future.forEach(qAsig.docs, (documento) async {
    final Map<String, dynamic> ids = {'aid': documento.id};
    final Map<String, dynamic> cont = documento.data() as Map<String, dynamic>;
    ids.addAll(cont);
    asignatura.add(ids);
  });

  return asignatura;
}

Future<int> insertarAsignacion(Asignatura a) async {
  try {
    await crAsignatura.add(a.toMap());
    return 1;
  } catch (e, stackTrace) {
    print("Error al insertar asignación: $e\n$stackTrace");
    return 0;
  }
}


Future<int> actualizarAsignacion(Asignatura a, String id) async {
  await crAsignatura.doc(id).set(a.toMap());
  return 1;
}

Future<void> eliminarAsignacion(String p) async {
  await crAsignatura.doc(p).delete();
}


Future<List<String>> getDocentes() async {
  final List<String> docentes = [];
  final QuerySnapshot query = await crAsignatura.get();
  query.docs.forEach((doc) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final String docente = data['docente'];

    // Verificar si el docente ya existe en la lista
    if (!docentes.contains(docente)) {
      docentes.add(docente);
    }
  });
  return docentes;
}
