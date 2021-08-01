import 'package:flutter/material.dart';
import 'drawer_state.dart';

/// Controls the Drawer Wrapper class
/// Field [TickerProvider vsync] is required
/// Field [Duration duration] is set to 250ms by default
class FancyDrawerController extends ChangeNotifier {
  final TickerProvider vsync;
  final Duration duration;
  final AnimationController _animationController;
  DrawerState state = DrawerState.closed;

  FancyDrawerController({
    required this.vsync,
    this.duration = const Duration(milliseconds: 250),
  }) : _animationController =
            AnimationController(vsync: vsync, duration: duration) {
    _initController();
  }

  void _initController() {
    _animationController
      ..addListener(() {
        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = DrawerState.opening;
            break;
          case AnimationStatus.reverse:
            state = DrawerState.closing;
            break;
          case AnimationStatus.completed:
            state = DrawerState.closed;
            break;
          case AnimationStatus.dismissed:
            state = DrawerState.closed;
            break;
          default:
            state = DrawerState.closed;
        }

        notifyListeners();
      });
  }

  get percentOpen => _animationController.value;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Open the drawer programmatically
  void open() {
    _animationController.forward();
  }

  /// Close the drawer programmatically
  void close() {
    _animationController.reverse();
  }

  /// Toggle the drawer programmatically
  /// IMPORTANT : toggle function is buggy
  /// Best use is [open] or [close] function
  void toggle() {
    if (state == DrawerState.open) {
      close();
    } else if (state == DrawerState.closed) {
      open();
    }
  }
}
