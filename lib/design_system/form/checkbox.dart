import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox(this.icon,
      {Key key,
        @required this.onSelect,
        this.height,
        this.width})
      : super(key: key);

  final IconData icon;
  final ValueChanged<bool> onSelect;
  final double height;
  final double width;

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool _selected = false;

  void _onTap() {
    setState(() {
      _selected = !_selected;
    });

    widget.onSelect(_selected);
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = _selected
        ? Color.fromARGB(255, 5, 82, 136)
        : Colors.white
    ;
    Color borderColor = _selected
        ? Color.fromARGB(255, 5, 82, 136)
        : Color.fromARGB(35, 5, 82, 136)
    ;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          width: 2,
          color: borderColor
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0)
        ),
      ),
      width: widget.width == null ? 100 : widget.width,
      height: widget.height == null ? 100 : widget.height,
      child: IconButton(
        padding: EdgeInsets.all(0),
        alignment: Alignment.center,
        icon: Icon(
          widget.icon,
          size: _selected ? 15 : 0,
          color: Colors.white,
        ),
        onPressed: () {
          _onTap();
        },
      ),
    );
  }
}