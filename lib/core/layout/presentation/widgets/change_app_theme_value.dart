import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../bloc/layout_bloc.dart';

class ChangeAppThemeValueWidget extends StatelessWidget {
  const ChangeAppThemeValueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return Expanded(
      child: BlocBuilder<LayoutBloc, LayoutState>(
        builder: (context, state) => ListView(children: [
          RadioListTile<int>(
            activeColor: Theme.of(context).primaryColor,
            title: Text(
              'Light Mode',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: 0,
            groupValue: state.themeModeValue.index,
            onChanged: (value) {
              layoutBloc.add(CacheThemeValueEvent(
                  key: ConstVar.appThemeKey, isDark: false));
            },
          ),
          RadioListTile<int>(
            activeColor: Theme.of(context).primaryColor,
            title: Text(
              'Dark Mode',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            value: 1,
            groupValue: state.themeModeValue.index,
            onChanged: (value) {
              layoutBloc.add(CacheThemeValueEvent(
                  key: ConstVar.appThemeKey, isDark: true));
            },
          ),
        ]),
      ),
    );
  }
}
