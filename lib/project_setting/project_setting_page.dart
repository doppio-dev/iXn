import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';

class ProjectSettingPage extends StatefulWidget {
  static const String routeName = '/projectSetting';

  @override
  _ProjectSettingPageState createState() => _ProjectSettingPageState();
}

class _ProjectSettingPageState extends State<ProjectSettingPage> {
  final _projectSettingBloc = ProjectSettingBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProjectSetting'),
      ),
      body: ProjectSettingScreen(projectSettingBloc: _projectSettingBloc),
    );
  }
}
