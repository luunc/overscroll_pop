import 'dart:math' as math;

import 'package:flutter/material.dart';

class DragToPop extends StatefulWidget {
  final Widget child;

  const DragToPop({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _DragToPopState createState() => _DragToPopState();
}

class _DragToPopState extends State<DragToPop>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _animationController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 200),
  )..addStatusListener(_onAnimationEnd);

  late Animation<Offset> _animation = Tween<Offset>(
    begin: Offset.zero,
    end: Offset.zero,
  ).animate(_animationController!);

  Offset? _dragOffset;
  Offset? _previousPosition;

  @override
  void dispose() {
    _animationController?.removeStatusListener(_onAnimationEnd);
    _animationController?.dispose();
    super.dispose();
  }

  void _onAnimationEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController?.reset();
      setState(() {
        _dragOffset = null;
        _previousPosition = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

        return Container(
          color: Colors.black.withOpacity(bgOpacity.clamp(0.0, 1.0)),
          child: Transform.scale(
            scale: scale,
            child: Transform.translate(
              offset: finalOffset,
              child: child,
            ),
          ),
        );
      },
      child: GestureDetector(
        onScaleStart: _onDragStart,
        onScaleUpdate: _onDragUpdate,
        onScaleEnd: _onOverScrollDragEnd,
        child: widget.child,
      ),
    );
  }

  void _onDragStart(ScaleStartDetails scaleDetails) {
    _previousPosition = scaleDetails.focalPoint;
  }

  void _onDragUpdate(ScaleUpdateDetails scaleUpdateDetails) {
    // if (_previousPosition == null) {
    //   _previousPosition = scaleUpdateDetails.focalPoint;
    //   return;
    // }

    final currentPosition = scaleUpdateDetails.focalPoint;
    final previousPosition = _previousPosition!;

    final newX =
        (_dragOffset?.dx ?? 0.0) + (currentPosition.dx - previousPosition.dx);
    final newY =
        (_dragOffset?.dy ?? 0.0) + (currentPosition.dy - previousPosition.dy);
    _previousPosition = currentPosition;

    setState(() {
      _dragOffset = Offset(newX, newY);
    });
  }

  void _onOverScrollDragEnd(ScaleEndDetails? scaleEndDetails) {
    if (_dragOffset == null) return;
    final dragOffset = _dragOffset!;

    final screenSize = MediaQuery.of(context).size;

    if (scaleEndDetails != null) {
      if (dragOffset.dy.abs() >= screenSize.height / 3 ||
          dragOffset.dx.abs() >= screenSize.width / 1.8) {
        Navigator.of(context).pop();
        return;
      }

      final velocity = scaleEndDetails.velocity.pixelsPerSecond;
      final velocityY = velocity.dy;
      final velocityX = velocity.dx;

      if (velocityY.abs() > 150.0 || velocityX.abs() > 200.0) {
        Navigator.of(context).pop();
        return;
      }
    }

    setState(() {
      _animation = Tween<Offset>(
        begin: Offset(dragOffset.dx, dragOffset.dy),
        end: Offset(0.0, 0.0),
      ).animate(_animationController!);
    });

    _animationController?.forward();
  }
}
