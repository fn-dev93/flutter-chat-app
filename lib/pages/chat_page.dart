import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>  with TickerProviderStateMixin{

   final _textController = new TextEditingController();
   final _focusNode = new FocusNode();

   List<ChatMessage> _messages =[];

   bool _texting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text('Te', style: TextStyle(fontSize: 12),),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text('Test 1', style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, i) => _messages[i],
                  itemCount: _messages.length,
                  reverse: true,
                  )
                  ),
                  Divider( height:  1,),
                  //TODO: caja de texto
                  Container(
                    child: _inputChat(),
                    color: Colors.white,
                  )
            ],
          ),
    )
    );
  }

  Widget _inputChat(){

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit ,
                onChanged: (texto){
                  setState(() {
                    if (texto.trim().length > 0) {
                      _texting = true;
                    } else {
                      _texting = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
                focusNode: _focusNode,
              )
              ),
            
            //Boton de enviar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4 ),
              child: Platform.isIOS
              ? CupertinoButton(
                
                child: Text('Enviar'), 
                onPressed: _texting
                                  ? () => _handleSubmit(_textController.text.trim())
                                  : null, )
              : Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400],),
                  child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: _texting
                                  ? () => _handleSubmit(_textController.text.trim())
                                  : null, 
                        icon: Icon(Icons.send),
                              ),
                )
            ))
          ],
        ),
      ) ,
    );
  }

  _handleSubmit(String texto){

    if (texto.length == 0 ) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto, 
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
      );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _texting = false;
    });
  }

  @override
  void dispose() {
    //TODO: off del socket

    for( ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}