import 'package:doppio_dev_ixn/generated/l10n.dart';
import 'package:doppio_dev_ixn/service/context_service.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:doppio_dev_ixn/widget/index.dart';
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

  Function() get addKey => ProjectScreenState.addKey;
  Function() get save => ProjectScreenState.save;

  Function(Map<String, Map<String, String>> filesData) get import => ProjectScreenState.import;
}

class ProjectScreenState extends State<ProjectScreen> {
  ProjectModel projectModel;
  ScrollController scrollController = ScrollController();

  final translator = GoogleTranslator();

  static void Function() addKey;
  static void Function() save;
  static void Function(Map<String, Map<String, String>> filesData) import;

  String selectedLocale;

  int currentVersionState;

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
            if (projectModel == null) {
              projectModel = currentState.project.copyWith();
              currentVersionState = currentState.version;
              selectedLocale = projectModel.defaultLocale;
              addKey = _addKey;
              save = () {
                widget._projectBloc.add(SaveProjectEvent(projectModel));
              };
              import = _import;
            }
            // change setting
            if (currentVersionState != currentState.version) {
              currentVersionState = currentState.version;
              final pr = currentState.project;
              projectModel = projectModel.copySettings(
                defaultLocale: pr.defaultLocale,
                locales: pr.locales,
                name: pr.name,
              );
              if (!projectModel.locales.contains(selectedLocale)) {
                selectedLocale = projectModel.defaultLocale;
              }
            }
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
    final count = 11;
    final countD = 5;
    final widthD = 10;
    final widthXl = (size.width - countD * widthD) / count * 3;

    final i10n = TranslateService().locale;
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(i10n, widthXl),
          _body(i10n, widthXl),
        ],
      ),
    );
  }

  Expanded _body(S i10n, double widthXl) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Flexible(
                child: _tree(index: index),
                flex: 1,
                fit: FlexFit.tight,
              ),
              divider(),
              Flexible(
                child: EditKey(projectModel: projectModel, index: index, render: renderUpdate),
                flex: 1,
                fit: FlexFit.tight,
              ),
              divider(),
              Flexible(
                child: EditLangWord(
                    projectModel: projectModel,
                    locale: projectModel.defaultLocale,
                    title: i10n.project_default_locale,
                    index: index,
                    render: renderUpdate),
                flex: 3,
                fit: FlexFit.tight,
              ),
              divider(),
              if (projectModel?.locales != null && projectModel.locales.isNotEmpty) ..._editLocale(selectedLocale, selectedLocale, index, widthXl),
            ],
          );
        },
        itemCount: projectModel.keys?.length ?? 0,
      ),
    );
  }

  void renderUpdate() {
    setState(() {});
  }

  Row _header(S i10n, double widthXl) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: _tree(),
          flex: 1,
          fit: FlexFit.tight,
        ),
        divider(),
        Flexible(
          child: Text(i10n.project_key),
          flex: 1,
          fit: FlexFit.tight,
        ),
        divider(),
        Flexible(
          child: Text(i10n.project_default_locale),
          flex: 3,
          fit: FlexFit.tight,
        ),
        divider(),
        if (projectModel?.locales != null && projectModel.locales.isNotEmpty) ...[
          Flexible(
            child: Container(
              width: 100,
              child: LangDropdownWidget(
                options: projectModel.locales,
                labelText: i10n.project_default_locale,
                selectedValue: selectedLocale,
                // TODO: remove, how?!
                width: widthXl - 24,
                select: (newValue) {
                  setState(() {
                    selectedLocale = newValue?.toString();
                  });
                },
              ),
            ),
            flex: 3,
            fit: FlexFit.tight,
          ),
          divider(),
          Flexible(
            child: Text('auto $selectedLocale'),
            flex: 3,
            fit: FlexFit.tight,
          ),
          divider(),
        ],
      ],
    );
  }

  List<Widget> _editLocale(String title, String locale, int index, double width) {
    return [
      Flexible(
        child: EditLangWord(
          projectModel: projectModel,
          locale: locale,
          title: title,
          index: index,
          render: renderUpdate,
        ),
        flex: 3,
        fit: FlexFit.tight,
      ),
      divider(),
      Flexible(
        child: _langAuto(locale, index, width),
        flex: 3,
        fit: FlexFit.tight,
      ),
      divider(),
    ];
  }

  Widget _tree({int index}) {
    if (index == null) {
      return Column(
        children: [
          Text('tree'),
        ],
      );
    }
    return Container();
  }

  void _addKey() {
    setState(() {
      var newKeys = projectModel.keys ?? [];
      newKeys.add(KeyModel(id: Uuid().v4()));
    });
  }

  Widget _langAuto(String locale, int index, double width) {
    final key = projectModel.keys[index];
    final newkey = '${key.id}$locale';
    var word = projectModel.wordMap[newkey] ?? WordModel(id: Uuid().v4(), keyId: key.id, locale: projectModel.defaultLocale);
    // TODO: remove width
    return TranslateWord(translator: translator, text: word.value, toLocale: locale, key: Key('${newkey}_auto'), width: width);
  }

  Future<void> _load([bool isError = false]) async {
    final args = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    if (args == null) {
      print('args==null');
    }
    final id = args['id'] as String;
    widget._projectBloc.add(LoadProjectEvent(id));
  }

  void _import(Map<String, Map<String, String>> filesData) {
    for (var locale in filesData.keys) {
      setState(() {
        projectModel.import(locale, filesData[locale]);
      });
    }
  }
}
