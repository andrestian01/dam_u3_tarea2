import 'package:dam_u3_tarea2_19400657/services/asignatura.dart';
import 'package:dam_u3_tarea2_19400657/services/firebase_service.dart';
import 'package:flutter/material.dart';

class CapturarAsig extends StatefulWidget {
  const CapturarAsig({Key? key}) : super(key: key);

  @override
  State<CapturarAsig> createState() => _CapturarAsigState();
}

final docenteC = TextEditingController();
final salonC = TextEditingController();
final creditoC = TextEditingController();
final materiaC = TextEditingController();


String? selectedE;
String? selectedM;

class _CapturarAsigState extends State<CapturarAsig> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insertar Asignación"),
        centerTitle: true,
        backgroundColor: Color(0xFF06AB78),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: materiaC,
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.book),
              labelText: "MATERIA",
            ),
          ),
          TextField(
              controller: docenteC,
              autofocus: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: "DOCENTE")),
          TextField(
              controller: creditoC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.timelapse),
                  labelText: "CREDITOS",
                  hintText: "##")),
          SizedBox(height: 10,),
          TextField(
              controller: salonC,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.business_outlined),
                  labelText: "SALON")),
          SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Color.fromARGB(255, 109, 204, 160), // Color de fondo del botón
              ),
              onPressed: () async {
                if (materiaC.text.isEmpty ||
                    docenteC.text.isEmpty ||
                    creditoC.text.isEmpty ||
                    salonC.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Por favor, llene todos los campos.")));
                } else {
                  Asignatura as = Asignatura(
                      materia: materiaC.text,
                      docente: docenteC.text,
                      credito: double.parse(creditoC.text),
                      salon: salonC.text,);

                  await insertarAsignacion(as).then((value) {
                    if (value > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("INSERTADO CON EXITO!")));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("ERROR al insertar la asignacion")));
                    }
                  });
                }
                salonC.text = "";
                creditoC.text = "";
                docenteC.text = "";
                materiaC.text = "";
              },
              child: Text("INSERTAR"))
        ],
      ),
    );
  }
}
