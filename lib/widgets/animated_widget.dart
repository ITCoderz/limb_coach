import 'package:flutter/material.dart';

class AnimatedScreenWidget extends StatefulWidget {
  const AnimatedScreenWidget({super.key, required this.child});
  final Widget child;
  @override
  State<AnimatedScreenWidget> createState() => _AnimatedScreenWidgetState();
}

class _AnimatedScreenWidgetState extends State<AnimatedScreenWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // starts off-screen (right)
      end: Offset.zero, // ends in position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
