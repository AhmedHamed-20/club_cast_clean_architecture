import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionAndPath {
  static Future<int> getAndroidVersion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }

  static Future<bool> checkStoragePermissions() async {
    late bool isPermissionGranted;
    if (await getAndroidVersion() > 29) {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted &&
          await Permission.manageExternalStorage.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
        await Permission.manageExternalStorage.request();
        if (await Permission.storage.isGranted &&
            await Permission.accessMediaLocation.isGranted &&
            await Permission.manageExternalStorage.isGranted) {
          isPermissionGranted = true;
        }
      }
    } else {
      if (await Permission.storage.isGranted &&
          await Permission.accessMediaLocation.isGranted) {
        isPermissionGranted = true;
      } else {
        await Permission.storage.request();
        await Permission.accessMediaLocation.request();
        if (await Permission.storage.isGranted &&
            await Permission.accessMediaLocation.isGranted) {
          isPermissionGranted = true;
        }
      }
    }
    return isPermissionGranted;
  }

  static File getSavedPath(
      {required String fileName,
      String fileType = 'mp3',
      required bool isDownload}) {
    Directory directoryPath;
    if (isDownload) {
      directoryPath = Directory('/storage/emulated/0/Club Cast/Downloads');
    } else {
      directoryPath = Directory('/storage/emulated/0/Club Cast/Recordings');
    }
    final removeOrSymbole = fileName.replaceAll('|', '');
    final customizedFileName = removeOrSymbole.replaceAll('/', '');
    final file = File('${directoryPath.path}/($customizedFileName).$fileType');
    return file;
  }
}
