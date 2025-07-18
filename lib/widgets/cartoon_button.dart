import 'package:flutter/material.dart';

class CartoonButton extends StatefulWidget {
  final String label;
  final double size;
  final double spacing;
  final bool isboxShadow;
  final VoidCallback onPressed;

  const CartoonButton({
    super.key,
    required this.label,
    required this.onPressed, required this.size, required this.spacing, required this.isboxShadow,
  });

  @override
  State<CartoonButton> createState() => _CartoonButtonState();
}

class _CartoonButtonState extends State<CartoonButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.9);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.deepOrange, Colors.orange,]),
            border: Border.all(color: Colors.black, width: 4),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              widget.isboxShadow ? BoxShadow(
                color: Colors.black,
                offset: Offset(4, 4),
                blurRadius: 0,
              ) : BoxShadow(),
            ],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.size,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Mouzambik",
              letterSpacing: widget.spacing
            ),
          ),
        ),
      ),
    );
  }
}
