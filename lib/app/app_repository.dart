import 'package:doppio_dev_ixn/app/index.dart';

class AppRepository {
  final AppProvider _appProvider = AppProvider();

  AppRepository();

  void test(bool isError) {
    _appProvider.test(isError);
  }
}
