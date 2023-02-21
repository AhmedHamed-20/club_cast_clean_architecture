import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckMicPermission {
  static Future<bool> checkMicPermission() async {
    if (await Permission.microphone.isGranted) {
      return true;
    } else {
      await Permission.microphone.request();
      if (await Permission.microphone.isGranted) {
        return true;
      } else {
        flutterToast(
          msg:
              'Please allow microphone permission to join the room,don\'t worry you can mute yourself',
          backgroundColor: AppColors.toastWarning,
          textColor: AppColors.black,
        );
        return false;
      }
    }
  }
}
