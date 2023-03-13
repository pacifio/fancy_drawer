import 'package:fancy_drawer/fancy_drawer.dart';
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
/// Field [double childWidth] set the width of a child ....
/// Field [double childMargin] set the child  margin to your own need....

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
  final EdgeInsets childMargin;
  final String parentBackgroundImage;

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
    this.childMargin  = EdgeInsets.zero,
    this.childWidth = 270.0,
    this.parentBackgroundImage=""
  }) : super(key: key);

  @override
  _FancyDrawerWrapperState createState() => _FancyDrawerWrapperState();
}

class _FancyDrawerWrapperState extends State<FancyDrawerWrapper> {
  @override
  void initState() {
    super.initState();
  }

  var anotherState = false;

  Widget _renderContent() {

    var state = true;

    if (widget.controller.state == DrawerState.open) {
      state = false;
    }

    if (widget.controller.state == DrawerState.opening) {
      state = true;
      anotherState = true;

    }
    if (widget.controller.state == DrawerState.closing) {
      state = false;
      anotherState = false;

    }

    if (widget.controller.state == DrawerState.closed) {
      if (anotherState) {
        state = true;
      } else {
        state = false;
      }
    }

    final slideAmount = widget.childWidth * widget.controller.percentOpen;

    final contentScale = 1.0 - (0.2 * widget.controller.percentOpen);
    final cornerRadius = widget.cornerRadius * widget.controller.percentOpen;

    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,

      child: Container(
        margin: state ?  widget.childMargin : EdgeInsets.zero,
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
      clipBehavior: Clip.none,
      children: [


        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              image: DecorationImage(
                  image: AssetImage(widget.parentBackgroundImage),
                  fit: BoxFit.cover)),
          child: Center(
            child: ListView(
              padding: widget.drawerPadding ?? EdgeInsets.all(10),
              physics: const NeverScrollableScrollPhysics(),
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
