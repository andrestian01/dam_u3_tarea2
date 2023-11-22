import 'package:dam_u3_tarea2_19400657/services/asignatura.dart';
import 'package:dam_u3_tarea2_19400657/capturar/capturarAsignatura.dart';
import 'package:dam_u3_tarea2_19400657/services/firebase_service.dart';
import 'package:flutter/material.dart';


class ActualizarAsig extends StatefulWidget {
  final Asignatura as;
  const ActualizarAsig({Key? key, required this.as}) : super(key: key);

  @override
  State<ActualizarAsig> createState() => _ActualizarAsigState();
}

class _ActualizarAsigState extends State<ActualizarAsig> {
  @override
  ActualizarAsig get widget => super.widget;

  @override
  void initState() {
    super.initState();
    act();
  }

  void act() {
    idC.text = super.widget.as.aid!;
    docenteC.text = super.widget.as.docente;
    salonC.text = super.widget.as.salon;
    creditoC.text = super.widget.as.credito.toString();
    selectedM = super.widget.as.materia;
  }


  String? selectedE;

  TextEditingController idC = TextEditingController();
  TextEditingController docenteC = TextEditingController();
  TextEditingController salonC = TextEditingController();
  TextEditingController creditoC = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar Asignación"),
        centerTitle: true,
        backgroundColor: Color(0xFF6DCCA0),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          TextField(
            controller: docenteC,
            autofocus: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_3_rounded),
              labelText: "DOCENTE",
            ),
          ),
          TextField(
            controller: creditoC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.timelapse),
              labelText: "CREDITOS",
              hintText: "##",
            ),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: salonC,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.home_work_outlined),
              labelText: "SALON",
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF1AD7A4),
            ),
            onPressed: () async {
              if (docenteC.text.isEmpty ||
                  creditoC.text.isEmpty ||
                  salonC.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Por favor, llene todos los campos.")),
                );
              } else {
                Asignatura as = Asignatura(
                  materia: materiaC.text, // Utiliza el valor del TextField
                  docente: docenteC.text,
                  credito: double.parse(creditoC.text),
                  salon: salonC.text,
                );

                await actualizarAsignacion(as, idC.text).then((value) {
                  if (value > 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("ACTUALIZADO CORRECTAMENTE!")),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("ERROR al actualizar la asignacion")),
                    );
                  }
                });
              }
            },
            child: Text("ACTUALIZAR"),
          ),
        ],
      ),
    );
  }
}
