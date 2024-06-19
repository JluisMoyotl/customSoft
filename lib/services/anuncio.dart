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
    required String message,
    required String user,
    required String auth,
    required String userId
  }
) async {
  try {
    final emailContent = '''
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
to: $email
subject: SE RECIBIO UN COMENTARIO DESDE EL SISTEMA DE ANUNCIOS EMPRESARIALES CON LA SIGUIENTE INFORMACiON DE CONTACTO

NOMBRE: $name\nCORREO CONTACTO: $email\nMENSAJE:\n$message.
''';

    var base64 = base64UrlEncode(utf8.encode(emailContent));
    var body = json.encode({'raw': base64});

    String url = 
      'https://www.googleapis.com/gmail/v1/users/'+userId +'/messages/send';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
              'Authorization': auth, 
              'X-Goog-AuthUser': user,
              'Content-Type': 'message/rfc822'
            },
      body: body
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