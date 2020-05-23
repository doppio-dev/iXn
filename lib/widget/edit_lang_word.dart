import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:doppio_dev_ixn/core/index.dart';
import 'package:flutter/material.dart';

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
            widget.render();
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
    return Container(
      color: colorDescription,
      child: TextFormField(
        key: Key('${newkey}_${widget.title}_edit'),
        onTap: () {
          if (description != null) {
            NotificationService.showQuestion(description, notif);
          }
        },
        controller: controller,
        maxLines: null,
        onChanged: (value) {
          setState(() {
            word.value = value;
            word.origin = wordOrigin.value;
            widget.projectModel.wordMap[newkey] = word;
          });
          if (widget.render != null) {
            widget.render();
          }
        },
      ),
    );
  }
}
