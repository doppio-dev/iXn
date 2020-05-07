import 'package:doppio_dev_ixn/project_setting/index.dart';

class ProjectSettingRepository {
  final ProjectSettingProvider _projectSettingProvider = ProjectSettingProvider();

  ProjectSettingRepository();

  void test(bool isError) {
    _projectSettingProvider.test(isError);
  }
}
