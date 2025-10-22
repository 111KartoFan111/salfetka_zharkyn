// lib/widgets/ui/input.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/theme.dart';

class AppInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;

  const AppInput({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.borderRadius = 16.0, // rounded-2xl default
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 24, vertical: 20), // h-14 equivalent
  });

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: Colors.grey[300]!), // border-gray-200
    );

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      style: Theme.of(context).textTheme.bodyLarge, // text-base/md:text-sm
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppTheme.mutedForeground),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 12.0), // Adjust padding to match design
                child: Icon(prefixIcon, color: AppTheme.mutedForeground, size: 20),
              )
            : null,
        filled: true,
        fillColor: AppTheme.background, // bg-white or input-background
        contentPadding: contentPadding,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: AppTheme.gradientPurple, width: 2), // focus ring imitation
        ),
        // disabledBorder, errorBorder etc. can be added if needed
      ),
    );
  }
}
