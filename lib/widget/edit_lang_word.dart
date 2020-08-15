import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:doppio_dev_ixn/core/index.dart';
import 'package:doppio_dev_ixn/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditLangWord extends StatefulWidget {
  const EditLangWord({
    Key key,
    @required this.projectModel,
    @required this.locale,
    @required this.title,
    @required this.index,
    this.render,
  }) : super(key: key);

  final ProjectModel projectModel;
  final LocaleModel locale;
  final String title;
  final int index;
  final void Function() render;
  @override
  _EditLangWordState createState() => _EditLangWordState();
}

class _EditLangWordState extends State<EditLangWord> {
  TextEditingController controller;
  void Function() notif;
  @override
  Widget build(BuildContext context) {
    final i10n = TranslateService().locale;
    final key = widget.projectModel.keys[widget.index];
    final newkey = '${key.id}${widget.locale?.key}';
    final keyOrigin = '${key.id}${widget.projectModel.defaultLocale.key}';
    var word = widget.projectModel.getWord(newkey, key, widget.locale);
    var wordOrigin = widget.projectModel.getWord(keyOrigin, key, widget.projectModel.defaultLocale);
    var colorDescription = Colors.transparent;
    String description;
    if (word.origin != wordOrigin.value && widget.locale != widget.projectModel.defaultLocale) {
      if (word.origin == null) {
        if (!word.value.isNullOrEmpty()) {
          colorDescription = Colors.yellow.withOpacity(0.2);
          description = i10n.edit_lang_approve;
          notif = () {
            setState(() {
              word.origin = wordOrigin.value;
            });
            widget?.render();
          };
        }
      } else {
        colorDescription = Colors.pink.withOpacity(0.2);
        description = i10n.edit_lang_changed;
      }
    }

    if (controller == null || controller.text != word.value) {
      controller = TextEditingController(text: word.value);
    }
    final sizeIcon = 8.0;
    return LayoutBuilder(
      builder: (BuildContext c, BoxConstraints b) {
        return TransformOnHover(
          key: Key('${newkey}_on_hover'),
          child: Container(width: b.maxWidth, child: _editor(newkey, description, word, wordOrigin, colorDescription)),
          childHover: Row(
            children: [
              Container(
                width: b.maxWidth - sizeIcon,
                color: colorDescription,
                child: _editor(newkey, description, word, wordOrigin, colorDescription),
              ),
              Container(
                height: 40,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: word.value));
                      },
                      child: Tooltip(
                        message: i10n.edit_lang_copy,
                        child: Icon(
                          Icons.content_copy,
                          size: sizeIcon,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final value = await Clipboard.getData('text/plain');
                        _change(word, value?.text, wordOrigin, newkey);
                      },
                      child: Tooltip(
                        message: i10n.edit_lang_paste,
                        child: Icon(
                          Icons.content_paste,
                          size: sizeIcon,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _editor(String newkey, String description, WordModel word, WordModel wordOrigin, Color colorDescription) {
    if (newkey == '4e667922-b5d1-42a4-9ec2-2970831f0f7dru-RU') {
      print('word=${word.value}');
    }
    return Container(
      key: Key('${newkey}_container'),
      color: colorDescription,
      child: TextFormField(
        key: Key('${newkey}_edit'),
        onTap: () {
          if (description != null) {
            NotificationService.showQuestion(description, notif);
          }
        },
        controller: controller,
        maxLines: null,
        onChanged: (value) {
          _change(word, value, wordOrigin, newkey);
        },
      ),
    );
  }

  void _change(WordModel word, String value, WordModel wordOrigin, String newkey) {
    setState(() {
      word.value = value;
      word.origin = wordOrigin.value;
      widget.projectModel.wordMap[newkey] = word;
    });
    if (widget.render != null) {
      widget.render();
    }
  }
}
