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
          print('BlocBulder');
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
    final widthSm = (size.width - countD * widthD) / count;
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _width(_tree(), widthSm),
              divider(),
              _width(Text(i10n.project_key), widthSm),
              divider(),
              _width(Text(i10n.project_default_locale), widthXl),
              divider(),
              if (projectModel?.locales != null && projectModel.locales.length > 1)
                Row(
                  children: [
                    _width(
                        LangDropdownWidget(
                          options: projectModel.locales,
                          labelText: i10n.project_default_locale,
                          selectedValue: selectedLocale,
                          width: widthXl - 24,
                          select: (newValue) {
                            setState(() {
                              selectedLocale = newValue?.toString();
                            });
                          },
                        ),
                        widthXl),
                    divider(),
                    _width(Text('auto $selectedLocale'), widthXl),
                    divider(),
                  ],
                ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (context, index) {
                // var key = projectModel.keys[index];
                return Row(
                  children: [
                    _width(_tree(index: index), widthSm),
                    divider(),
                    _width(_key(i10n, index), widthSm),
                    divider(),
                    _width(_lang(projectModel.defaultLocale, i10n.project_default_locale, index), widthXl),
                    divider(),
                    if (projectModel?.locales != null && projectModel.locales.isNotEmpty)
                      ..._editLocale(widthXl, selectedLocale, selectedLocale, index),
                  ],
                );
              },
              itemCount: projectModel.keys?.length ?? 0,
            ),
          )
        ],
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

  Widget _translate(String text, String toLocale) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none && snapshot.hasData == null) {
          return Container();
        }
        if (snapshot.error != null) {
          return Text(snapshot.error.toString());
        }
        return TextFormField(
          controller: TextEditingController(text: snapshot.data?.toString() ?? ''),
          maxLines: null,
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
      key: Key(newkey),
      initialValue: word?.value ?? '',
      maxLines: null,
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
    final newkey = '${key.id}$locale';
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

  void _import(Map<String, Map<String, String>> filesData) {
    for (var locale in filesData.keys) {
      setState(() {
        projectModel.import(locale, filesData[locale]);
      });
    }
  }
}
