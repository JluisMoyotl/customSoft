import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Answer {
  dynamic body;
  String message;
  int status;
  bool connection;
  bool error;

  Answer(
    {
      required this.body,
      required this.message,
      required this.status,
      this.connection = true,
      required this.error,
    }
  );
  factory Answer.fromService(
    http.Response response, int statusSuccess,{String? message}
  ) {
    log("Request code ==> ${response.statusCode}");
    try {
      dynamic body = jsonDecode(response.body);
      if (response.statusCode == statusSuccess) {
        log("--> Respuesta exitosa");
        return Answer(
          body: body,
          message: message ?? "Respuesta exitosa",
          status: response.statusCode,
          error: false
        );
      }if (response.statusCode == 403 || response.statusCode == 401) {
        return Answer(
          body: {},
          message: body['message'] ?? "Las credenciales expiraron",
          status: response.statusCode,
          error: true
        );
      }else{
        log("--> Respuesta fallida $body");
        return Answer(
          body: body,
          message: body["message"] ?? "Información incorrecta",
          status: response.statusCode,
          error: true
        );
      }
      
    } catch (e) {
      return Answer(
          body: {"error": e},
          message: "Error inesperado::$e",
          status: 1001,
          error: true);
    }
  }
  factory Answer.fromWithoutConnection(){
    return Answer(
      body: {},
      message: '¡¡Upss, revisa tu conexión por favor', 
      status: 1002, 
      error: true,
      connection: false
    );
  }
}
