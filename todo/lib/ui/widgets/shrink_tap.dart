import 'package:flutter/material.dart';
import 'package:async/async.dart';

class ShrinkTap extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final HitTestBehavior? behavior;

  ShrinkTap({required this.child, required this.onTap, this.behavior});

  @override
  _ShrinkTapState createState() => _ShrinkTapState();
}

class _ShrinkTapState extends State<ShrinkTap> with TickerProviderStateMixin {
  static const ANIMATION_CURVE = Curves.linear;
  static const ANIMATION_TIME = const Duration(milliseconds: 130);
  static const TAP_SCALE = 0.97;

  late AnimationController _controller;
  late Animation<double> _animation;
  double _scale = 1;

  CancelableOperation? _delayedAnimation = null;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: _scale,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _delayedAnimation?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap == null) {
      return widget.child;
    }
    return GestureDetector(
      behavior: widget.behavior,
      onTap: () => widget.onTap?.call(),
      onTapDown: (details) {
        _delayedAnimation?.cancel();
        _controller.animateTo(TAP_SCALE,
            curve: ANIMATION_CURVE, duration: ANIMATION_TIME);
      },
      onTapCancel: () {
        _controller.animateTo(1,
            curve: ANIMATION_CURVE, duration: ANIMATION_TIME);
      },
      onTapUp: (details) {
        _delayedAnimation = CancelableOperation.fromFuture(
                Future.delayed(Duration(milliseconds: 100)))
            .then((_) {
          _controller.animateTo(1,
              curve: ANIMATION_CURVE, duration: ANIMATION_TIME);
        });
      },
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
