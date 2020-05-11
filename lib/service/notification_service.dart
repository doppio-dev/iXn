import 'package:bot_toast/bot_toast.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static void showError(String error) {
    BotToast.showNotification(duration: Duration(seconds: 7), onTap: () {}, title: (_) => Text(error));
  }

  static void showQuestion(String message, Function onDone) {
    // BotToast.showNotification(
    //   duration: Duration(seconds: 4),
    //   onTap: () {},
    //   title: (_) => Text(message),
    // );
    BotToast.showCustomNotification(
      duration: Duration(seconds: 10),
      onlyOne: true,
      toastBuilder: (cancelFunc) => GestureDetector(
        onTap: () {
          cancelFunc();
        },
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  onPressed: () {
                    cancelFunc();
                    onDone();
                  },
                  child: Text(TranslateService().locale.notif_ok),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
