import 'package:bot_toast/bot_toast.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationService {
  static void showError(String error) {
    BotToast.showNotification(duration: Duration(seconds: 7), onTap: () {}, title: (_) => Text(error));
  }

  static void showInfo(String text, {Duration duration}) {
    BotToast.showNotification(duration: duration ?? Duration(seconds: 3), onTap: () {}, title: (_) => Text(text));
  }

  static void showQuestion(String message, Function onDone) {
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
                child: ElevatedButton(
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

  static void showUpdate() {
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
                child: Text(TranslateService().locale.notif_need_update),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    cancelFunc();
                    final url = 'https://github.com/doppio-dev/iXn/releases';
                    if (await canLaunch(url)) {
                      await launch(url);
                    }
                  },
                  child: Text(TranslateService().locale.notif_update),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
