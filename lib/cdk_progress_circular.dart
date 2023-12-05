import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'cdk_theme_notifier.dart';
import 'cdk_theme.dart';

// Copyright © 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

/// A circular progress indicator widget for Flutter applications.
///
/// Example of using [CDKProgressCircular]:
///
/// ```dart
/// CDKProgressCircular(
///   value: 0.5,
///   isIndeterminate: false,
///   isRunning: true,
/// )
/// ```
///
/// This creates a determinate `CDKProgressCircular` widget with a current value of 0.5,
/// showing progress with animation enabled.
///
/// The [CDKProgressCircular] widget displays a circular progress indicator
/// that can be either determinate or indeterminate.
class CDKProgressCircular extends StatefulWidget {
  final double value; // The current progress value
  final bool isIndeterminate; // Indicates if progress is indeterminate
  final bool isRunning; // Indicates if the progress animation is running

  const CDKProgressCircular({
    Key? key,
    this.value = 0.0,
    this.isIndeterminate = false,
    this.isRunning = false,
  }) : super(key: key);

  @override
  CDKProgressCircularState createState() => CDKProgressCircularState();
}

class CDKProgressCircularState extends State<CDKProgressCircular>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation; // Animation for progress
  Timer? _timer;
  final int _animationMillis = 500;
  final int _animationMillisIndeterminate = 1500;

  @override
  void initState() {
    super.initState();
    if (widget.value < 0 || widget.value > 1) {
      throw Exception(
          "CDKProgressCircularState initState: value must be between 0 and 1");
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationMillis),
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ))
      ..addListener(() {
        setState(() {});
      });

    if (!widget.isIndeterminate) {
      _controller.value = widget.value;
    }

    if (widget.isIndeterminate && widget.isRunning) {
      startIndeterminateAnimation();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(CDKProgressCircular oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isIndeterminate != oldWidget.isIndeterminate ||
        widget.isRunning != oldWidget.isRunning) {
      if (widget.isIndeterminate && widget.isRunning) {
        startIndeterminateAnimation();
      } else {
        stopIndeterminateAnimation();
      }
    } else if (!widget.isIndeterminate) {
      if (oldWidget.value >= 0.95 && widget.value <= 0.05) {
        // If changing from 100 to 0, update the progress directly without animation
        _controller.value = 0.0;
        _controller.duration = const Duration(milliseconds: 0);
        _progressAnimation =
            Tween<double>(begin: 0.0, end: 0.0).animate(_controller);
      } else if (widget.value != oldWidget.value) {
        // Otherwise, create a new Tween and start the animation
        _controller.duration = Duration(milliseconds: _animationMillis);
        var tween =
            Tween<double>(begin: _progressAnimation.value, end: widget.value);
        _progressAnimation = tween.animate(_controller)
          ..addListener(() {
            setState(() {});
          });
        _controller.forward(from: 0.0);
      }
    }
  }

  // Methods for handling indeterminate animations

  void startIndeterminateAnimation() {
    _controller.duration =
        Duration(milliseconds: _animationMillisIndeterminate);
    _timer?.cancel();
    _timer = Timer(Duration.zero, () {
      _controller.forward();
    });

    _controller.addStatusListener(_statusListener);
  }

  void stopIndeterminateAnimation() {
    _timer?.cancel();
    _controller.stop();
    _controller.removeStatusListener(_statusListener);
    _controller.reset();
    _controller.duration = Duration(milliseconds: _animationMillis);
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.repeat();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    CDKTheme theme = CDKThemeNotifier.of(context)!.changeNotifier;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ProgressCircularPainter(
              colorAccent: theme.accent,
              colorBackgroundSecondary1: theme.backgroundSecondary1,
              progress: widget.isIndeterminate
                  ? _controller.value
                  : _progressAnimation.value,
              isIndeterminate: widget.isIndeterminate,
              isIndeterminateAnimating: _controller.isAnimating,
              hasAppFocus: theme.isAppFocused,
              isLightTheme: theme.isLight),
          child: child,
        );
      },
      child: Container(), // This is the child that won't be rebuilt
    );
  }
}

/// Custom painter for the circular progress indicator.
class ProgressCircularPainter extends CustomPainter {
  // Properties and constructor...

  @override
  void paint(Canvas canvas, Size size) {
    // Painting logic...
  }

  @override
  bool shouldRepaint(covariant ProgressCircularPainter oldDelegate) {
    return oldDelegate.colorAccent != colorAccent ||
        oldDelegate.colorBackgroundSecondary1 != colorBackgroundSecondary1 ||
        oldDelegate.progress != progress ||
        oldDelegate.hasAppFocus != hasAppFocus ||
        oldDelegate.isIndeterminate != isIndeterminate ||
        oldDelegate.isLightTheme != isLightTheme ||
        oldDelegate.isIndeterminateAnimating != isIndeterminateAnimating;
  }
}
