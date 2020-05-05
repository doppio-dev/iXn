import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project/index.dart';

class ProjectPage extends StatefulWidget {
  static const String routeName = '/project';

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _projectBloc = ProjectBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Project'),
      ),
      body: ProjectScreen(projectBloc: _projectBloc),
    );
  }
}
