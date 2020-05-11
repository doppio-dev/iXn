import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Empty extends StatelessWidget {
  final String text;
  const Empty({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = ContextService().textTheme;
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(text, textAlign: TextAlign.center, style: textTheme.headline4.copyWith()),
            ),
          ),
        )
      ],
    );
  }
}
