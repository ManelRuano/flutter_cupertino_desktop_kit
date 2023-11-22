import 'package:flutter/cupertino.dart';
import 'dsk_theme_colors.dart';
import 'dsk_theme_manager.dart';

// Copyright © 2023 Albert Palacios. All Rights Reserved.
// Licensed under the BSD 3-clause license, see LICENSE file for details.

class DSKButtonHelp extends StatefulWidget {
  final double size;
  final VoidCallback? onPressed;

  const DSKButtonHelp({
    Key? key,
    this.onPressed,
    this.size = 24.0,
  }) : super(key: key);

  @override
  DSKButtonHelpState createState() => DSKButtonHelpState();
}

class DSKButtonHelpState extends State<DSKButtonHelp> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onPressed,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _isPressed
              ? DSKThemeManager.isLight
                  ? DSKColors.grey50
                  : DSKColors.grey500
              : DSKColors.backgroundSecondary0,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: DSKColors.text.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
          border: DSKThemeManager.isLight
              ? Border.all(color: DSKColors.grey75)
              : Border.all(color: DSKColors.grey600),
        ),
        child: Container(
          width: widget.size,
          height: widget.size,
          alignment: Alignment.center,
          child: Text(
            '?',
            style: TextStyle(
              fontSize: widget.size / 1.5,
              color: DSKColors.text,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
