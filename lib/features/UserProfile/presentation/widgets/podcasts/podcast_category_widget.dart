import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/layout/domain/entities/category_info_entitie.dart';
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
          'Podcast Category',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        BlocBuilder<LayoutBloc, LayoutState>(
          builder: (context, state) {
            podcastCategoryValue = state.categoryEntitie!.categories.first.name;
            return StatefulBuilder(
              builder: (context, setState) => DropdownButton<String>(
                  style: Theme.of(context).textTheme.titleSmall,
                  dropdownColor: Theme.of(context).colorScheme.background,
                  value: podcastCategoryValue,
                  items: state.categoryEntitie!.categories
                      .map<DropdownMenuItem<String>>(
                          (CategoryInfoEtitie categoryInfoEtitie) {
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
