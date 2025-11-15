import 'dart:typed_data';
import 'package:flutter/material.dart';

enum CartAnimationType { adding, success, failure }

class AnimatedAddToCart extends StatefulWidget {
  final Offset start;
  final Offset end;
  final Uint8List image;
  final String text;
  final CartAnimationType type;
  final VoidCallback onComplete;

  const AnimatedAddToCart({
    required this.start,
    required this.end,
    required this.image,
    required this.text,
    required this.type,
    required this.onComplete,
    super.key,
  });

  @override
  _AnimatedAddToCartState createState() => _AnimatedAddToCartState();
}

class _AnimatedAddToCartState extends State<AnimatedAddToCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _positionAnimation = Tween<Offset>(
      begin: widget.start,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onComplete();
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pos = _positionAnimation.value;
        return Positioned(
          left: pos.dx,
          top: pos.dy,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 6)
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.memory(widget.image, width: 50, height: 50),
                    const SizedBox(width: 8),
                    Text(
                      widget.text,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
