import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';

class ProjectSettingPage extends StatefulWidget {
  static const String routeName = '/projectSetting';

  @override
  _ProjectSettingPageState createState() => _ProjectSettingPageState();
}

class _ProjectSettingPageState extends State<ProjectSettingPage> {
  final _projectSettingBloc = ProjectSettingBloc();
  ProjectSettingScreen screen;
  @override
  void initState() {
    screen = ProjectSettingScreen(projectSettingBloc: _projectSettingBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProjectSetting'),
        actions: [IconButton(icon: const Icon(Icons.save), onPressed: () => screen.save())],
      ),
      body: screen,
    );
  }
}
