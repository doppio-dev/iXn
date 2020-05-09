import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';

class ProjectSettingPage extends StatefulWidget {
  static const String routeName = '/projectSetting';

  @override
  _ProjectSettingPageState createState() => _ProjectSettingPageState();
}

class _ProjectSettingPageState extends State<ProjectSettingPage> {
  final _projectSettingBloc = ProjectSettingBloc();
  final i10n = TranslateService().locale;

  ProjectSettingScreen screen;
  @override
  void initState() {
    screen = ProjectSettingScreen(projectSettingBloc: _projectSettingBloc);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WillPopScope(
        onWillPop: () => screen.willPop(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(i10n.page_settings),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () => screen.save(),
                tooltip: i10n.save,
              )
            ],
          ),
          body: screen,
        ),
      ),
    );
  }
}
