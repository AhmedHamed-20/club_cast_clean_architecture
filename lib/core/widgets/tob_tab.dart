import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TobTabs extends StatelessWidget {
  final List tabs;
  final int currentActiveTab;
  final int currentWidgetIndex;
  final BuildContext context;

  const TobTabs(
      {super.key,
      required this.tabs,
      required this.currentActiveTab,
      required this.currentWidgetIndex,
      required this.context});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p4),
      child: Container(
        height: AppHeight.h70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppRadius.r10,
          ),
          color: Theme.of(context).backgroundColor,
          border: Border.all(
            color: currentActiveTab == currentWidgetIndex
                ? AppColors.buttonColor
                : Theme.of(context).backgroundColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Center(
            child: Text(
              tabs[currentWidgetIndex],
              style: currentActiveTab == tabs.indexOf(tabs[currentWidgetIndex])
                  ? Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Theme.of(context).primaryColor)
                  : Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}
