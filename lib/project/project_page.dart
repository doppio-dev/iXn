import 'package:doppio_dev_ixn/core/index.dart';
import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:file_access/file_access.dart' as file_access;

class ProjectPage extends StatefulWidget {
  static const String routeName = '/project';

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _projectBloc = ProjectBloc();
  ProjectScreen projectScreen;
  @override
  void initState() {
    super.initState();
    projectScreen = ProjectScreen(projectBloc: _projectBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      bloc: _projectBloc,
      builder: (
        BuildContext context,
        ProjectState currentState,
      ) {
        ContextService().buidlContext(context);
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
          persistentFooterButtons: <Widget>[
            Container(
              width: ContextService().deviceSize.width,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      projectScreen.addKey();
                    },
                    tooltip: 'Add',
                    icon: Icon(Icons.add),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      await _import();
                    },
                    tooltip: 'Import',
                    icon: Icon(Icons.file_upload),
                  ),
                  IconButton(
                    onPressed: () async {
                      projectScreen.save();
                    },
                    tooltip: 'Save',
                    icon: Icon(Icons.save),
                  ),
                ],
              ),
            ),
          ],
          body: projectScreen,
        );
      },
    );
  }

  Future _import() async {
    try {
      final newFiles = (await file_access.open(false, false, allowedTypes: ['zip']));
      final newFile = newFiles.firstOrDefault;
      print(newFile?.path);
      // var text = await newFile.readAsString();
      // var json = Map<String, String>.from(jsonDecode(text) as Map<dynamic, dynamic>);
      // print(json);
    } catch (_, stackTrace) {
      log(_?.toString(), name: 'ProjectsPage', error: _, stackTrace: stackTrace);
      ErrorServiceService.snackBar(_?.toString());
    }
  }
}
