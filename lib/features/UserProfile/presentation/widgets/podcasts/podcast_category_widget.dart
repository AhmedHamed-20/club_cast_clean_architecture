import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/AppStrings/app_strings.dart';
import '../../../../../core/constants/constants.dart';
import '../../../../../core/layout/domain/entities/category_info_entity.dart';
import '../../../../../core/layout/presentation/bloc/layout_bloc.dart';

String podcastCategoryValue = '';

class PodcastCategoryWidget extends StatelessWidget {
  const PodcastCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.podcastCategory.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, state) {
            podcastCategoryValue = state.categoryEntitie!.categories.first.name;
            return StatefulBuilder(
              builder: (context, setState) => DropdownButton<String>(
                  underline: const SizedBox.shrink(),
                  style: Theme.of(context).textTheme.titleMedium,
                  alignment: Alignment.center,
                  borderRadius: BorderRadius.circular(AppRadius.r22),
                  dropdownColor: Theme.of(context).colorScheme.background,
                  value: podcastCategoryValue,
                  items: state.categoryEntitie!.categories
                      .map<DropdownMenuItem<String>>(
                          (CategoryInfoEntity categoryInfoEtitie) {
                    return DropdownMenuItem<String>(
                      value: categoryInfoEtitie.name,
                      child: Text(categoryInfoEtitie.name),
                    );
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      podcastCategoryValue = newvalue!;
                    });
                  }),
            );
          },
        )
      ],
    );
  }
}
