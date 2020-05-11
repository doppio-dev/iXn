import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:doppio_dev_ixn/service/context_service.dart';
import 'package:doppio_dev_ixn/service/translate_service.dart';
import 'package:doppio_dev_ixn/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:pedantic/pedantic.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({
    Key key,
    @required this.projectsBloc,
  }) : super(key: key);

  final ProjectsBloc projectsBloc;

  @override
  ProjectsScreenState createState() {
    return ProjectsScreenState();
  }
}

class ProjectsScreenState extends State<ProjectsScreen> {
  ProjectsScreenState();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
        bloc: widget.projectsBloc,
        builder: (
          BuildContext context,
          ProjectsState currentState,
        ) {
          ContextService().buidlContext(context);
          final i10n = TranslateService().locale;
          if (currentState is UnProjectsState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorProjectsState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? i10n.error_error),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(i10n.error_reload),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InProjectsState) {
            if (currentState.projects == null || currentState.projects.isEmpty) {
              return Empty(text: i10n.projects_emprty);
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  ...currentState.projects.map((p) => card(p, currentState)).toList(),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget card(ProjectModel e, InProjectsState currentState) {
    final i10n = TranslateService().locale;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          unawaited(
            navigatorKey.currentState.pushNamed(
              ProjectPage.routeName,
              arguments: {'id': e.id},
            ),
          );
          if (e.name == null) {
            unawaited(navigatorKey.currentState.pushNamed(
              ProjectSettingPage.routeName,
              arguments: {'id': e.id},
            ));
          }
        },
        child: Card(
          elevation: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${i10n.projects_card_name}: ${e.name}'),
                Text('${i10n.projects_card_locale}: ${e.defaultLocale}'),
                Text('${i10n.projects_card_locales}: ${e.locales}'),
                if (currentState.showRemove == true)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(i10n.projects_remove),
                      onPressed: () {
                        widget.projectsBloc.add(RemoveProjectsEvent(projectModel: e));
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _load() {
    widget.projectsBloc.add(LoadProjectsEvent());
  }
}
