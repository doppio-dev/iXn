import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContextService {
  static final _contextServiceSingleton = ContextService._internal();

  Size deviceSize;

  TextTheme textTheme;
  ThemeData theme;
  factory ContextService() {
    return _contextServiceSingleton;
  }

  ContextService._internal();

  void buidlContext(BuildContext context) {
    //todo: optimize for phone
    // if (this.deviceSize == null || kIsWeb) {
    // print('buidlContext');
    deviceSize = MediaQuery.of(context).size;
    // }
    // if (theme == null) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
    // }
  }

  void changeTheme(BuildContext context) {
    theme = Theme.of(context);
    textTheme = theme.textTheme;
  }
}
