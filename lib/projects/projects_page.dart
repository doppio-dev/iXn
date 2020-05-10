import 'package:doppio_dev_ixn/core/logger.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:uuid/uuid.dart';
import 'package:file_access/file_access.dart' as file_access;
import 'package:doppio_dev_ixn/core/index.dart';

class ProjectsPage extends StatefulWidget {
  static const String routeName = '/projects';

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final projectsScreen = ProjectsScreen(projectsBloc: ProjectsBloc());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: Key('projecs_sc'),
        appBar: AppBar(
          title: Text('Projects'),
        ),
        body: projectsScreen,
        persistentFooterButtons: <Widget>[
          Container(
            width: ContextService().deviceSize.width,
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    projectsScreen.projectsBloc.add(AddProjectsEvent(projectModel: ProjectModel(id: Uuid().v4())));
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
              ],
            ),
          ),
        ]);
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
      ErrorService.snackBar(_?.toString());
    }
  }
}
