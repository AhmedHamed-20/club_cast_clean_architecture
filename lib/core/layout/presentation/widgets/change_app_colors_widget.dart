import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/layout_bloc.dart';

class ChangeAppColorsWidget extends StatelessWidget {
  const ChangeAppColorsWidget({
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
            'Material Base Line',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          value: 0,
          groupValue: state.appColorsValue.index,
          onChanged: (value) {
            layoutBloc.add(
              CacheAppColorsValueEvent(
                color: layoutBloc.availbleAppColors[0],
                key: ConstVar.appColorKey,
              ),
            );
          },
        ),
        RadioListTile<int>(
          activeColor: Theme.of(context).primaryColor,
          title: Text(
            'Amber',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          value: 1,
          groupValue: state.appColorsValue.index,
          onChanged: (value) {
            layoutBloc.add(
              CacheAppColorsValueEvent(
                color: layoutBloc.availbleAppColors[1],
                key: ConstVar.appColorKey,
              ),
            );
          },
        ),
        RadioListTile<int>(
          activeColor: Theme.of(context).primaryColor,
          title: Text(
            'Big Stone',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          value: 2,
          groupValue: state.appColorsValue.index,
          onChanged: (value) {
            layoutBloc.add(
              CacheAppColorsValueEvent(
                color: layoutBloc.availbleAppColors[2],
                key: ConstVar.appColorKey,
              ),
            );
          },
        ),
        RadioListTile<int>(
          activeColor: Theme.of(context).primaryColor,
          title: Text(
            'Wasabi',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          value: 3,
          groupValue: state.appColorsValue.index,
          onChanged: (value) {
            layoutBloc.add(
              CacheAppColorsValueEvent(
                color: layoutBloc.availbleAppColors[3],
                key: ConstVar.appColorKey,
              ),
            );
          },
        ),
      ]),
    );
  }
}
