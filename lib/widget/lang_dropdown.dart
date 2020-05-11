import 'package:doppio_dev_ixn/project/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';
import 'package:flutter/material.dart';

class LangDropdownWidget extends StatefulWidget {
  final List<LocaleModel> options;
  final bool valueRequired;
  final String labelText;
  final Function(String value) select;

  final LocaleModel selectedValue;
  final double width;

  LangDropdownWidget({Key key, this.options, this.valueRequired = false, this.labelText, this.select, this.selectedValue, this.width})
      : super(key: key);

  @override
  _LangDropdownWidgetState createState() => _LangDropdownWidgetState();
}

class _LangDropdownWidgetState extends State<LangDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (String value) {
        if (widget.valueRequired && value == null) {
          return TranslateService().locale.value_required;
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(labelText: widget.labelText),
          isEmpty: widget.selectedValue == null,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selectedValue?.countryName,
              isDense: true,
              onChanged: (String newValue) {
                setState(() {
                  widget.select(newValue);
                });
                // FocusScope.of(context).focusInDirection(TraversalDirection.down);
              },
              items: widget.options.map((LocaleModel _code) {
                return DropdownMenuItem<String>(
                  value: _code.countryName,
                  child: Container(
                    width: widget.width,
                    child: Text(
                      '$_code',
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      softWrap: true,
                    ),
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
