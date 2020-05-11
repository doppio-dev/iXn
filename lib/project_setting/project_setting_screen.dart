import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:doppio_dev_ixn/core/index.dart';
import 'package:doppio_dev_ixn/widget/index.dart';
import 'package:doppio_dev_ixn/widget/lang_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/project_setting/index.dart';

class ProjectSettingScreen extends StatefulWidget {
  const ProjectSettingScreen({
    Key key,
    @required ProjectSettingBloc projectSettingBloc,
    @required this.autoValidate,
    @required this.formKey,
    @required this.projectModel,
  })  : _projectSettingBloc = projectSettingBloc,
        super(key: key);

  final ProjectSettingBloc _projectSettingBloc;
  final bool autoValidate;
  final GlobalKey<FormState> formKey;
  final ProjectModel projectModel;

  @override
  ProjectSettingScreenState createState() {
    return ProjectSettingScreenState();
  }
}

class ProjectSettingScreenState extends State<ProjectSettingScreen> {
  ProjectSettingScreenState();
  final i10n = TranslateService().locale;
  List<LocaleModel> locales;

  @override
  void initState() {
    locales = [];
    for (final key in TranslateService.countryName2Code.keys) {
      final split = TranslateService.countryName2Code[key].split('-');
      locales.add(LocaleModel(countryName: key, locale: split[0], countryCode: split[1]));
    }
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
          final i10n = TranslateService().locale;
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
                Text(currentState.errorMessage ?? i10n.error_error),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(i10n.error_reload),
                    onPressed: () {
                      _load(context);
                    },
                  ),
                ),
              ],
            ));
          }
          if (currentState is InProjectSettingState) {
            return _settings(currentState);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  TextEditingController textEditingController;
  String filter;

  Widget _settings(InProjectSettingState currentState) {
    final i10n = TranslateService().locale;
    final textTheme = ContextService().textTheme;
    if (textEditingController == null || textEditingController.text != widget.projectModel.name) {
      textEditingController = TextEditingController(text: widget.projectModel.name);
    }
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        autovalidate: widget.autoValidate,
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: i10n.project_name),
              controller: textEditingController,
              onChanged: (value) {
                setState(() {
                  widget.projectModel.name = value;
                });
              },
            ),
            LangDropdownWidget(
              options: locales,
              labelText: i10n.project_default_locale,
              selectedValue: widget.projectModel.defaultLocale,
              select: (newValue) {
                setState(() {
                  var newLocale = LocaleModel.from(MapEntry(newValue?.toString(), TranslateService.countryName2Code[newValue?.toString()]));
                  widget.projectModel.defaultLocale = newLocale;
                  if (!widget.projectModel.locales.contains(newLocale)) {
                    widget.projectModel.locales.add(newLocale);
                  }
                });
              },
            ),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      i10n.project_setting_export,
                      style: textTheme.caption,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        widget.projectModel.formats ??= [];
                        var ext = 'json';
                        var prefix = '';
                        var divider = '-';
                        if (widget.projectModel.formats.length == 1) {
                          ext = 'arb';
                          prefix = 'intl_';
                          divider = '_';
                        }
                        setState(() {
                          widget.projectModel.formats.add(ExportFormatModel(fileExtension: ext, prefix: prefix, divider: divider));
                        });
                      },
                    ),
                  ],
                ),
                if (widget.projectModel.formats == null || widget.projectModel.formats.isEmpty)
                  Container(width: ContextService().deviceSize.width, height: 80, child: Empty(text: i10n.project_setting_export_empty)),
                if (widget.projectModel.formats != null)
                  ...widget.projectModel.formats.map(
                    (e) => Container(
                      width: ContextService().deviceSize.width,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              initialValue: e.prefix ?? '',
                              decoration: InputDecoration(labelText: i10n.project_setting_prefix),
                              onChanged: (value) {
                                setState(() {
                                  e.prefix = value;
                                });
                              },
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                initialValue: e.divider ?? '',
                                decoration: InputDecoration(labelText: i10n.project_setting_divider),
                                onChanged: (value) {
                                  setState(() {
                                    e.divider = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: TextFormField(
                                initialValue: e.postfix ?? '',
                                decoration: InputDecoration(labelText: i10n.project_setting_postfix),
                                onChanged: (value) {
                                  setState(() {
                                    e.postfix = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextFormField(
                              initialValue: e.fileExtension ?? '',
                              decoration: InputDecoration(labelText: i10n.project_setting_ext),
                              onChanged: (value) {
                                setState(() {
                                  e.fileExtension = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                              ),
                              onPressed: () {
                                setState(() {
                                  widget.projectModel.formats.remove(e);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(labelText: i10n.project_setting_filter),
                onChanged: (value) {
                  setState(() {
                    filter = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: Text(
                i10n.projects_card_locales,
                style: textTheme.caption,
              ),
            ),
            _buildTargetLocales(),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetLocales() {
    final filtered =
        filter.isNullOrEmpty() ? locales : locales.where((element) => element.toString().toLowerCase().contains(filter.toLowerCase())).toList();
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ContextService().theme.dividerColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final code = filtered[index];
            return Row(
              children: [
                Checkbox(
                  onChanged: widget.projectModel.defaultLocale == code
                      ? null
                      : (bool value) {
                          setState(() {
                            print(value);
                            var newLocales = widget.projectModel.locales;
                            if (value == true) {
                              newLocales = widget.projectModel.locales..add(code);
                            }
                            if (value == false) {
                              newLocales = widget.projectModel.locales..remove(code);
                            }
                            widget.projectModel.locales = newLocales;
                          });
                        },
                  value: widget.projectModel.defaultLocale == code || widget.projectModel.locales.contains(code),
                ),
                Expanded(
                  child: Text(
                    '$code',
                    overflow: TextOverflow.clip,
                  ),
                )
              ],
            );
          },
          itemCount: filtered.length,
        ),
      ),
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
