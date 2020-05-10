import 'package:doppio_dev_ixn/project/index.dart';
import 'package:flutter/material.dart';

class EditKey extends StatefulWidget {
  const EditKey({
    Key key,
    @required this.projectModel,
    @required this.index,
    this.render,
  }) : super(key: key);

  final ProjectModel projectModel;
  final int index;
  final void Function() render;
  @override
  _EditKeyState createState() => _EditKeyState();
}

class _EditKeyState extends State<EditKey> {
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final key = widget.projectModel.keys[widget.index];
    if (controller == null || controller.text != key.value) {
      controller = TextEditingController(text: key.value);
    }
    // controller.selection =
    return Tooltip(
      key: Key('${key.id}_tooltip'),
      message: '',
      child: Container(
        // color: colorDescription,
        child: TextFormField(
          key: Key('${key.id}_edit'),
          controller: controller,
          maxLines: null,
          onChanged: (value) {
            setState(() {
              key.value = value.toString();
            });
            if (widget.render != null) {
              widget.render();
            }
          },
        ),
      ),
    );
  }
}
