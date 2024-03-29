import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/base_user_info_entitie/base_user_info_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../features/Rooms/domain/entities/join_create_room_entity.dart';
import '../../features/Rooms/presentation/bloc/sockets/chat/chat_bloc.dart';
import '../../features/Rooms/presentation/bloc/sockets/voice/sockets_voice_bloc.dart';
import '../routes/app_route_names.dart';
import '../utl/utls.dart';
import 'default_values.dart';

class AppFontSize {
  static double s10 = 10.sp;
  static double s12 = 12.sp;
  static double s14 = 14.sp;
  static double s16 = 16.sp;
  static double s18 = 18.sp;
  static double s20 = 20.sp;
  static double s22 = 22.sp;
  static double s36 = 36.sp;
  static double s30 = 30.sp;
}

class AppPadding {
  static const double p8 = 10;
  static const double p10 = 10;
  static const double p12 = 12;
  static const double p14 = 14;
  static const double p16 = 16;
  static const double p18 = 18;
  static const double p20 = 20;
  static const double p22 = 22;
  static const double p25 = 25;
  static const double p30 = 30;
  static const double p40 = 40;
  static const double p50 = 50;
  static const double p60 = 60;

  static const double p6 = 6;
  static const double p4 = 4;
}

class AppRadius {
  static const double r5 = 5;
  static const double r8 = 10;
  static const double r10 = 10;
  static const double r12 = 12;
  static const double r14 = 14;
  static const double r16 = 16;
  static const double r18 = 18;
  static const double r20 = 20;
  static const double r22 = 22;
  static const double r30 = 30;
  static const double r35 = 35;

  static const double r40 = 40;
  static const double r70 = 70;
  static const double r100 = 100;
}

class AppElevation {
  static const double eL0 = 0;
  static const double eL2 = 2;
  static const double eL4 = 4;
  static const double eL6 = 6;
  static const double eL8 = 8;
  static const double eL10 = 10;
  static const double eL12 = 12;
  static const double eL14 = 14;
  static const double eL16 = 16;
  static const double eL18 = 18;
  static const double el20 = 20;
  static const double eL22 = 22;
}

class AppHeight {
  static double h1 = 1.h;
  static double h2 = 2.h;
  static double h4 = 4.h;
  static double h6 = 6.h;
  static double h8 = 8.h;
  static double h10 = 10.h;
  static double h12 = 12.h;
  static double h14 = 14.h;
  static double h16 = 16.h;
  static double h18 = 18.h;
  static double h20 = 20.h;

  static double h22 = 22.h;

  static double h28 = 28.h;

  static double h31 = 31.h;

  static double h46 = 46.5.h;
  static double h70 = 70.h;
  static double h80 = 80.h;
  static double h100 = 100.h;
  static double h130 = 130.h;
}

class AppWidth {
  static double w2 = 2.w;
  static double w4 = 4.w;
  static double w6 = 6.w;
  static double w8 = 8.w;
  static double w10 = 10.w;
  static double w12 = 12.w;
  static double w14 = 14.w;
  static double w16 = 16.w;
  static double w18 = 18.w;
  static double w20 = 20.w;
  static double w22 = 22.w;
  static double w44 = 44.w;
  static double w60 = 60.w;
  static double w65 = 65.w;

  static double w100 = 100.w;
  static double w130 = 130.w;
}

class AppColors {
  static Color scaffoldBackgroundColorDark = Colors.grey[900]!;
  static Color backgroundColorDark = const Color.fromRGBO(49, 49, 52, 1);
  static Color backgroundColorWhite = const Color(0xffF6F9F4);

  static Color white = Colors.white;
  static Color black = Colors.black;
  static Color toastSuccess = Colors.green;
  static Color toastWarning = Colors.yellow;
  static Color toastError = Colors.red;
  static Color navBarBackgroundColor = Colors.white;
  static Color scaffoldBackgroundColor = const Color(0xffF6F9F4);
  static Color primaryColorDark = const Color(
    0xff6A4CFF,
  );
  static Color primaryColorLight = const Color(0xff5ADAAC);
  static Color transparentColor = Colors.transparent;
  static Color buttonColor = const Color(0xff1ABC00);
  static Color textColorButton = Colors.white;
  static Color titleTextColor = const Color(0xff59675B);
  static Color titleTextColorDark = Colors.white;

  static Color subtitleTextColor = const Color(0xff6F6F6F);
  static Color iconColorBlack = Colors.black;

  static Color iconColorWhite = Colors.white;
  static Color iconColorGrey = const Color(0xff59675B);
  static Color textFieldBorderColorGrey = const Color(0xff6F6F6F);
  static Color dividerColorGrey = const Color(0xff979797);
  static Color textFormFieldFillColor = const Color(0xffF8F8F8);
  static Color starsCircleBorder = const Color(0xffFFCA10);
  static Color changeNameGreenColor = const Color(0xff1D592C);
}

void flutterToast({
  required String msg,
  required Color backgroundColor,
  required Color textColor,
  Toast? length = Toast.LENGTH_SHORT,
}) {
  Fluttertoast.showToast(
    toastLength: length,
    msg: msg,
    backgroundColor: backgroundColor,
    textColor: textColor,
  );
}

String covertDurationTime(double duration) {
  var hours = (duration / (60 * 60)).floor();
  var minutes = ((duration - hours * 60 * 60) / 60).floor();
  var second = ((duration - hours * 60 * 60 - minutes * 60)).floor();
  String convertedTime =
      '${hours.toString()}:${minutes.toString()}:${second.toString()}';

  return convertedTime;
}

class ConstVar {
  static String accessToken = '';
  static String userId = '';
  static late BaseUserDataEntity baseUserDataEntitie;
  static late Socket socket;
  static LayoutBottomSheetStatus layoutBottomSheetStatus =
      LayoutBottomSheetStatus.idle;
  static const Locale enLocale = Locale('en', 'US');
  static const Locale arLocale = Locale('ar', 'EG');
  static String appThemeKey = 'themeValue';
  static String appColorKey = 'AppColorsValue';
}

late AssetsAudioPlayer assetsAudioPlayer;
String currentPlayingPodcastsId = '';
String currentPausePodcastsId = '';
String currentDownloadingPodcastId = '';
late StreamController<double> downloadProgress;
late StreamController<double> uploadProgress;

void checkOnTabOnRoomCardLogic({
  JoinCreateRoomEntity? joinCreateRoomEntitie,
  required String tabedCardRoomId,
  required BuildContext context,
  required bool isCreateRoom,
  required ChatBloc chatBloc,
  required SocketsVoiceBloc socketsVoiceBloc,
  required String accessToken,
  required String roomName,
}) {
  if (joinCreateRoomEntitie == null ||
      joinCreateRoomEntitie == DefaultsValues.joinCreateRoomEntitieDefault) {
    socketsVoiceBloc.add(
      ConnectToSocketEvent(
        accessToken: accessToken,
        isCreateRoom: false,
        roomName: roomName,
      ),
    );
    flutterToast(
      msg: AppStrings.joiningRoom.tr(),
      backgroundColor: AppColors.toastWarning,
      textColor: AppColors.black,
    );
  } else if (tabedCardRoomId == joinCreateRoomEntitie.roomId) {
    Navigator.pushNamed(
      context,
      AppRoutesNames.roomScreen,
    );
  } else {
    if (isCreateRoom == true) {
      flutterToast(
        msg: AppStrings.youAreAdminInAnotherRoom.tr(),
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black,
      );
    } else {
      socketsVoiceBloc.add(const LeaveRoomEvent());
      chatBloc.add(const LeaveChatRoomEvent());
      flutterToast(
        msg: AppStrings.joiningRoom.tr(),
        backgroundColor: AppColors.toastWarning,
        textColor: AppColors.black,
      );

      socketsVoiceBloc.add(
        ConnectToSocketEvent(
          accessToken: accessToken,
          isCreateRoom: false,
          roomName: roomName,
        ),
      );
    }
  }
}

void showSnackBar({required BuildContext context, required String text}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 1),
      ),
    );

class AssetsPath {
  static const String forgetPasswordImage = 'assets/images/forget_password.png';
  static const String signUpImage = 'assets/images/signPhoto.png';
  static const String loginImage = 'assets/images/login.png';
  static const String noUserImage = 'assets/images/noImage.jpg';
  static const String errorImage = 'assets/images/error.gif';
  static const String userLeftAudio = 'assets/audio/userLeft.wav';
  static const String userEnterAudio = 'assets/audio/userEnter.wav';
  static const String userBecomeSpeakerAudio =
      'assets/audio/userBecomeSpeaker.wav';
  static const String userBecomeAudienceAudio =
      'assets/audio/userBecomeAudience.wav';
  static const String adminLeftAudio = 'assets/audio/adminLeft.wav';
  static const String imageLogo = 'assets/images/logo.png';
  static const String languagesPath = 'assets/translations';
}
