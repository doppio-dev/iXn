import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
// import 'package:file_access/file_access.dart' as file_access;
// import 'package:doppio_dev_ixn/core/index.dart';
// import 'package:doppio_dev_ixn/core/logger.dart';

class ProjectsPage extends StatefulWidget {
  static const String routeName = '/projects';

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final projectsScreen = ProjectsScreen(projectsBloc: ProjectsBloc());
  var showRemove = false;

  @override
  Widget build(BuildContext context) {
    final i10n = TranslateService().locale;
    return Scaffold(
      key: Key('projecs_sc'),
      appBar: AppBar(
        title: Row(
          children: [
            if (!kIsWeb) _actionsWidget(),
            Expanded(child: Center(child: Text(i10n.projects_title))),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LineAwesomeIcons.github),
            onPressed: () async {
              final url = 'https://github.com/doppio-dev/iXn';
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          )
        ],
      ),
      body: projectsScreen,
      persistentFooterButtons: kIsWeb
          ? [
              Container(
                width: ContextService().deviceSize.width,
                child: Row(
                  children: [Expanded(child: _actionsWidget())],
                ),
              ),
            ]
          : null,
    );
  }

  Widget _actionsWidget() {
    final i10n = TranslateService().locale;
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  projectsScreen.projectsBloc.add(AddProjectsEvent(projectModel: ProjectModel(id: Uuid().v4())));
                },
                tooltip: i10n.projects_add,
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () async {
                  showRemove = !showRemove;
                  projectsScreen.projectsBloc.add(ViewProjectsEvent(showRemove: showRemove));
                },
                tooltip: i10n.projects_show_remove,
                icon: Icon(Icons.remove),
              ),
            ],
          ),
          // IconButton(
          //   onPressed: () async {
          // await _import();
          //   },
          //   tooltip: i10n.projects_import,
          //   icon: Icon(Icons.file_download),
          // ),
        ],
      ),
    );
  }

  // Future _import() async {
  //   try {
  //     final newFiles = (await file_access.open(false, false, allowedTypes: ['zip']));
  //     final newFile = newFiles.firstOrDefault;
  //     print(newFile?.path);
  //     // var text = await newFile.readAsString();
  //     // var json = Map<String, String>.from(jsonDecode(text) as Map<dynamic, dynamic>);
  //     // print(json);
  //   } catch (_, stackTrace) {
  //     log(_?.toString(), name: 'ProjectsPage', error: _, stackTrace: stackTrace);
  //     NotificationService.showError(_?.toString());
  //   }
  // }
}
