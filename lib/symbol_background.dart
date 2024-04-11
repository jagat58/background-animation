// ignore_for_file: unnecessary_type_check

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class SymbolBackground extends StatefulWidget {
  final Widget child;

  SymbolBackground({required Key key, required Widget child})
      : this.child = child,
        super(key: key);

  @override
  _SymbolBackgroundWidgetState createState() => _SymbolBackgroundWidgetState();
}

class _SymbolBackgroundWidgetState extends State<SymbolBackground>
    with TickerProviderStateMixin {
      //give a background symbol over here in the list
  final List<String> symbols = ['+', '*',];
  List<SymbolParticle> particles = [];

  @override
  void initState() {
    super.initState();
    _initializeParticles();
    _startAnimation();
  }

  void _initializeParticles() {
    particles.clear();
    for (int i = 0; i < 30; i++) {
      particles.add(SymbolParticle(
        symbol: symbols[Random().nextInt(symbols.length)],
        color: Colors.black.withOpacity(0.2),
        radius: Random().nextDouble() * 3.0 + 4.0,
        vsync: this,
      ));
    }
  }

  void _startAnimation() {
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      particles.forEach((particle) {
        if (particle is SymbolParticle) {
          particle.updatePosition();
        }
      });
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        Stack(
          children: particles,
        ),
      ],
    );
  }
}

class SymbolParticle extends StatefulWidget {
  final String symbol;
  final Color color;
  final double radius;
  final TickerProvider vsync;

  SymbolParticle({
    String symbol = ' ',
    Color color =Colors.black,
    double radius = 4.0,//give radius as you want 
    required TickerProvider vsync,
  })  : this.symbol = symbol,
        this.color = color,
        this.radius = radius,
        this.vsync = vsync,
        super();

  @override
  _SymbolParticleState createState() => _SymbolParticleState();
  
  void updatePosition() {}
}

class _SymbolParticleState extends State<SymbolParticle>
    with SingleTickerProviderStateMixin {
  double x = 0.0;
  double y = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initializePosition();
    _controller = AnimationController(
        vsync: widget.vsync, duration: Duration(seconds: 2));
    _controller.addListener(() {
      _updatePosition();
    });
    _controller.repeat();
  }

  void _initializePosition() {
    x = Random().nextDouble() * 500;
    y = Random().nextDouble() * 500;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updatePosition() {
    setState(() {
      x += Random().nextDouble() * 2 - 1;
      y += Random().nextDouble() * 2 - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x,
      top: y,
      child: Text(
        widget.symbol,
        style: TextStyle(fontSize: widget.radius * 5, color: widget.color),
      ),
    );
  }
}
