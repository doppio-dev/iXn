import 'package:doppio_dev_ixn/core/index.dart';
import 'package:doppio_dev_ixn/generated/l10n.dart';
import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';
import 'package:uuid/uuid.dart';

class ProjectPage extends StatefulWidget {
  static const String routeName = '/project';

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _projectBloc = ProjectBloc();
  ProjectModel projectModel;
  int currentVersionState;

  ProjectScreen projectScreen;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _projectBloc.close();
    super.dispose();
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
        if (currentState is InProjectState) {
          if (projectModel == null) {
            projectModel = currentState.project.copyWith();
            currentVersionState = currentState.version;
          }

          // change setting
          if (currentVersionState != currentState.version) {
            currentVersionState = currentState.version;
            final pr = currentState.project;
            projectModel = projectModel.copySettings(
              defaultLocale: pr.defaultLocale,
              locales: pr.locales,
              name: pr.name,
              formats: pr.formats,
            );
          }
        }
        projectScreen = ProjectScreen(projectBloc: _projectBloc, projectModel: projectModel);
        final i10n = TranslateService().locale;
        final name = projectModel?.name ?? i10n.project_name_no;
        return WillPopScope(
          onWillPop: () => _willPop(currentState as InProjectState),
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  if (!kIsWeb) _addWidget(i10n),
                  Expanded(child: Center(child: Text(i10n.project_name_title(name)))),
                  if (!kIsWeb) ..._actionsWidget(),
                ],
              ),
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
            persistentFooterButtons: kIsWeb
                ? <Widget>[
                    Container(
                      width: ContextService().deviceSize.width,
                      child: Row(
                        children: [
                          _addWidget(i10n),
                          Spacer(),
                          ..._actionsWidget(),
                        ],
                      ),
                    ),
                  ]
                : null,
            body: projectScreen,
          ),
        );
      },
    );
  }

  List<Widget> _actionsWidget() {
    final i10n = TranslateService().locale;
    return [
      IconButton(
        onPressed: () async {
          await projectModel.export();
        },
        tooltip: i10n.project_export,
        icon: Icon(Icons.file_upload),
      ),
      IconButton(
        onPressed: () async {
          await _import();
        },
        tooltip: i10n.project_import,
        icon: Icon(Icons.file_download),
      ),
      IconButton(
        onPressed: () async {
          _projectBloc.add(SaveProjectEvent(projectModel));
        },
        tooltip: i10n.project_save,
        icon: Icon(Icons.save),
      )
    ];
  }

  IconButton _addWidget(S i10n) {
    return IconButton(
      onPressed: projectModel?.defaultLocale == null
          ? null
          : () async {
              _addKey();
            },
      tooltip: i10n.project_add,
      icon: Icon(Icons.add),
    );
  }

  Future<bool> _willPop(InProjectState currentState) async {
    var canPop = currentState.project == projectModel;
    final i10n = TranslateService().locale;
    if (!canPop) {
      await showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(i10n.save_data),
              GestureDetector(child: Icon(Icons.close), onTap: () => navigatorKey.currentState.pop()),
            ],
          ),
          content: Text(i10n.error_unsaved),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _projectBloc.add(SaveProjectEvent(projectModel));
                  navigatorKey.currentState.pop();
                  canPop = true;
                },
                child: Text(i10n.save)),
            FlatButton(
                onPressed: () {
                  navigatorKey.currentState.pop();
                  canPop = true;
                },
                child: Text(i10n.discard)),
          ],
        ),
      );
    }
    return Future.value(canPop);
  }

  Future _import() async {
    try {
      final filesData = await TranslateService().importFiles();
      for (var locale in filesData?.keys ?? <String>[]) {
        var localeCode = TranslateService.countryName2Code.entries.firstWhere((element) => element.value == locale);
        var localeModel = LocaleModel.from(localeCode);
        setState(() {
          projectModel.import(localeModel, filesData[locale]);
        });
      }
    } catch (_, stackTrace) {
      log(_?.toString(), name: 'ProjectsPage', error: _, stackTrace: stackTrace);
      NotificationService.showError(_?.toString());
    }
  }

  void _addKey() {
    setState(() {
      var newKeys = projectModel.keys ?? [];
      newKeys.add(KeyModel(id: Uuid().v4()));
    });
  }
}
