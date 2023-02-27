import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/constants/media_query_of_methods.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeChangeBottomSheetWidget extends StatelessWidget {
  const ThemeChangeBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return SizedBox(
      height: MediaQueryOfMethods.getAppHeight(context) * 0.4,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Column(
          children: [
            Text(
              'Change App Theme',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
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
                      layoutBloc.add(const CacheThemeValueEvent(
                          key: 'themeValue', isDark: false));
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
                      layoutBloc.add(const CacheThemeValueEvent(
                          key: 'themeValue', isDark: true));
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
