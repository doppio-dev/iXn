import 'package:doppio_dev_ixn/projects/index.dart';

class ProjectsRepository {
  final ProjectsProvider _projectsProvider = ProjectsProvider();

  ProjectsRepository();

  void test(bool isError) {
    _projectsProvider.test(isError);
  }
}
