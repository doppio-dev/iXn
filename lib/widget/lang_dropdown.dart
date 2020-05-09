import 'package:doppio_dev_ixn/service/translate_service.dart';
import 'package:flutter/material.dart';

class LangDropdownWidget extends StatefulWidget {
  final List<String> options;
  final bool valueRequired;
  final String labelText;
  final Function(String value) select;

  String selectedValue;

  LangDropdownWidget({Key key, this.options, this.valueRequired = false, this.labelText, this.select, this.selectedValue}) : super(key: key);

  @override
  _LangDropdownWidgetState createState() => _LangDropdownWidgetState();
}

class _LangDropdownWidgetState extends State<LangDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (String value) {
        if (widget.valueRequired && value == null) {
          return 'value required';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(labelText: widget.labelText),
          isEmpty: widget.selectedValue == null || widget.selectedValue.isEmpty,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selectedValue,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  widget.selectedValue = newValue;
                });
                widget.select(newValue);
                FocusScope.of(context).focusInDirection(TraversalDirection.down);
              },
              items: widget.options.map((String _code) {
                return DropdownMenuItem<String>(
                  value: _code,
                  child: Text(
                    '$_code - ${TranslateService.localesCountry[_code]}',
                    overflow: TextOverflow.clip,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}