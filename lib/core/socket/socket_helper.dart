import 'package:socket_io_client/socket_io_client.dart';

class SocketHelper {
  static void lisentOnUserAskedToTalk(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('userAskedForPerms', handler);
  }

  static void listenOnUserJoin(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('userJoined', handler);
  }

  static void listenOnUserLeft(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('userLeft', handler);
  }

  static void listenOnUserChangedToAudience(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('userChangedToAudience', handler);
  }

  static void listenOnUserChangedToBrodcaster(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('userChangedToBrodcaster', handler);
  }

  static void listenOnAdminLeft(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('adminLeft', handler);
  }

  static void listenOnRoomEnded(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('roomEnded', handler);
  }
}
