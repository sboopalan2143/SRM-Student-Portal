// ignore_for_file: avoid_dynamic_calls
import 'dart:async';
import 'package:flutter/material.dart';

class CustomTextFieldSearch extends StatefulWidget {
  const CustomTextFieldSearch({
    required this.controller,
    super.key,
    this.initialList,
    this.textStyle,
    this.getSelectedValue,
    this.decoration,
    this.scrollbarDecoration,
    this.itemsInView = 3,
  });

  final List<dynamic>? initialList;

  final TextEditingController controller;

  final Function? getSelectedValue;

  final InputDecoration? decoration;

  final TextStyle? textStyle;

  final ScrollbarDecoration? scrollbarDecoration;

  final int itemsInView;

  @override
  _CustomTextFieldSearchState createState() => _CustomTextFieldSearchState();
}

class _CustomTextFieldSearchState extends State<CustomTextFieldSearch> {
  final FocusNode _focusNode = FocusNode();
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<dynamic>? filteredList = <dynamic>[];
  final _deBouncer = DeBouncer(milliseconds: 1000);
  static const itemHeight = 55;
  bool? itemsFound;
  ScrollController _scrollController = ScrollController();

  void resetList() {
    final tempList = <dynamic>[];
    setState(() {
      filteredList = tempList;
    });
    _overlayEntry.markNeedsBuild();
  }

  void resetState(List<dynamic> tempList) {
    setState(() {
      filteredList = tempList;
      if (tempList.isEmpty && widget.controller.text.isNotEmpty) {
        itemsFound = false;
      } else {
        itemsFound = true;
      }
    });
    _overlayEntry.markNeedsBuild();
  }

  void updateList() {
    filteredList = widget.initialList;

    final tempList = <dynamic>[];
    for (var i = 0; i < filteredList!.length; i++) {
      if (((filteredList![i] as dynamic).name as String)
              .toLowerCase()
              .contains(widget.controller.text.toLowerCase()) ==
          true) {
        tempList.add(filteredList![i]);
      }
    }
    resetState(tempList);
  }

  @override
  void initState() {
    super.initState();
    if (widget.scrollbarDecoration?.controller != null) {
      _scrollController = widget.scrollbarDecoration!.controller;
    }

    if (widget.initialList == null) {
      throw ArgumentError(
        'Error: Missing required initial list or future that returns list',
      );
    }
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry);
      } else {
        _overlayEntry.remove();
        if (itemsFound == false) {
          resetList();
          widget.controller.clear();
        }
        if (filteredList!.isNotEmpty) {
          var textMatchesItem = false;
          textMatchesItem = filteredList!.any(
            (item) =>
                (item as dynamic).name as String == widget.controller.text,
          );
          if (textMatchesItem == false) widget.controller.clear();
          resetList();
        }
      }
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  ListView _listViewBuilder(BuildContext context) {
    if (itemsFound == false) {
      return ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        controller: _scrollController,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              widget.controller.clear();
              setState(() {
                itemsFound = false;
              });
              resetList();
              FocusScope.of(context).unfocus();
            },
            child: const ListTile(
              title: Text('No matching items.'),
              trailing: Icon(Icons.cancel),
            ),
          ),
        ],
      );
    }
    return ListView.builder(
      controller: _scrollController,
      itemCount: filteredList!.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.controller.text =
                  (filteredList![i] as dynamic).name as String;
              widget.getSelectedValue!(filteredList![i]);
            });
            resetList();
            FocusScope.of(context).unfocus();
          },
          child: ListTile(
            title: Text(
              (filteredList![i] as dynamic).name as String,
            ),
          ),
        );
      },
      padding: EdgeInsets.zero,
      shrinkWrap: true,
    );
  }

  Widget decoratedScrollbar(Widget child) {
    if (widget.scrollbarDecoration is ScrollbarDecoration) {
      return Theme(
        data: Theme.of(context)
            .copyWith(scrollbarTheme: widget.scrollbarDecoration!.theme),
        child: Scrollbar(controller: _scrollController, child: child),
      );
    }

    return Scrollbar(child: child);
  }

  Widget? _listViewContainer(BuildContext context) {
    if (itemsFound != null && itemsFound! && filteredList!.isNotEmpty ||
        itemsFound == false && widget.controller.text.isNotEmpty) {
      return SizedBox(
        height: calculateHeight().toDouble(),
        child: decoratedScrollbar(_listViewBuilder(context)),
      );
    }
    return null;
  }

  num heightByLength(int length) {
    return itemHeight * length;
  }

  num calculateHeight() {
    if (filteredList!.length > 1) {
      if (widget.itemsInView <= filteredList!.length) {
        return heightByLength(widget.itemsInView);
      }

      return heightByLength(filteredList!.length);
    }

    return itemHeight;
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = context.findRenderObject()! as RenderBox;
    final overlaySize = renderBox.size;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return OverlayEntry(
      builder: (context) => Positioned(
        width: overlaySize.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, overlaySize.height + 5.0),
          child: Material(
            elevation: 4,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: screenWidth,
                maxWidth: screenWidth,
                maxHeight: calculateHeight().toDouble(),
              ),
              child: _listViewContainer(context),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: widget.decoration,
        style: widget.textStyle,
        onChanged: (String value) {
          _deBouncer.run(() {
            setState(updateList);
          });
        },
      ),
    );
  }
}

class DeBouncer {
  DeBouncer({this.milliseconds});

  final int? milliseconds;

  VoidCallback? action;

  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}

class ScrollbarDecoration {
  const ScrollbarDecoration({
    required this.controller,
    required this.theme,
  });

  final ScrollController controller;

  final ScrollbarThemeData theme;
}
