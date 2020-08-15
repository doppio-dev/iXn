import 'package:flutter/material.dart';

class TransformOnHover extends StatefulWidget {
  final Widget child;
  final Widget childHover;
  // You can also pass the translation in here if you want to
  const TransformOnHover({Key key, @required this.child, @required this.childHover}) : super(key: key);
  @override
  _TransformOnHoverState createState() => _TransformOnHoverState();
}

class _TransformOnHoverState extends State<TransformOnHover> {
  bool _hovering = false;
  Widget _widget;

  @override
  void initState() {
    super.initState();
    _widget = _hovering ? widget.childHover : widget.child;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _widget,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
      _widget = _hovering ? widget.childHover : widget.child;
    });
  }
}
