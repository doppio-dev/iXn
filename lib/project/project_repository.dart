import 'package:doppio_dev_ixn/project/index.dart';

class ProjectRepository {
  final ProjectProvider _projectProvider = ProjectProvider();

  ProjectRepository();

  void test(bool isError) {
    _projectProvider.test(isError);
  }
}
