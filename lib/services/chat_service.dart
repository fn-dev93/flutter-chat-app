import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/mensajes_response.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ChatService with ChangeNotifier{

    User usuarioPara;

    Future<List<Mensaje>> getChat( String usuarioId) async {

      final uri = Uri.parse('${ Enviroment.apiUrl}/mensajes/$usuarioId');
      final resp = await http.get( uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken()
      } );

      final mensajesResp = mensajesResponseFromJson( resp.body );

      return mensajesResp.mensajes;

    }

}
