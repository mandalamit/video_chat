import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole? _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //         child: TextField(
              //       controller: _channelController,
              //       decoration: InputDecoration(
              //         errorText:
              //             _validateError ? 'Channel name is mandatory' : null,
              //         border: UnderlineInputBorder(
              //           borderSide: BorderSide(width: 1),
              //         ),
              //         hintText: 'Channel name',
              //       ),
              //     ))
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ElevatedButton(
                        onPressed: onJoin, 
                        child: Text('video call'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.purpleAccent),
                          foregroundColor: MaterialStateProperty.all(Colors.white) 
                        ),
                        ),
                    ),
                    // Expanded(
                    //   child: RaisedButton(
                    //     onPressed: onJoin,
                    //     child: Text('Join'),
                    //     color: Colors.blueAccent,
                    //     textColor: Colors.white,
                    //   ),
                    // )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {

    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: 'learning',
          role: _role,
        ),
      ),
    );

  }
  // Future<void> onJoin() async {
  //   // update input validation
  //   setState(() {
  //     _channelController.text.isEmpty
  //         ? _validateError = true
  //         : _validateError = false;
  //   });
  //   if (_channelController.text.isNotEmpty) {
  //     // await for camera and mic permissions before pushing video page
  //     await _handleCameraAndMic(Permission.camera);
  //     await _handleCameraAndMic(Permission.microphone);
  //     // push video page with given channel name
  //     await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => CallPage(
  //           channelName: _channelController.text,
  //           role: _role,
  //         ),
  //       ),
  //     );
  //   }
  // }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
