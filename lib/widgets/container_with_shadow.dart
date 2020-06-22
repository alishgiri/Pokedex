import 'package:flutter/material.dart';

class ContainerWithShadow extends StatelessWidget {
  final Color color;
  final Widget child;
  final bool rounded;
  final double width;
  final double height;
  final Gradient gradient;
  final Color shadowColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double borderWidth;
  final BoxConstraints constraints;
  final BorderRadiusGeometry borderRadius;

  ContainerWithShadow({
    this.width,
    this.child,
    this.height,
    this.gradient,
    this.shadowColor,
    this.constraints,
    this.borderRadius,
    this.borderWidth = 1,
    this.rounded = false,
    this.color = Colors.white,
    this.margin = const EdgeInsets.all(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    final r = height ?? 100;
    return Container(
      width: width,
      child: child,
      height: height,
      margin: margin,
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius:
            borderRadius ?? BorderRadius.circular(rounded ? r * 0.5 : 10),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.1,
            offset: Offset(0, 1),
            color: shadowColor ?? Colors.grey.shade300,
          ),
        ],
      ),
    );
  }
}
