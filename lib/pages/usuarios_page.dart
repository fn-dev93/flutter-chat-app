import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final users = <User>[
    User(online: true, email: 'test1@test.com', nombre: 'Maria', uid: '1'),
    User(online: false, email: 'test2@test.com', nombre: 'Melissa', uid: '2'),
    User(online: true, email: 'test3@test.com', nombre: 'Carla', uid: '3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mi Nombre',style: TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          
        }, icon: Icon(Icons.exit_to_app, color: Colors.black54)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: 
            Icon(Icons.check_circle, color: Colors.blue[400],),
            // Icon(Icons.offline_bolt, color: Colors.red,),
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
      );
  }

  _cargarUsuario() async{

    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
  
}