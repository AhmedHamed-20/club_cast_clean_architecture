part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final UserDataEntitie? userDataEntitie;
  final String errorMessage;
  final AppLanguages appLanguages;
  final LayoutBottomSheetStatus layoutBottomSheetStatus;
  final UserDataGetRequestStatus userDataGetRequestStatus;
  final UserDataGetRequestStatus getAccessTokenRequestStatus;
  final MyFollowingEventsEntitie? myFollowingEventsEntitie;
  final UserDataGetRequestStatus myFollowingEventsRequestStatus;
  final int currentBottomNavIndex;
  final UserDataGetRequestStatus categoriesRequestStatus;
  final CategoryEntity? categoryEntitie;
  final LogoutRequestStatus logoutRequestStatus;
  final AccessTokenUpdateRequestStatus accessTokenUpdateRequestStatus;
  final int statusCode;
  final bool isEndOfEvents;
  final ThemeModeValue themeModeValue;
  final BaseThemeClass baseThemeClass;
  final AppColorsValue appColorsValue;
  const LayoutState(
      {this.userDataEntitie,
      this.errorMessage = '',
      this.categoryEntitie,
      this.appLanguages = AppLanguages.en,
      this.baseThemeClass = const MaterialBaseline(),
      this.appColorsValue = AppColorsValue.materialBaseLine,
      this.themeModeValue = ThemeModeValue.lightMode,
      this.layoutBottomSheetStatus = LayoutBottomSheetStatus.idle,
      this.isEndOfEvents = false,
      this.statusCode = 0,
      this.logoutRequestStatus = LogoutRequestStatus.idle,
      this.accessTokenUpdateRequestStatus = AccessTokenUpdateRequestStatus.idle,
      this.categoriesRequestStatus = UserDataGetRequestStatus.loading,
      this.currentBottomNavIndex = 0,
      this.myFollowingEventsEntitie,
      this.myFollowingEventsRequestStatus = UserDataGetRequestStatus.loading,
      this.getAccessTokenRequestStatus = UserDataGetRequestStatus.loading,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  LayoutState copyWith({
    bool? isEndOfEvents,
    AppLanguages? appLanguages,
    int? statusCode,
    LayoutBottomSheetStatus? layoutBottomSheetStatus,
    AccessTokenUpdateRequestStatus? accessTokenUpdateRequestStatus,
    CategoryEntity? categoryEntitie,
    UserDataGetRequestStatus? categoriesRequestStatus,
    int? currentBottomNavIndex,
    MyFollowingEventsEntitie? myFollowingEventsEntitie,
    UserDataGetRequestStatus? myFollowingEventsRequestStatus,
    UserDataGetRequestStatus? getAccessTokenRequestStatus,
    UserDataEntitie? userDataEntitie,
    String? errorMessage,
    LogoutRequestStatus? logoutRequestStatus,
    UserDataGetRequestStatus? userDataGetRequestStatus,
    ThemeModeValue? themeModeValue,
    BaseThemeClass? baseThemeClass,
    AppColorsValue? appColorsValue,
  }) {
    return LayoutState(
      appLanguages: appLanguages ?? this.appLanguages,
      layoutBottomSheetStatus:
          layoutBottomSheetStatus ?? this.layoutBottomSheetStatus,
      isEndOfEvents: isEndOfEvents ?? this.isEndOfEvents,
      logoutRequestStatus: logoutRequestStatus ?? this.logoutRequestStatus,
      statusCode: statusCode ?? this.statusCode,
      accessTokenUpdateRequestStatus:
          accessTokenUpdateRequestStatus ?? this.accessTokenUpdateRequestStatus,
      categoryEntitie: categoryEntitie ?? this.categoryEntitie,
      categoriesRequestStatus:
          categoriesRequestStatus ?? this.categoriesRequestStatus,
      currentBottomNavIndex:
          currentBottomNavIndex ?? this.currentBottomNavIndex,
      myFollowingEventsEntitie:
          myFollowingEventsEntitie ?? this.myFollowingEventsEntitie,
      myFollowingEventsRequestStatus:
          myFollowingEventsRequestStatus ?? this.myFollowingEventsRequestStatus,
      getAccessTokenRequestStatus:
          getAccessTokenRequestStatus ?? this.getAccessTokenRequestStatus,
      userDataEntitie: userDataEntitie ?? this.userDataEntitie,
      errorMessage: errorMessage ?? this.errorMessage,
      userDataGetRequestStatus:
          userDataGetRequestStatus ?? this.userDataGetRequestStatus,
      themeModeValue: themeModeValue ?? this.themeModeValue,
      baseThemeClass: baseThemeClass ?? this.baseThemeClass,
      appColorsValue: appColorsValue ?? this.appColorsValue,
    );
  }

  @override
  List<Object?> get props => [
        appLanguages,
        isEndOfEvents,
        statusCode,
        layoutBottomSheetStatus,
        categoriesRequestStatus,
        categoryEntitie,
        accessTokenUpdateRequestStatus,
        userDataGetRequestStatus,
        userDataEntitie,
        logoutRequestStatus,
        errorMessage,
        getAccessTokenRequestStatus,
        myFollowingEventsEntitie,
        myFollowingEventsRequestStatus,
        currentBottomNavIndex,
        themeModeValue,
        baseThemeClass,
        appColorsValue,
      ];
}
