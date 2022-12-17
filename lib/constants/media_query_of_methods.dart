import 'package:flutter/cupertino.dart';

class MediaQueryOfMethods {
  static double getAppWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double getAppHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
