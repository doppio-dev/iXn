import 'package:doppio_dev_ixn/generated/l10n.dart';
import 'package:doppio_dev_ixn/service/context_service.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:uuid/uuid.dart';
import 'package:translator/translator.dart';

class ProjectScreen extends StatefulWidget {
  ProjectScreen({
    Key key,
    @required ProjectBloc projectBloc,
  })  : _projectBloc = projectBloc,
        super(key: key);

  final ProjectBloc _projectBloc;

  @override
  ProjectScreenState createState() {
    return ProjectScreenState();
  }
}

class ProjectScreenState extends State<ProjectScreen> {
  ProjectModel projectModel;
  ScrollController scrollController = ScrollController();

  final translator = GoogleTranslator();

  ProjectScreenState();
  bool changeSettings;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
        bloc: widget._projectBloc,
        builder: (
          BuildContext context,
          ProjectState currentState,
        ) {
          ContextService().buidlContext(context);
          if (currentState is UnProjectState) {
            _load();
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorProjectState) {
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
          if (currentState is InProjectState) {
            projectModel ??= currentState.project.copyWith();
            return SingleChildScrollView(
              child: mainEditor(currentState),
              controller: scrollController,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget divider() {
    return Container(width: 10);
  }

  Widget mainEditor(InProjectState currentState) {
    var size = ContextService().deviceSize;
    final i10n = TranslateService().locale;
    final height = size.height - 56;
    return Container(
      height: height,
      color: Colors.grey.withOpacity(0.2),
      child: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _width(_tree(), 100),
                divider(),
                _width(Text(i10n.project_key), 100),
                divider(),
                _width(Text(i10n.project_default_locale), 100),
                divider(),
                if (projectModel?.locales != null && projectModel.locales.length > 1)
                  Row(
                    children: [
                      _width(Text(projectModel.locales[1]), 100),
                      _width(Text('auto ${projectModel.locales[1]}'), 100),
                    ],
                  ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  var key = projectModel.keys[index];
                  return Row(
                    children: [
                      _width(_tree(index: index), 100),
                      divider(),
                      _width(_key(i10n, index), 100),
                      divider(),
                      _width(_lang(projectModel.defaultLocale, i10n.project_default_locale, index), 100),
                      divider(),
                      if (projectModel?.locales != null && projectModel.locales.length > 1)
                        ..._editLocale(100, projectModel.locales[1], projectModel.locales[1], index),
                    ],
                  );
                },
                itemCount: projectModel.keys?.length ?? 0,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _editLocale(double width, String title, String locale, int index) {
    return [
      _width(_lang(locale, title, index), width),
      divider(),
      _width(_langAuto(locale, index), width),
      divider(),
    ];
  }

  Widget _width(Widget child, double width) {
    return Container(width: width, child: child);
  }

  Widget _tree({int index}) {
    if (index == null) {
      return Column(
        children: [
          Text('tree'),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                var newKeys = projectModel.keys ?? [];
                newKeys.add(KeyModel(id: Uuid().v4()));
              });
            },
          )
        ],
      );
    }
    return Text('test');
  }

  Widget _translate(String text, String toLocale) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
          return Container();
        }
        return TextFormField(
          controller: TextEditingController(text: snapshot.data?.toString() ?? ''),
          enabled: false,
        );
      },
      future: text == null || text == '' ? Future.value('') : translator.translate(text, to: toLocale),
    );
  }

  Widget _key(S i10n, int index) {
    var key = projectModel.keys[index];
    return TextFormField(
      initialValue: key.value ?? '',
      onChanged: (value) {
        setState(() {
          key = key.copyWith(value: value.toString());
        });
      },
    );
  }

  Widget _lang(String locale, String title, int index) {
    final key = projectModel.keys[index];
    final newkey = '${key.id}$locale';
    var word = projectModel.wordMap[newkey] ?? WordModel(id: Uuid().v4(), keyId: key.id, locale: locale);
    return TextFormField(
      initialValue: word.value ?? '',
      onChanged: (value) {
        setState(() {
          word = word.copyWith(value: value);
          projectModel.wordMap[newkey] = word;
        });
      },
    );
  }

  Widget _langAuto(String locale, int index) {
    final key = projectModel.keys[index];
    final newkey = '${key.id}${projectModel.defaultLocale}';
    var word = projectModel.wordMap[newkey] ?? WordModel(id: Uuid().v4(), keyId: key.id, locale: projectModel.defaultLocale);
    return _translate(word.value, locale);
  }

  Future<void> _load([bool isError = false]) async {
    final args = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    if (args == null) {
      print('args==null');
    }
    final id = args['id'] as String;
    widget._projectBloc.add(LoadProjectEvent(id));
  }
}
