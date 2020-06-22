import 'package:flutter/material.dart';

class ValueDisplayer extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final Widget valueWidget;
  final MainAxisAlignment mainAxisAlignment;

  ValueDisplayer({
    this.value,
    this.label,
    this.valueColor,
    this.valueWidget,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${label.toUpperCase()}",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 20),
          Container(
            child:
                valueWidget ?? Text(value, style: TextStyle(color: valueColor)),
          ),
        ],
      ),
    );
  }
}
