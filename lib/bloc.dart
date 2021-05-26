import 'dart:async';

import 'dart:io';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BlocPattern {
  StreamController<Object> counterss = StreamController();

  // final url =
  //     "wss://timiun-pre-release.herokuapp.com/v1/timesales/5feb78a8e21a08fa7b12212d/websocket-counter?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpYXQiOiIyMDIxLTAxLTA1VDIyOjQzOjM0LjU5MDIyMzU4OCswMTowMCIsInJvbGUiOiJ1c2VyIiwidXNlcmlkIjoiNWZiOTdmNWI3ZGU2YTJmZDAwNDMyMjZhIn0.WBqjIsV2oxGlHJ3fyB9mPxj5UM8FjvjdAh-7yjCa5ss";

  void listen(IOWebSocketChannel channel) {
    counterss.addStream(channel.stream);
  }

  //add counter
  StreamSink<Object> get counterAdd => counterss.sink;

  //Read counter
  Stream<Object> get readCounter => counterss.stream;

  void dispose() {
    counterss.close();
  }
}
