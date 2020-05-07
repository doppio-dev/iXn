import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:pedantic/pedantic.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              final args = ModalRoute.of(context).settings.arguments as Map<String, Object>;
              if (args == null) {
                print('args==null');
                return;
              }
              final id = args['id'] as String;
              unawaited(navigatorKey.currentState.pushNamed(
                ProjectSettingPage.routeName,
                arguments: {'id': id},
              ));
            },
          )
        ],
      ),
      body: ProjectScreen(projectBloc: _projectBloc),
    );
  }
}
