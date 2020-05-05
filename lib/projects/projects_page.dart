import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/projects/index.dart';

class ProjectsPage extends StatefulWidget {
  static const String routeName = '/projects';

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final _projectsBloc = ProjectsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects'),
      ),
      body: ProjectsScreen(projectsBloc: _projectsBloc),
    );
  }
}
