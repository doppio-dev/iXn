import 'package:doppio_dev_ixn/core/logger.dart';
import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dropdownfield/dropdownfield.dart';

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
}

class ProjectSettingScreenState extends State<ProjectSettingScreen> {
  ProjectModel projectModel;

  ProjectSettingScreenState();

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
            projectModel ??= currentState.project.copyWith();
            return _settings(currentState);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _settings(InProjectSettingState currentState) {
    final i10n = TranslateService().locale;
    final locales = kMaterialSupportedLanguages.toList();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: ContextService().deviceSize.height - 104,
          width: ContextService().deviceSize.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(labelText: i10n.project_name),
                  initialValue: projectModel.name,
                  onChanged: (value) {
                    setState(() {
                      projectModel = projectModel.copyWith(name: value);
                    });
                  },
                ),
              ),
              // https://www.iana.org/assignments/language-subtag-registry/language-subtag-registry
              // https://api.flutter.dev/flutter/flutter_localizations/kMaterialSupportedLanguages.html
              // var countryLocale = Locale.fromSubtags(countryCode: value);
              // print(GlobalMaterialLocalizations.delegate.isSupported(countryLocale));
              DropDownField(
                value: projectModel.defaultLocale,
                required: true,
                strict: true,
                labelText: i10n.project_default_locale,
                textStyle: ContextService().textTheme.bodyText1,
                items: locales,
                onValueChanged: (newValue) {
                  print(newValue);
                  setState(
                    () {
                      projectModel =
                          projectModel.copyWith(defaultLocale: newValue?.toString(), locales: projectModel.locales..add(newValue.toString()));
                    },
                  );
                },
              ),

              DropDownField(
                value: projectModel.yourLocale,
                required: false,
                strict: true,
                labelText: i10n.project_your_locale,
                textStyle: ContextService().textTheme.bodyText1,
                items: locales,
                onValueChanged: (newValue) {
                  print(newValue);
                  setState(
                    () {
                      projectModel = projectModel.copyWith(yourLocale: newValue?.toString(), locales: projectModel.locales..add(newValue.toString()));
                    },
                  );
                },
              ),
              Expanded(
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
              )
            ],
          ),
        ),
        RaisedButton(
          onPressed: currentState.project == projectModel
              ? null
              : () {
                  widget._projectSettingBloc.add(SaveProjectSettingEvent(projectModel));
                },
          child: Text('save'),
        )
      ],
    );
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
