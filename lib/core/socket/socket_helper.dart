import 'package:socket_io_client/socket_io_client.dart';

class SocketHelper {
  static late Socket socket;
  static void initSocket(String accessToken) {
    socket = io(
      'https://audiocomms-podcast-api.onrender.com/',
      <String, dynamic>{
        'auth': {'token': accessToken},
        'transports': ['websocket'],
      },
    );
  }
}
