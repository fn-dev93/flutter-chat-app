import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:chat_app/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  final usuarioService = new UsuarioService();

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<User> users = [];

  @override
  void initState() {
    this._cargarUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final authservice = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authservice.usuario;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( usuario.nombre ,style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {

            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();

        }, icon: Icon(Icons.exit_to_app, color: Colors.black54)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: 
            (socketService.serverStatus == ServerStatus.Online) ?
            Icon(Icons.check_circle, color: Colors.blue[400],)
            : Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        child: _listViewUsers(),
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuario,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue,
        ),
        )
    );
    
  }

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i)=> _usuarioListTile( users[i] ), 
      separatorBuilder: (_, i ) => Divider(), 
      itemCount: users.length);
  }

  ListTile _usuarioListTile(User user) {
    return ListTile(
        title: Text(user.nombre),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          child: Text(user.nombre.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){
          final chatService = Provider.of<ChatService>(context, listen:  false);
          chatService.usuarioPara = user;
          Navigator.pushNamed(context, 'chat');
        },
      );
  }

  _cargarUsuario() async{

    this.users = await usuarioService.getUsuarios();

    setState(() {});

    // await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
  
}