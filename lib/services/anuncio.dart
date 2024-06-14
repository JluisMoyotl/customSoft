import 'dart:convert';
import 'dart:io';

import 'package:custom_soft/models/answer.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<Answer> workListServices() async {
  String path =  "/custom/api/anuncios";
  try {
    Response response = await http.get(
      Uri.https("666ba7cd49dbc5d7145ac522.mockapi.io",path),
      headers: {
        "Content-Type": "application/json",
        }
    );
    return Answer.fromService(response, 200);
  } on SocketException catch(_){
    return Answer.fromWithoutConnection();
  } on Exception catch(error){
    return Answer(
      body: {},
      error: true,
      status: 0,
      message: error.toString()
    );
  }
}
Future<Answer> sendEmailServices(
  {
    required String email,
    required String name,
    required String message
  }
) async {
  String path =  "/v1/email";
  Map<String,dynamic> body = {
    "from": {
        "email": "hybridtechnologiestbc@gmail.com"
    },
    "to": [
        {
            "email": email
        }
    ],
    "subject": "SE RECIBIO UN COMENTARIO DESDE EL SISTEMA DE ANUNCIOS EMPRESARIALES CON LA SIGUIENTE INFORMACÓN DE CONTACTO",
    "text": "NOMBRE: $name\nCORREO CONTACTO: $email\nMENSAJE:\n$message",
  };
  try {
    Response response = await http.post(
      Uri.https("api.mailersend.com",path),
      headers: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest",
        "Authorization": "Bearer mlsn.aed582df03a1f7ff3bf53e9ce41a4f95cb9e2512c2e64c0f9d1133113352e011"
        },
        body: jsonEncode(body)
    );
    return Answer.fromService(response, 200);
  } on SocketException catch(_){
    return Answer.fromWithoutConnection();
  } on Exception catch(error){
    return Answer(
      body: {},
      error: true,
      status: 0,
      message: error.toString()
    );
  }
}