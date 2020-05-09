import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';

class ErrorServiceService {
  static void snackBar(String error) {
    final snackBar = SnackBar(
      content: Text(error),
      duration: Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    Scaffold.of(ContextService().buildContext).showSnackBar(snackBar);
  }
}
