
import 'package:chat_app/helpers/mostrar_aleta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/custom_label.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(title: 'Messanger',),
                _Form(),
                Labels(
                  route: 'register',
                  question1: '¿No tienes Cuenta?',
                  question2: 'Crea una ahora!',),
                Text(
                  'Términos y condiciones',
                  style: TextStyle(fontWeight: FontWeight.w200),
                )
              ],
            ),
          ),
        ),
      ));
  }
}



class _Form extends StatefulWidget {

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    
@override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);



    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress ,
            textController: emailCtrl,
          ),

          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),

          BotonAzul(
            text: 'Ingrese',
            onPress: authService.autenticando ? null : () async {

              FocusScope.of(context).unfocus();

              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if ( loginOk ) {
                socketService.connect();
               return Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                // mostrar alerta
                mostrarAlerta(context, 'Login incorrecto', 'Usuario o contraseña incorrectos');
              }
            },
            ),
            
        ],
      ),
      
    );
  }
}

