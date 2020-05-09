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
    return Row(
      children: [
        _tree(height),
        divider(),
        _key(height, i10n),
        divider(),
        _lang(height, projectModel.defaultLocale, i10n.project_default_locale),
        divider(),
        if (projectModel.locales?.length > 1) ..._editLocale(height, projectModel.locales[1], projectModel.locales[1]),
      ],
    );
  }

  List<Widget> _editLocale(double height, String title, String locale) {
    return [
      _lang(height, locale, title),
      divider(),
      _langAuto(height, locale, 'Auto to $locale'),
      divider(),
    ];
  }

  Container _tree(double height) {
    return Container(
      height: height,
      color: Colors.grey,
      child: Column(
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
          ),
        ],
      ),
    );
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

  Container _key(double height, S i10n) {
    var size = ContextService().deviceSize;
    return Container(
      height: height,
      color: Colors.grey.withOpacity(0.1),
      child: Container(
        height: size.height,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(i10n.project_key),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  var key = projectModel.keys[index];
                  return TextFormField(
                    initialValue: key.value ?? '',
                    onChanged: (value) {
                      setState(() {
                        key = key.copyWith(value: value.toString());
                      });
                    },
                  );
                },
                itemCount: projectModel.keys?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _lang(double height, String locale, String title) {
    var size = ContextService().deviceSize;
    return Container(
      height: height,
      color: Colors.grey.withOpacity(0.2),
      child: Container(
        height: size.height,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
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
                },
                itemCount: projectModel.keys?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _langAuto(double height, String locale, String title) {
    var size = ContextService().deviceSize;
    return Container(
      height: height,
      color: Colors.grey.withOpacity(0.2),
      child: Container(
        height: size.height,
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final key = projectModel.keys[index];
                  final newkey = '${key.id}${projectModel.defaultLocale}';
                  var word = projectModel.wordMap[newkey] ?? WordModel(id: Uuid().v4(), keyId: key.id, locale: projectModel.defaultLocale);
                  return _translate(word.value, locale);
                },
                itemCount: projectModel.keys?.length ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
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
