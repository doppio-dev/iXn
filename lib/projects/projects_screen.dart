import 'package:doppio_dev_ixn/main.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/context_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:uuid/uuid.dart';
import 'package:pedantic/pedantic.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({
    Key key,
    @required ProjectsBloc projectsBloc,
  })  : _projectsBloc = projectsBloc,
        super(key: key);

  final ProjectsBloc _projectsBloc;

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
        bloc: widget._projectsBloc,
        builder: (
          BuildContext context,
          ProjectsState currentState,
        ) {
          ContextService().buidlContext(context);
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
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: _load,
                  ),
                ),
              ],
            ));
          }
          if (currentState is InProjectsState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  RaisedButton(
                    onPressed: () {
                      widget._projectsBloc.add(AddProjectsEvent(projectModel: ProjectModel(id: Uuid().v4())));
                    },
                    child: Text('add'),
                  ),
                  ...currentState.projects
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                                onTap: () {
                                  unawaited(navigatorKey.currentState.pushNamed(ProjectPage.routeName, arguments: {'id': e.id}));
                                },
                                child: Text(e.name ?? e.id ?? 'not set')),
                          ))
                      .toList(),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._projectsBloc.add(LoadProjectsEvent());
  }
}
