library overscroll_pop;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:overscroll_pop/drag_to_pop.dart';

/////////////////////////////////////////////////////////////////////////////
export 'package:overscroll_pop/drag_to_pop.dart';
//////////////////////////////////////////////////////////////////////////////

enum ScrollToPopOption { start, end, both, none }

enum DragToPopDirection {
  toTop,
  toBottom,
  toLeft,
  toRight,
  horizontal,
  vertical
}

class OverscrollPop extends StatefulWidget {
  final Widget child;
  final bool enable;
  final DragToPopDirection? dragToPopDirection;
  final ScrollToPopOption scrollToPopOption;
  final double friction;
  final BorderRadius? borderRadius;

  const OverscrollPop({
    Key? key,
    required this.child,
    this.dragToPopDirection,
    this.scrollToPopOption = ScrollToPopOption.start,
    this.enable = true,
    this.friction = 1.0,
    this.borderRadius,
  }) : super(key: key);

  @override
  _OverscrollPopState createState() => _OverscrollPopState();
}

class _OverscrollPopState extends State<OverscrollPop>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _animationController;
  late Animation<Offset> _animation;

  Offset? _dragOffset;
  Offset? _previousPosition;
  bool _isDraggingToPopStart = false;
  bool _isDraggingToPop = false;

  @override
  void initState() {
    if (widget.enable) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 200),
      )..addStatusListener(_onAnimationEnd);

      _animation = Tween<Offset>(
        begin: Offset.zero,
        end: Offset.zero,
      ).animate(_animationController!);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (widget.enable) {
      _animationController?.removeStatusListener(_onAnimationEnd);
      _animationController?.dispose();
    }

    super.dispose();
  }

  void _onAnimationEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController?.reset();
      setState(() {
        _dragOffset = null;
        _previousPosition = null;
        _isDraggingToPop = false;
        _isDraggingToPopStart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = widget.child;

    if (!widget.enable) return childWidget;

    if (widget.dragToPopDirection != null)
      childWidget = GestureDetector(
        onHorizontalDragStart: getOnHorizontalDragStartFunction(),
        onHorizontalDragUpdate: getOnHorizontalDragUpdateFunction(),
        onHorizontalDragEnd: getOnHorizontalDragEndFunction(),
        onVerticalDragStart: getOnVerticalDragStartFunction(),
        onVerticalDragUpdate: getOnVerticalDragUpdateFunction(),
        onVerticalDragEnd: getOnVerticalDragEndFunction(),
        child: widget.child,
      );

    if (widget.scrollToPopOption != ScrollToPopOption.none)
      childWidget = NotificationListener<OverscrollNotification>(
        onNotification: _onOverScrollDragUpdate,
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScroll,
          child: childWidget,
        ),
      );

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, Widget? child) {
        Offset finalOffset = _dragOffset ?? Offset(0.0, 0.0);
        if (_animation.status == AnimationStatus.forward)
          finalOffset = _animation.value;

        final maxOpacityWhenDrag = 0.75;
        final bgOpacity = finalOffset.distance == 0.0
            ? 1.0
            : math.min(
                maxOpacityWhenDrag - (finalOffset.dy / 100 / 6).abs(),
                maxOpacityWhenDrag - (finalOffset.dx / 100 / 8).abs(),
              );

        final scale = finalOffset.distance == 0.0
            ? 1.0
            : math.min(
                1.0 - (finalOffset.dy / 3000).abs(),
                1.0 - (finalOffset.dx / 1200).abs(),
              );

        final hasBorderRadius = widget.borderRadius != null;

        return ColoredBox(
          color: Colors.black.withOpacity(bgOpacity.clamp(0.0, 1.0)),
          child: Transform.scale(
            scale: scale,
            child: Transform.translate(
              offset: finalOffset,
              child: ClipRRect(
                borderRadius: hasBorderRadius
                    ? widget.borderRadius! * (1.0 - bgOpacity.clamp(0.0, 1.0))
                    : BorderRadius.zero,
                child: child,
              ),
            ),
          ),
        );
      },
      child: childWidget,
    );
  }

  bool _onScroll(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollEndNotification)
      return _onOverScrollDragEnd(scrollNotification.dragDetails);

    if (scrollNotification is ScrollUpdateNotification)
      return _onScrollDragUpdate(scrollNotification.dragDetails);

    return false;
  }

  bool _onOverScrollDragEnd(DragEndDetails? dragEndDetails) {
    if (_dragOffset == null) return false;
    final dragOffset = _dragOffset!;

    final screenSize = MediaQuery.of(context).size;

    if (dragEndDetails != null) {
      if (dragOffset.dy.abs() >= screenSize.height / 3 ||
          dragOffset.dx.abs() >= screenSize.width / 1.8) {
        Navigator.of(context).pop();
        return false;
      }

      final velocity = dragEndDetails.velocity.pixelsPerSecond;
      final velocityY = velocity.dy / widget.friction / widget.friction;
      final velocityX = velocity.dx / widget.friction / widget.friction;

      if (velocityY.abs() > 150.0 || velocityX.abs() > 200.0) {
        Navigator.of(context).pop();
        return false;
      }
    }

    setState(() {
      _animation = Tween<Offset>(
        begin: Offset(dragOffset.dx, dragOffset.dy),
        end: Offset(0.0, 0.0),
      ).animate(_animationController!);
    });

    _animationController?.forward();
    return false;
  }

  bool _onScrollDragUpdate(DragUpdateDetails? dragUpdateDetails) {
    if (_dragOffset == null) return false;
    if (dragUpdateDetails == null) return false;

    if (_previousPosition == null) {
      _previousPosition = dragUpdateDetails.globalPosition;
      return false;
    }

    return _setDragOffset(dragUpdateDetails);
  }

  bool _onOverScrollDragUpdate(OverscrollNotification overscrollNotification) {
    final scrollToPopOption = widget.scrollToPopOption;

    if (scrollToPopOption == ScrollToPopOption.start &&
        overscrollNotification.overscroll > 0) return false;

    if (scrollToPopOption == ScrollToPopOption.end &&
        overscrollNotification.overscroll < 0) return false;

    final dragUpdateDetails = overscrollNotification.dragDetails;
    if (dragUpdateDetails == null) return false;
    return _setDragOffset(dragUpdateDetails);
  }

  bool _setDragOffset(DragUpdateDetails dragUpdateDetails) {
    if (_previousPosition == null) {
      _previousPosition = dragUpdateDetails.globalPosition;
      return false;
    }

    final currentPosition = dragUpdateDetails.globalPosition;
    final previousPosition = _previousPosition!;

    final newX = (_dragOffset?.dx ?? 0.0) +
        (currentPosition.dx - previousPosition.dx) / widget.friction;
    final newY = (_dragOffset?.dy ?? 0.0) +
        (currentPosition.dy - previousPosition.dy) / widget.friction;
    _previousPosition = currentPosition;
    setState(() {
      _dragOffset = Offset(newX, newY);
    });
    return false;
  }

  bool _onDragUpdate(DragUpdateDetails dragUpdateDetails) {
    if (!_isDraggingToPop) return false;
    final previousPosition = _previousPosition!;

    if (_isDraggingToPopStart) {
      _isDraggingToPopStart = false;

      final currentPosition = dragUpdateDetails.globalPosition;
      final dragToPopDirection = widget.dragToPopDirection;

      if (dragToPopDirection == DragToPopDirection.toRight &&
          previousPosition.dx > currentPosition.dx) {
        _isDraggingToPop = false;
        return false;
      }

      if (dragToPopDirection == DragToPopDirection.toLeft &&
          previousPosition.dx < currentPosition.dx) {
        _isDraggingToPop = false;
        return false;
      }

      if (dragToPopDirection == DragToPopDirection.toTop &&
          previousPosition.dy < currentPosition.dy) {
        _isDraggingToPop = false;
        return false;
      }

      if (dragToPopDirection == DragToPopDirection.toBottom &&
          previousPosition.dy > currentPosition.dy) {
        _isDraggingToPop = false;
        return false;
      }
    }

    return _setDragOffset(dragUpdateDetails);
  }

  /////////////////////////////////////////////////////////////////////////////

  GestureDragStartCallback? getOnHorizontalDragStartFunction() {
    switch (widget.dragToPopDirection) {
      case DragToPopDirection.horizontal:
      case DragToPopDirection.toLeft:
      case DragToPopDirection.toRight:
        return (DragStartDetails dragDetails) {
          _isDraggingToPopStart = true;
          _isDraggingToPop = true;
          _previousPosition = dragDetails.globalPosition;
        };
      default:
        return null;
    }
  }

  GestureDragUpdateCallback? getOnHorizontalDragUpdateFunction() {
    switch (widget.dragToPopDirection) {
      case DragToPopDirection.horizontal:
      case DragToPopDirection.toLeft:
      case DragToPopDirection.toRight:
        return _onDragUpdate;
      default:
        return null;
    }
  }

  GestureDragEndCallback? getOnHorizontalDragEndFunction() {
    switch (widget.dragToPopDirection) {
      case DragToPopDirection.horizontal:
      case DragToPopDirection.toLeft:
      case DragToPopDirection.toRight:
        return _onOverScrollDragEnd;
      default:
        return null;
    }
  }

  ////////////////////////

  GestureDragStartCallback? getOnVerticalDragStartFunction() {
    switch (widget.dragToPopDirection) {
      case DragToPopDirection.vertical:
      case DragToPopDirection.toTop:
      case DragToPopDirection.toBottom:
        return (DragStartDetails dragDetails) {
          _isDraggingToPopStart = true;
          _isDraggingToPop = true;
          _previousPosition = dragDetails.globalPosition;
        };
      default:
        return null;
    }
  }

  GestureDragUpdateCallback? getOnVerticalDragUpdateFunction() {
    switch (widget.dragToPopDirection) {
      case DragToPopDirection.vertical:
      case DragToPopDirection.toTop:
      case DragToPopDirection.toBottom:
        return _onDragUpdate;
      default:
        return null;
    }
  }

  GestureDragEndCallback? getOnVerticalDragEndFunction() {
    switch (widget.dragToPopDirection) {
      case DragToPopDirection.vertical:
      case DragToPopDirection.toTop:
      case DragToPopDirection.toBottom:
        return _onOverScrollDragEnd;
      default:
        return null;
    }
  }
}

Future<dynamic> pushOverscrollRoute({
  required BuildContext context,
  required Widget child,
  ScrollToPopOption scrollToPopOption = ScrollToPopOption.start,
  DragToPopDirection? dragToPopDirection,
  bool fullscreenDialog = false,
  RouteSettings? settings,
  Duration transitionDuration = const Duration(milliseconds: 250),
  Duration reverseTransitionDuration = const Duration(milliseconds: 250),
  Color? barrierColor,
  String? barrierLabel,
  bool barrierDismissible = false,
  bool maintainState = true,
}) async =>
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: transitionDuration,
        reverseTransitionDuration: reverseTransitionDuration,
        fullscreenDialog: fullscreenDialog,
        opaque: false,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          _,
          Widget child,
        ) {
          if (animation.status == AnimationStatus.reverse ||
              animation.status == AnimationStatus.dismissed)
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInCirc,
              ),
              child: child,
            );

          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (_, __, ___) => OverscrollPop(
          dragToPopDirection: dragToPopDirection,
          scrollToPopOption: scrollToPopOption,
          child: child,
        ),
        maintainState: maintainState,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        barrierDismissible: barrierDismissible,
        settings: settings,
      ),
    );

Future<dynamic> pushDragToPopRoute({
  required BuildContext context,
  required Widget child,
  bool fullscreenDialog = false,
  RouteSettings? settings,
  Duration transitionDuration = const Duration(milliseconds: 250),
  Duration reverseTransitionDuration = const Duration(milliseconds: 250),
  Color? barrierColor,
  String? barrierLabel,
  bool barrierDismissible = false,
  bool maintainState = true,
}) async =>
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: transitionDuration,
        reverseTransitionDuration: reverseTransitionDuration,
        fullscreenDialog: fullscreenDialog,
        opaque: false,
        transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          _,
          Widget child,
        ) {
          if (animation.status == AnimationStatus.reverse ||
              animation.status == AnimationStatus.dismissed)
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInExpo,
              ),
              child: child,
            );

          return FadeTransition(opacity: animation, child: child);
        },
        pageBuilder: (_, __, ___) => DragToPop(child: child),
        maintainState: maintainState,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        barrierDismissible: barrierDismissible,
        settings: settings,
      ),
    );
