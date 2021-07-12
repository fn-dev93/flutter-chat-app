import 'package:http/http.dart' as http;

import 'package:chat_app/models/user.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:chat_app/services/auth_service.dart';

import 'package:chat_app/global/enviroment.dart';



class UsuarioService {
  Future<List<User>> getUsuarios() async {
    try {

      // final token = await AuthService.getToken();

      final uri = Uri.parse('${Enviroment.apiUrl}/usuarios');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': await AuthService.getToken(),
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      
      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }
  }
}
