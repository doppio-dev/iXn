import 'package:doppio_dev_ixn/project/index.dart';
import 'package:rxdart/rxdart.dart';

class ProjectsRepository {
  static final ProjectsRepository _projectsRepositorySingleton = ProjectsRepository._internal();
  factory ProjectsRepository() {
    return _projectsRepositorySingleton;
  }
  ProjectsRepository._internal();

  final projectSubject = PublishSubject<ProjectModel>();
}
