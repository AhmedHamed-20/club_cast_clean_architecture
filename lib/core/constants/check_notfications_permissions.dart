import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckNotificationsPermission {
  static Future<bool> checkMicPermission() async {
    if (await Permission.notification.isGranted) {
      return true;
    } else {
      await Permission.notification.request();
      if (await Permission.notification.isGranted) {
        return true;
      } else {
        flutterToast(
          msg:
              'Please allow notification permission to alert you when your favorite room is live',
          backgroundColor: AppColors.toastWarning,
          textColor: AppColors.black,
        );
        return false;
      }
    }
  }
}
