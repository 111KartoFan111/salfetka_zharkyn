// neural_logo_widget.dart — создан автоматически
// lib/widgets/neural_logo_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NeuralLogoWidget extends StatelessWidget {
  final double size;
  const NeuralLogoWidget({super.key, this.size = 40.0});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/logo/neural_logo.svg',
      width: size,
      height: size,
    );
  }
}