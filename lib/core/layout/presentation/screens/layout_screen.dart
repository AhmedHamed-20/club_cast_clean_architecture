import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utl/utls.dart';
import '../widgets/main_layout_widget.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<LayoutBloc>(context)
        .add(ActiveUserDataGetEvent(ConstVar.accessToken));
  }

  @override
  Widget build(BuildContext context) {
    var layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
      switch (state.userDataGetRequestStatus) {
        case UserDataGetRequestStatus.loading:
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case UserDataGetRequestStatus.success:
          return const MainLayoutWidget();
        case UserDataGetRequestStatus.error:
          return Scaffold(
            body: Center(
              child: Text(state.errorMessage),
            ),
          );
      }
    });
  }
}
