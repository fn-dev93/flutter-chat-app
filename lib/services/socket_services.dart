
import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


enum ServerStatus {
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket ;

  Function get emit =>this._socket.emit;

  ServerStatus get serverStatus =>this._serverStatus;
  IO.Socket get socket =>this._socket;


  void connect() async {

  final token = await AuthService.getToken();

    // Dart client
  this._socket = IO.io( Enviroment.socketUrl, {
    'transports':['websocket'],
    'autoConnect':true,
    'fonrceNew': true,
    'extraHeaders':{
      'x-token': token,
    }
  });

  this._socket.onConnect((_) {
  this._serverStatus = ServerStatus.Online;
  notifyListeners();

  });

  this._socket.onDisconnect((_){
    this._serverStatus = ServerStatus.Offline;
  notifyListeners();
  });
  
  this._socket.on('nuevo-mensaje',(payload){
    print('nuevo-mensaje: $payload');
    print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'No hay' );
    notifyListeners();
  });

  }

  void disconnect(){
    this._socket.disconnect();
  }
}