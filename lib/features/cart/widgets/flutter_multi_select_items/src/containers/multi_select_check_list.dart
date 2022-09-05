import 'package:flutter/material.dart';
import '../controller/multiselect_controller.dart';
import '../models/multiselect_list_settings.dart';
import '../models/animations.dart';
import '../cards/check_list_card.dart';

///Container for multi select check list cards.
class MultiSelectCheckList<T> extends StatefulWidget {
  const MultiSelectCheckList({
    Key? key,
    required this.items,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    this.animations = const MultiSelectAnimations(),
    this.listViewSettings = const ListViewSettings(),
    required this.onChange,
    this.chechboxScaleFactor = 1,
    required this.controller,
  }) : super(key: key);

  /// [CheckListCard] List for check list container.
  final List<CheckListCard<T>> items;

  /// [CheckListCard] padding.
  final EdgeInsetsGeometry itemPadding;

  /// All the settings for the list view.
  final ListViewSettings listViewSettings;

  /// Animation settings.
  final MultiSelectAnimations animations;

  /// Checkbox scale changing factor.
  final double chechboxScaleFactor;

  ///  A Controller for multi select. Allows to get all selected items, de select all, select all.
  final MultiSelectController<T> controller;

  /// Call when item is selected.
  final void Function() onChange;

  @override
  _MultiSelectCheckListState<T> createState() => _MultiSelectCheckListState();
}

class _MultiSelectCheckListState<T> extends State<MultiSelectCheckList<T>> {
  late List<T> _selectedItemsValues;
  @override
  void initState() {
    _items = widget.items;
    widget.controller.deselectAll = _deSelectAll;
    widget.controller.selectAll = _selectAll;
    _selectedItemsValues = widget.controller.selectedItemsValues;

    super.initState();
  }

  late final List<CheckListCard<T>> _items;

  @override
  void didUpdateWidget(MultiSelectCheckList<T> oldWidget) {
    widget.controller.deselectAll = oldWidget.controller.deselectAll;
    widget.controller.selectedItemsValues = oldWidget.controller.selectedItemsValues;
    widget.controller.selectAll = oldWidget.controller.selectAll;

    super.didUpdateWidget(oldWidget);
  }

  // Deselect all selected items excluding Perpetual Selected Items
  void _deSelectAll() {
    _selectedItemsValues.clear();
    setState(() {});
  }

  //Select items excluding disabled Selected Items
  List<T> _selectAll() {
    _selectedItemsValues.clear();
    _selectedItemsValues.addAll(_items.map((i) => i.value).toList());
    setState(() {});
    return _selectedItemsValues;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: widget.listViewSettings.shrinkWrap,
      scrollDirection: widget.listViewSettings.scrollDirection,
      reverse: widget.listViewSettings.reverse,
      addAutomaticKeepAlives: widget.listViewSettings.addAutomaticKeepAlives,
      addRepaintBoundaries: widget.listViewSettings.addRepaintBoundaries,
      dragStartBehavior: widget.listViewSettings.dragStartBehavior,
      keyboardDismissBehavior: widget.listViewSettings.keyboardDismissBehavior,
      clipBehavior: widget.listViewSettings.clipBehavior,
      controller: widget.listViewSettings.controller,
      primary: widget.listViewSettings.primary,
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.listViewSettings.padding,
      cacheExtent: widget.listViewSettings.cacheExtent,
      restorationId: widget.listViewSettings.restorationId,
      itemCount: _items.length,
      separatorBuilder: widget.listViewSettings.separatorBuilder ??
          (BuildContext context, int index) {
            return const SizedBox(
              height: 5,
            );
          },
      itemBuilder: (BuildContext context, int index) {
        final CheckListCard<T> item = _items[index];
        //
        var checkbox = Transform.scale(
          scale: 1 * widget.chechboxScaleFactor,
          child: InkWell(
            onTap: () async {
              if (_selectedItemsValues.contains(item.value)) {
                _selectedItemsValues.remove(item.value);
              } else {
                _selectedItemsValues.add(item.value);
              }
              widget.onChange();
            },
            child: SizedBox(
                height: 20,
                width: 20,
                child: _selectedItemsValues.contains(item.value)
                    ? const Icon(
                        Icons.radio_button_on,
                        color: Colors.blue,
                      )
                    : const Icon(Icons.radio_button_off)),
          ),
        );
        return Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: widget.itemPadding,
            child: Row(
              children: [
                checkbox,
                SizedBox(
                  width: item.checkBoxGap,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [item.title],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
