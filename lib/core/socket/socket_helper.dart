import 'package:club_cast_clean_architecture/core/constants/params.dart';
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

  static void createRoom(
      {required Socket socket, required CreateRoomParams createRoomParams}) {
    socket.emit('createRoom', {
      'roomName': createRoomParams.roomName,
      'status': createRoomParams.status,
      'isRecording': createRoomParams.isRecording,
      'category': createRoomParams.category,
    });
  }

  static void listenOnRoomCreated(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('createRoomSuccess', handler);
  }

  static void joinRoom({required Socket socket, required String roomName}) {
    socket.emit('joinRoom', roomName);
  }

  static void listenOnRoomJoined(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('joinRoomSuccess', handler);
  }
}
