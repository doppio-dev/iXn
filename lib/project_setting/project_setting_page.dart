import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectSettingPage extends StatefulWidget {
  static const String routeName = '/projectSetting';

  @override
  _ProjectSettingPageState createState() => _ProjectSettingPageState();
}

class _ProjectSettingPageState extends State<ProjectSettingPage> {
  final _projectSettingBloc = ProjectSettingBloc();
  final i10n = TranslateService().locale;
  ProjectModel projectModel;
  ProjectModel projectModelBackup;
  bool backuped;
  bool autoValidate;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'settongs_form');

  ProjectSettingScreen screen;
  @override
  void initState() {
    autoValidate = false;
    backuped = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectSettingBloc, ProjectSettingState>(
      bloc: _projectSettingBloc,
      builder: (
        BuildContext context,
        ProjectSettingState currentState,
      ) {
        ContextService().buidlContext(context);
        if (currentState is InProjectSettingState) {
          projectModel ??= currentState.project.copyWith();
          if (!backuped) {
            projectModelBackup = projectModel == null ? null : projectModel.copyWith();
            backuped = true;
          }
        }
        screen =
            ProjectSettingScreen(projectSettingBloc: _projectSettingBloc, autoValidate: autoValidate, formKey: formKey, projectModel: projectModel);
        return Container(
          child: WillPopScope(
            onWillPop: _willPop,
            child: Scaffold(
              appBar: AppBar(
                title: Text(i10n.page_settings),
                actions: [],
              ),
              persistentFooterButtons: <Widget>[
                Container(
                  width: ContextService().deviceSize.width,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.undo),
                        onPressed: () {
                          setState(() {
                            if (currentState is InProjectSettingState) {
                              projectModel = currentState.project.copyWith();
                              projectModelBackup = projectModel == null ? null : projectModel.copyWith();
                              backuped = true;
                            }
                          });
                        },
                        tooltip: i10n.discard,
                      ),
                      Spacer(),
                      IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: _save,
                        tooltip: i10n.save,
                      ),
                    ],
                  ),
                ),
              ],
              body: screen,
            ),
          ),
        );
      },
    );
  }

  void _save() {
    if (!autoValidate) {
      autoValidate = true;
    }
    if (formKey.currentState.validate()) {
      projectModelBackup = projectModel == null ? null : projectModel.copyWith();
      _projectSettingBloc.add(SaveProjectSettingEvent(projectModel));
    }
  }

  Future<bool> _willPop() async {
    var canPop = projectModelBackup == projectModel;
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
                  _save();
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
}
