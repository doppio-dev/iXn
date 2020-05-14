import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:doppio_dev_ixn/core/index.dart';
import 'package:translator/translator.dart';

class TranslateWord extends StatefulWidget {
  const TranslateWord({
    Key key,
    @required this.translator,
    @required this.text,
    @required this.toLocale,
    this.width,
  }) : super(key: key);

  final GoogleTranslator translator;
  final String text;
  final String toLocale;
  final double width;

  @override
  _TranslateWordState createState() => _TranslateWordState();
}

class _TranslateWordState extends State<TranslateWord> {
  final cache = AutoTranslateCacheManager();
  String translatedText;
  @override
  void initState() {
    super.initState();
    final key = '${widget.toLocale}${widget.text.hashCode}';
    cache.getItemAsync(key).then((value) {
      if (value != null && value.toString().isNullOrEmpty() == false) {
        setState(() {
          translatedText = value.toString();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        GestureDetector(
          onDoubleTap: () {
            Clipboard.setData(ClipboardData(text: translatedText));
            NotificationService.showInfo(TranslateService().locale.notif_clipboard);
          },
          child: Container(
            width: widget.width - 48,
            color: Colors.transparent,
            child: SelectableText(translatedText ?? ''),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            size: 18,
          ),
          onPressed: () async {
            final key = '${widget.toLocale}${widget.text.hashCode}';
            if (widget.text != null && cache.containsKey(key) && key.length < 255) {
              final cached = await cache.getItemAsync(key);
              if (cached != null && cached.toString().isNullOrEmpty() == false) {
                setState(() {
                  translatedText = cached.toString();
                });
                return;
              }
            }
            await Future.delayed(Duration(milliseconds: widget.text.length * 20));
            var newValue = await widget.translator.translate(widget.text, to: widget.toLocale);
            if (newValue == null) {
              NotificationService.showError(TranslateService().locale.translate_429(widget.text));
              return;
            }
            await cache.putAsync(key, newValue);
            setState(() {
              translatedText = newValue;
            });
          },
        ),
      ],
    );
  }
}
