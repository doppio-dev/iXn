import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/projects/index.dart';
import 'package:doppio_dev_ixn/service/context_service.dart';
import 'package:doppio_dev_ixn/service/translate_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doppio_dev_ixn/app/index.dart';
import 'package:doppio_dev_ixn/generated/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:doppio_dev_ixn/main.dart';

class AppPage extends StatefulWidget {
  static const String routeName = '/app';

  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with WidgetsBindingObserver {
  final _appBloc = AppBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (_appBloc.state is UnAppState) {
      _load();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    _appBloc.add(ChangeThemeAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      bloc: _appBloc,
      builder: (
        BuildContext context,
        AppState currentState,
      ) {
        final brightness = WidgetsBinding.instance.window.platformBrightness;
        final theme = ThemeData(
          primaryColor: brightness == Brightness.dark ? Colors.black : Colors.white,
          accentColor: brightness == Brightness.dark ? Colors.white : Colors.black,
          brightness: brightness == Brightness.dark ? Brightness.dark : Brightness.light,
          // fontFamily: 'OpenSans'
        );
        return MaterialApp(
          navigatorKey: navigatorKey,
          key: const Key('MaterialApp'),
          localizationsDelegates: <LocalizationsDelegate<dynamic>>[
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: theme,
          home: StreamBuilder<Object>(
              stream: null,
              builder: (contextHome, snapshot) {
                ContextService().buidlContext(contextHome);
                TranslateService().update(contextHome);
                return ProjectsPage();
              }),
          routes: _routes(),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routes() {
    return <String, WidgetBuilder>{
      '': (BuildContext context) => AppPage(),
      ProjectsPage.routeName: (BuildContext context) => ProjectsPage(),
      ProjectPage.routeName: (BuildContext context) => ProjectPage(),
    };
  }

  void _load() {
    _appBloc.add(LoadAppEvent());
  }
}
