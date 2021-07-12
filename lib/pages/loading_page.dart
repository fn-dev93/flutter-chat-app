import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/usuarios_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(
      future: checkLoginState(context),
      builder: (BuildContext context, snapshot) {
        return Center(child: Text('Autenticando...'));
      },
    ));
  }

  Future checkLoginState(BuildContext context) async {
    final authservice = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);

    final autenticado = await authservice.isLoggedIn();

    SchedulerBinding.instance.addPostFrameCallback((_) {
    if( autenticado) {
      socketService.connect();
      
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_ , __, ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 0)
          )
          );
    } else {
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (_ , __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
          )
          );
    }
  });
}}
