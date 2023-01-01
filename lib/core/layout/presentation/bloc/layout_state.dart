part of 'layout_bloc.dart';

class LayoutState extends Equatable {
  final UserDataEntitie? userDataEntitie;
  final String errorMessage;
  final UserDataGetRequestStatus userDataGetRequestStatus;
  final UserDataGetRequestStatus getAccessTokenRequestStatus;
  final List<MyFollowingEventsEntitie> myFollowingEventsEntitie;
  final UserDataGetRequestStatus myFollowingEventsRequestStatus;
  final int currentBottomNavIndex;
  final UserDataGetRequestStatus categoriesRequestStatus;
  final CategoryEntitie? categoryEntitie;
  const LayoutState(
      {this.userDataEntitie,
      this.errorMessage = '',
      this.categoryEntitie,
      this.categoriesRequestStatus = UserDataGetRequestStatus.loading,
      this.currentBottomNavIndex = 0,
      this.myFollowingEventsEntitie = const [],
      this.myFollowingEventsRequestStatus = UserDataGetRequestStatus.loading,
      this.getAccessTokenRequestStatus = UserDataGetRequestStatus.loading,
      this.userDataGetRequestStatus = UserDataGetRequestStatus.loading});

  LayoutState copyWith({
    CategoryEntitie? categoryEntitie,
    UserDataGetRequestStatus? categoriesRequestStatus,
    int? currentBottomNavIndex,
    List<MyFollowingEventsEntitie>? myFollowingEventsEntitie,
    UserDataGetRequestStatus? myFollowingEventsRequestStatus,
    UserDataGetRequestStatus? getAccessTokenRequestStatus,
    UserDataEntitie? userDataEntitie,
    String? errorMessage,
    UserDataGetRequestStatus? userDataGetRequestStatus,
  }) {
    return LayoutState(
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
    );
  }

  @override
  List<Object?> get props => [
        categoriesRequestStatus,
        categoryEntitie,
        userDataGetRequestStatus,
        userDataEntitie,
        errorMessage,
        getAccessTokenRequestStatus,
        myFollowingEventsEntitie,
        myFollowingEventsRequestStatus,
        currentBottomNavIndex,
      ];
}
