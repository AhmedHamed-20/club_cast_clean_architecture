import 'package:club_cast_clean_architecture/core/constants/constants.dart';
import 'package:club_cast_clean_architecture/core/widgets/defaults.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(
      {super.key, required this.message, this.onRetry, this.statusCode});
  final String message;
  final VoidCallback? onRetry;
  final int? statusCode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Column(
        children: [
          //    Image.asset('assets/images/error.gif'),
          const SizedBox(height: AppHeight.h10),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppHeight.h20),
          statusCode != null && statusCode == 403 || statusCode == 401
              ? Defaults.defaultButton(
                  onPressed: () {},
                  context: context,
                  text: 'Go to login screen',
                )
              : Defaults.defaultButton(
                  onPressed: onRetry!,
                  context: context,
                  text: 'Retry',
                ),
        ],
      ),
    );
  }
}
