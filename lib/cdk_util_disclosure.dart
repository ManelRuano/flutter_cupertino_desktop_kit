import 'package:flutter/cupertino.dart';
import 'cdk_button_disclosure.dart';

// Copyright © 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

/// A disclosure widget in Flutter.
///
/// The [CDKUtilDisclosure] widget creates a disclosure UI pattern with an expandable
/// or collapsible child content when interacting with a disclosure button.
///
/// ```dart
/// CDKUtilDisclosure(
///   title: Text('Title'),
///   child: Container(
///     // Your content here
///   ),
///   onChanged: (isExpanded) {
///     // Handle disclosure state change
///   },
/// )
/// ```
class CDKUtilDisclosure extends StatefulWidget {
  final Widget title;
  final Widget child;
  final ValueChanged<bool>? onChanged;

  const CDKUtilDisclosure({
    Key? key,
    required this.title,
    required this.child,
    this.onChanged,
  }) : super(key: key);

  @override
  CDKUtilDisclosureState createState() => CDKUtilDisclosureState();
}

class CDKUtilDisclosureState extends State<CDKUtilDisclosure>
    with SingleTickerProviderStateMixin {
  final int _animationMillis = 200;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: _animationMillis),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleDisclosure() {
    if (_controller.isCompleted) {
      _controller.reverse();
      _isExpanded = false;
    } else {
      _controller.forward();
      _isExpanded = true;
    }
    widget.onChanged?.call(_controller.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            // CDKButtonDisclosure is not defined in this snippet,
            // assuming it's a disclosure button widget.
            CDKButtonDisclosure(
              value: _isExpanded,
              onChanged: (newValue) => _toggleDisclosure(),
            ),
            Expanded(child: widget.title),
          ],
        ),
        SizeTransition(
          sizeFactor: _animation,
          axis: Axis.vertical,
          axisAlignment: -1.0,
          child: SizedBox(
              width: double.infinity,
              child: widget.child),
        ),
      ],
    );
  }
}
