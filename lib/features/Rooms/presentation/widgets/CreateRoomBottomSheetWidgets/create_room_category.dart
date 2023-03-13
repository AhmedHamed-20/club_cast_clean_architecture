import 'package:club_cast_clean_architecture/core/constants/AppStrings/app_strings.dart';
import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/layout/presentation/bloc/layout_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/layout/domain/entities/category_info_entitie.dart';

String roomCategoryValue = '';

class CreateRoomCategory extends StatelessWidget {
  const CreateRoomCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.roomCategory.tr(),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        BlocBuilder<LayoutBloc, LayoutState>(builder: (context, state) {
          roomCategoryValue = state.categoryEntitie!.categories.first.name;
          return StatefulBuilder(
            builder: (context, setState) => DropdownButton<String>(
                underline: const SizedBox.shrink(),
                style: Theme.of(context).textTheme.titleMedium,
                alignment: Alignment.center,
                borderRadius: BorderRadius.circular(AppRadius.r22),
                dropdownColor: Theme.of(context).colorScheme.background,
                value: roomCategoryValue,
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
                    roomCategoryValue = newvalue!;
                  });
                }),
          );
        })
      ],
    );
  }
}
