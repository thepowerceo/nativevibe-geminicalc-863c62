import 'package:flutter/material.dart';

enum ButtonType { number, operator, function, action }

class CalculatorButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final ButtonType type;
  final int flex;

  CalculatorButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.type = ButtonType.number,
    this.flex = 1,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> {
  bool _isPressed = false;

  Color _getBackgroundColor(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    switch (widget.type) {
      case ButtonType.operator:
        return colors.primaryContainer;
      case ButtonType.function:
        return colors.tertiaryContainer;
      case ButtonType.action:
        return colors.secondaryContainer;
      case ButtonType.number:
      default:
        return colors.surfaceContainerHighest;
    }
  }

  Color _getTextColor(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    switch (widget.type) {
      case ButtonType.operator:
        return colors.onPrimaryContainer;
      case ButtonType.function:
        return colors.onTertiaryContainer;
      case ButtonType.action:
        return colors.onSecondaryContainer;
      case ButtonType.number:
      default:
        return colors.onSurface;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = _getBackgroundColor(context);
    final textColor = _getTextColor(context);
    final isDark = theme.brightness == Brightness.dark;

    final double elevation = _isPressed ? 2.0 : (isDark ? 4.0 : 6.0);
    final Color shadowColor = isDark ? Colors.black.withOpacity(0.8) : Colors.black.withOpacity(0.3);

    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  offset: _isPressed ? Offset(2, 2) : Offset(4, 4),
                  blurRadius: _isPressed ? 2.0 : 4.0,
                ),
                BoxShadow(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.7),
                  offset: _isPressed ? Offset(-1, -1) : Offset(-2, -2),
                  blurRadius: _isPressed ? 2.0 : 4.0,
                ),
              ],
            ),
            child: Center(
              child: Text(
                widget.label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}