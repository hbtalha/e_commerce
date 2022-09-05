import 'package:flutter/cupertino.dart';

///check list card
class CheckListCard<T> {
   ///The value for multi select items. it could be String, int or any type.
  ///Also, This will be the value or list of values return onChange
  final T value;

  ///Title of the check list card
  final Widget title;

  ///Gap between checkbox and the title
  final double checkBoxGap;

  ///Selected checkbox color
  final Color? selectedColor;


  ///final [T] value --
  ///The value for multi select items. it could be String, int or any type.
  ///Also, This will be the value or list of values return onChange

  ///final [EdgeInsetsGeometry]? contentPadding --
  ///Content padding

  CheckListCard({
    required this.value,
    EdgeInsets contentPadding = const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    required this.title,
    this.checkBoxGap = 10.0,
    this.selectedColor,
  }) ;
}
