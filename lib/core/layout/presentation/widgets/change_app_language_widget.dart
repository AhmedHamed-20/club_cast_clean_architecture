import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/layout_bloc.dart';

class ChangeAppLanguageWidget extends StatelessWidget {
  const ChangeAppLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final layoutBloc = BlocProvider.of<LayoutBloc>(context);
    return BlocBuilder<LayoutBloc, LayoutState>(
      builder: (context, state) => Column(children: [
        RadioListTile<int>(
          activeColor: Theme.of(context).primaryColor,
          title: Text(
            AppStrings.english.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          value: 0,
          groupValue: state.appLanguages.index,
          onChanged: (value) {
            layoutBloc.add(
              CacheAppLanguageEvent(
                key: AppStrings.appLanguageKey,
                context: context,
                language: 'en',
              ),
            );
          },
        ),
        RadioListTile<int>(
          activeColor: Theme.of(context).primaryColor,
          title: Text(
            AppStrings.arabic.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          value: 1,
          groupValue: state.appLanguages.index,
          onChanged: (value) {
            layoutBloc.add(
              CacheAppLanguageEvent(
                key: AppStrings.appLanguageKey,
                context: context,
                language: 'ar',
              ),
            );
          },
        ),
      ]),
    );
  }
}
