import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main()=>runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

  TextEditingController dispositivo = TextEditingController();
  TextEditingController evento = TextEditingController();

class _InicioState extends State<Inicio> {
  Future<String> sendData(String n, String e) async{
    DateTime fechahora = DateTime.now();
    String fechaformato = DateFormat('yyyy-MM-ddTHH:mm:ss').format(fechahora);
    String cadena = "{'NameDevice':'MatiasCell','EventDateTime':'2021-03-09T21:40:45','Event':'Prueba Flutter'}";
    var data = json.encode(cadena);
    var response = await http.post(
      Uri.encodeFull("https://apiproductormatias.azurewebsites.net/api/data"),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(<String, String>{
        "NameDevice":n,
        "EventDateTime":fechaformato,
        "Event":e})
      );
      print(response.body);
    return response.body;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Odometro Matias'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Eventos a CosmoDB:',
                style: TextStyle(fontSize: 30),
              ),
              Divider(
                height: 100,
                thickness: 0,
                color: Colors.white,
              ),

              TextField(
                controller: dispositivo,
                decoration: InputDecoration(
                  labelText: "Nombre Dispositivo",
                ),
                keyboardType: TextInputType.name,
              ),
               TextField(
                controller: evento,
                decoration: InputDecoration(
                  labelText: "Evento",
                ),
              ),

              new ElevatedButton(
                onPressed: (){
                  var lnombre = dispositivo.text;
                  var levento = evento.text;
                  sendData(lnombre, levento); 
                },
                child: new Text("Enviar datos")
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
