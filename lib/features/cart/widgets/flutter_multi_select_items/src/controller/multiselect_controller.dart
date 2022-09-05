import 'package:flutter/foundation.dart';

///  A Controller for multi select. Allows to get all selected items, de select all, select all.
class MultiSelectController<T> {
  List<T> selectedItemsValues = [];

  /// Deselect all selected items
  late VoidCallback deselectAll;

  /// Select all items
  late List<T> Function() selectAll;

  MultiSelectController();
}
