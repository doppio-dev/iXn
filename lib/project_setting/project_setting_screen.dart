import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:doppio_dev_ixn/widget/lang_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class ProjectSettingScreen extends StatefulWidget {
  const ProjectSettingScreen({
    Key key,
    @required ProjectSettingBloc projectSettingBloc,
  })  : _projectSettingBloc = projectSettingBloc,
        super(key: key);

  final ProjectSettingBloc _projectSettingBloc;

  @override
  ProjectSettingScreenState createState() {
    return ProjectSettingScreenState();
  }

  Function get save => ProjectSettingScreenState.save;
}

class ProjectSettingScreenState extends State<ProjectSettingScreen> {
  static Function save;

  ProjectModel projectModel;
  bool autoValidate;

  ProjectSettingScreenState();
  final i10n = TranslateService().locale;
  List<String> locales;
  Map<String, String> localesList;

  @override
  void initState() {
    autoValidate = false;
    locales = kMaterialSupportedLanguages.toList();
    locales.sort();
    localesList = {for (var code in locales) code: '$code - ${TranslateService.localesCountry[code]}'};
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectSettingBloc, ProjectSettingState>(
        bloc: widget._projectSettingBloc,
        builder: (
          BuildContext context,
          ProjectSettingState currentState,
        ) {
          ContextService().buidlContext(context);
          if (currentState is UnProjectSettingState) {
            _load(context);
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorProjectSettingState) {
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
                    onPressed: () {
                      _load(context);
                    },
                  ),
                ),
              ],
            ));
          }
          if (currentState is InProjectSettingState) {
            save = _save;
            projectModel ??= currentState.project.copyWith();
            return _settings(currentState);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _settings(InProjectSettingState currentState) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        autovalidate: autoValidate,
        key: Key('settongs_form'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: i10n.project_name),
              initialValue: projectModel.name,
              onChanged: (value) {
                setState(() {
                  projectModel = projectModel.copyWith(name: value);
                });
              },
            ),
            LangDropdownWidget(
              options: locales,
              labelText: i10n.project_default_locale,
              selectedValue: projectModel.defaultLocale,
              select: (newValue) {
                setState(() {
                  projectModel = projectModel.copyWith(defaultLocale: newValue?.toString(), locales: projectModel.locales..add(newValue.toString()));
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Text(
                i10n.projects_card_locales,
                style: ContextService().textTheme.caption,
              ),
            ),
            _buildTargetLocales(),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetLocales() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ContextService().theme.dividerColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final code = locales[index];
            return Row(
              children: [
                Checkbox(
                  onChanged: projectModel.defaultLocale == code
                      ? null
                      : (bool value) {
                          setState(() {
                            print(value);
                            var newLocales = projectModel.locales;
                            if (value == true) {
                              newLocales = projectModel.locales..add(code);
                            }
                            if (value == false) {
                              newLocales = projectModel.locales..remove(code);
                            }
                            projectModel = projectModel.copyWith(locales: newLocales);
                          });
                        },
                  value: projectModel.defaultLocale == code || projectModel.locales.contains(code),
                ),
                Expanded(
                  child: Text(
                    '$code - ${TranslateService.localesCountry[code]}',
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            );
          },
          itemCount: kMaterialSupportedLanguages.length,
        ),
      ),
    );
  }

  void _save() {
    if (!autoValidate) {
      autoValidate = true;
    }
    widget._projectSettingBloc.add(SaveProjectSettingEvent(projectModel));
  }

  void _load(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map<String, Object>;
    if (args == null) {
      print('args==null');
    }
    final id = args['id'] as String;
    widget._projectSettingBloc.add(LoadProjectSettingEvent(id));
  }
}
