import 'package:club_cast_clean_architecture/core/constants/params.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketHelper {
  static void lisenOnUserAskedToTalk(
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
      'name': createRoomParams.roomName,
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

  static void listenOnErrors(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('errorMessage', handler);
  }

  static void endRoomAdmin({required Socket socket}) {
    socket.emit('endRoom');
  }

  static void sendMessage({
    required Socket socket,
    required Map<String, dynamic> messageData,
  }) {
    socket.emit(
      'sendMessage',
      messageData,
    );
  }

  static void listenOnBroadCasterToken(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('brodcasterToken', handler);
  }

  static void listenOnAudienceToken(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('audienceToken', handler);
  }

  static void askToTalk({
    required Socket socket,
  }) {
    socket.emit(
      'askForPerms',
    );
  }

  static void removeMessage(
      {required Socket socket, required String messageId}) {
    socket.emit('removeMessage', messageId);
  }

  static void listenOnMessageRemoveSuccess(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('removeMessageSuccess', handler);
  }

  static void listenOnMessageSentSuccess(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('sendMessageSuccess', handler);
  }

  static void listenOnMessageReceived(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('message', handler);
  }

  static void listenOnMessageRemoved(
      {required Socket socket, required dynamic Function(dynamic) handler}) {
    socket.on('messageRemoved', handler);
  }

  static void givePermsToUser(
      {required Socket socket, required Map<String, dynamic> user}) {
    socket.emit('givePermsTo', user);
  }

  static void returnUserToAudience(
      {required Socket socket, required Map<String, dynamic> user}) {
    socket.emit('takeAwayPermsFrom', user);
  }
}
