import 'package:flutter/material.dart';
import 'package:neo_calculator/style/app_colors.dart';
import 'package:neo_calculator/style/app_style.dart';

class NeumorphicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final double size;
  final Color color;

  const NeumorphicButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.size = 80,
    this.color = Colors.black,
  });

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          shape: BoxShape.circle,
          boxShadow: _isPressed
              ? [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-3, -3),
                    blurRadius: 5,
                  ),
                  BoxShadow(
                    color: Color(0xFFEBEEF9),
                    offset: const Offset(3, 3),
                    blurRadius: 5,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-6, -6),
                    blurRadius: 10,
                  ),
                  BoxShadow(
                    color: Color(0xFFDADDE6),
                    offset: const Offset(6, 6),
                    blurRadius: 10,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.label,
            style: AppStyle.fontStyle.copyWith(
              fontSize: widget.size / 3,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
        ),
      ),
    );
  }
}
