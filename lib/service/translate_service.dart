import 'package:doppio_dev_ixn/generated/l10n.dart';
import 'package:flutter/widgets.dart';

class TranslateService {
  static final _translateServiceSingleton = TranslateService._internal();

  S locale;

  factory TranslateService() {
    return _translateServiceSingleton;
  }
  TranslateService._internal();

  void update(BuildContext context) {
    locale = S.of(context);
  }
}
