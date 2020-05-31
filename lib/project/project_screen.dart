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
    this.projectModel,
  })  : _projectBloc = projectBloc,
        super(key: key);

  final ProjectBloc _projectBloc;
  final ProjectModel projectModel;
  @override
  ProjectScreenState createState() {
    return ProjectScreenState();
  }
}

class ProjectScreenState extends State<ProjectScreen> {
  ScrollController scrollController = ScrollController();

  final translator = GoogleTranslator();

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
          final i10n = TranslateService().locale;
          if (currentState is ErrorProjectState) {
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
          if (currentState is InProjectState) {
            currentVersionState ??= currentState.version;

            // change setting
            if (currentVersionState != currentState.version) {
              currentVersionState = currentState.version;
              if (!widget.projectModel.locales.contains(widget.projectModel.selectedEditLocale)) {
                widget.projectModel.selectedEditLocale = null;
              }
            }
            return mainEditor(currentState);
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
    final count = 10;
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

  Widget _body(S i10n, double widthXl) {
    final length = widget.projectModel.keys?.length ?? 0;
    if (length == 0) {
      return Expanded(child: Empty(text: i10n.project_empty));
    }
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) {
          return _rowItem(i10n, index, widthXl);
        },
        itemCount: length,
      ),
    );
  }

  Widget _rowItem(S i10n, int index, double widthXl) {
    return Row(
      children: [
        // Flexible(
        //   child: _tree(index: index),
        //   flex: 1,
        //   fit: FlexFit.tight,
        // ),
        divider(),
        Flexible(
          child: EditKey(projectModel: widget.projectModel, index: index, render: renderUpdate),
          flex: 1,
          fit: FlexFit.tight,
        ),
        divider(),
        Flexible(
          child: EditLangWord(
            projectModel: widget.projectModel,
            locale: widget.projectModel.defaultLocale,
            title: i10n.project_default_locale,
            index: index,
          ),
          flex: 3,
          fit: FlexFit.tight,
        ),
        divider(),
        if (widget.projectModel?.locales != null && widget.projectModel.locales.isNotEmpty && widget.projectModel.selectedEditLocale != null)
          ..._editLocale(widget.projectModel.selectedEditLocale.toString(), widget.projectModel.selectedEditLocale, index, widthXl),
      ],
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
        // Flexible(
        //   child: _tree(),
        //   flex: 1,
        //   fit: FlexFit.tight,
        // ),
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
        if (widget.projectModel?.locales != null && widget.projectModel.locales.isNotEmpty) ...[
          Flexible(
            child: Container(
              width: 100,
              child: LangDropdownWidget(
                options: widget.projectModel.locales.where((element) => element != widget.projectModel.defaultLocale).toList(),
                labelText: i10n.project_locale,
                selectedValue: widget.projectModel.selectedEditLocale,
                // TODO: remove, how?!
                width: widthXl - 24,
                select: (newValue) {
                  var newLocale = LocaleModel.from(MapEntry(newValue?.toString(), TranslateService.countryName2Code[newValue?.toString()]));
                  setState(() {
                    widget.projectModel.selectedEditLocale = newLocale;
                  });
                },
              ),
            ),
            flex: 3,
            fit: FlexFit.tight,
          ),
          divider(),
          Flexible(
            child: Text('auto ${widget.projectModel.selectedEditLocale}'),
            flex: 3,
            fit: FlexFit.tight,
          ),
          divider(),
        ],
      ],
    );
  }

  List<Widget> _editLocale(String title, LocaleModel locale, int index, double width) {
    return [
      Flexible(
        child: EditLangWord(
          projectModel: widget.projectModel,
          locale: locale,
          title: title,
          index: index,
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

  Widget _langAuto(LocaleModel locale, int index, double width) {
    final key = widget.projectModel.keys[index];
    final newkey = '${key.id}${widget.projectModel.defaultLocale.key}';
    var word = widget.projectModel.wordMap[newkey] ?? WordModel(id: Uuid().v4(), keyId: key.id, locale: widget.projectModel.defaultLocale);
    // TODO: remove width

    return TranslateWord(translator: translator, text: word.value, toLocale: locale.locale, key: Key('${newkey}_auto'), width: width);
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
