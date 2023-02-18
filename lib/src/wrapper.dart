import 'package:flutter/material.dart';
import 'controller.dart';

/// The wrapper class
/// Field [List<Widget> drawerItems] takes menu items / drawer items
/// Field [double itemGaa] takes the Y-AXIS gap
/// Field [Color backgroundColor] takes background color (default white)
/// Field [Color backgroundColor] takes background color (default white)
/// Field [Widget child] takes content
/// Field [FancyDrawerController controller] takes the controller
/// Field [bool hideOnContentTap] determines if user tap will hide the drawer or not
/// Field [double cornerRadius] determines the content corner radius
/// Field [EdgeInsets? drawerPadding] determines overall drawer padding
///   Field [double childWidth] set the width of a child ....

class FancyDrawerWrapper extends StatefulWidget {
  final List<Widget> drawerItems;
  final double itemGap;
  final Color backgroundColor;
  final Widget child;
  final FancyDrawerController controller;
  final bool hideOnContentTap;
  final double cornerRadius;
  final EdgeInsets? drawerPadding;
  final double childWidth;

  FancyDrawerWrapper({
    Key? key,
    required this.drawerItems,
    required this.child,
    required this.controller,
    this.backgroundColor = Colors.white,
    this.itemGap = 10.0,
    this.hideOnContentTap = true,
    this.cornerRadius = 8.0,
    this.drawerPadding,

    this.childWidth = 270.0

  }) : super(key: key);

  @override
  _FancyDrawerWrapperState createState() => _FancyDrawerWrapperState();
}

class _FancyDrawerWrapperState extends State<FancyDrawerWrapper> {
  @override
  void initState() {
    super.initState();
  }

  Widget _renderContent() {

    final slideAmount = widget.childWidth * widget.controller.percentOpen;

    final contentScale = 1.0 - (0.2 * widget.controller.percentOpen);
    final cornerRadius = widget.cornerRadius * widget.controller.percentOpen;

    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.15),
              offset: Offset(0.0, 4.0),
              blurRadius: 40.0,
              spreadRadius: 10.0)
        ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(cornerRadius),
          child: GestureDetector(
            onTap: () {
              if (widget.hideOnContentTap) {
                widget.controller.close();
              }
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: widget.backgroundColor,
          child: Center(
            child: ListView(
              padding: widget.drawerPadding ?? EdgeInsets.all(10),
              shrinkWrap: true,
              children: widget.drawerItems.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: widget.itemGap),
                  child: item,
                );
              }).toList(),
            ),
          ),
        ),
        _renderContent()
      ],
    );
  }
}
