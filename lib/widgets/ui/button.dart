// lib/widgets/ui/button.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/theme.dart';

enum AppButtonVariant { primary, outline, secondary, ghost, destructive }
enum AppButtonSize { standard, small, large, icon }

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final String? label; // Alternative to child for simple text
  final IconData? icon;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final double borderRadius;
  final bool isDisabled;

  const AppButton({
    super.key,
    required this.onPressed,
    this.child,
    this.label,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.standard,
    this.borderRadius = 100.0, // rounded-full default
    this.isDisabled = false,
  }) : assert(child != null || label != null, 'Either child or label must be provided');


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = _getButtonStyle(context);
    final Widget buttonContent = child ?? _buildButtonContent(context);

    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.destructive: // Needs specific styling in _getButtonStyle
      case AppButtonVariant.secondary: // Needs specific styling in _getButtonStyle
        return ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: buttonContent,
        );
      case AppButtonVariant.outline:
      case AppButtonVariant.ghost: // Needs specific styling in _getButtonStyle
        return OutlinedButton(
          onPressed: isDisabled ? null : onPressed,
          style: style,
          child: buttonContent,
        );
      // case AppButtonVariant.link: // Use TextButton
      default:
        return ElevatedButton(
           onPressed: isDisabled ? null : onPressed,
           style: style,
           child: buttonContent,
        );
    }
  }

  Widget _buildButtonContent(BuildContext context) {
     final iconSize = size == AppButtonSize.small ? 16.0 : (size == AppButtonSize.large ? 24.0 : 20.0);
     final textColor = _getTextColor(context);

     return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Important for icon-only buttons
          children: [
            if (icon != null && size != AppButtonSize.icon) ...[
              Icon(icon, color: textColor, size: iconSize),
              const SizedBox(width: 8), // gap-2
            ],
             if (icon != null && size == AppButtonSize.icon)
              Icon(icon, color: textColor, size: iconSize),
            if (label != null && size != AppButtonSize.icon)
              Flexible( // Use Flexible to prevent overflow if label is long
                child: Text(
                  label!,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: _getFontSize(context),
                  ),
                   overflow: TextOverflow.ellipsis, // Add ellipsis if text is too long
                ),
              ),
          ],
        );
  }

  double _getFontSize(BuildContext context) {
     switch (size) {
        case AppButtonSize.small:
         return Theme.of(context).textTheme.bodySmall?.fontSize ?? 12.0;
        case AppButtonSize.large:
          return Theme.of(context).textTheme.bodyLarge?.fontSize ?? 16.0;
        case AppButtonSize.standard:
        case AppButtonSize.icon:
        default:
         return Theme.of(context).textTheme.labelLarge?.fontSize ?? 14.0; // Usually button text is slightly smaller or same as bodyLarge
     }
  }

   Color _getTextColor(BuildContext context) {
     switch(variant) {
        case AppButtonVariant.primary:
          return AppTheme.primaryForeground;
        case AppButtonVariant.destructive:
          return Colors.white; // text-white
        case AppButtonVariant.secondary:
          return AppTheme.secondary; // secondary-foreground
        case AppButtonVariant.outline:
        case AppButtonVariant.ghost:
        default:
         return AppTheme.primary; // foreground
     }
   }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return icon != null
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8) // px-2.5 equivalent
            : const EdgeInsets.symmetric(horizontal: 12, vertical: 8); // px-3
      case AppButtonSize.large:
         return icon != null
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 12) // px-4
            : const EdgeInsets.symmetric(horizontal: 24, vertical: 12); // px-6
       case AppButtonSize.icon:
        return EdgeInsets.zero; // No padding for icon button
      case AppButtonSize.standard:
      default:
        return icon != null
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 10) // px-3
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 10); // px-4
    }
  }

  Size _getMinSize() {
     switch(size) {
        case AppButtonSize.small: return const Size(0, 32); // h-8
        case AppButtonSize.large: return const Size(0, 40); // h-10
        case AppButtonSize.icon: return const Size(36, 36); // size-9
        case AppButtonSize.standard:
        default: return const Size(0, 36); // h-9
     }
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    Color backgroundColor = AppTheme.primary;
    Color foregroundColor = _getTextColor(context);
    BorderSide borderSide = BorderSide.none;
    double elevation = 2;

    switch (variant) {
      case AppButtonVariant.primary:
        backgroundColor = AppTheme.primary;
        foregroundColor = AppTheme.primaryForeground;
        break;
      case AppButtonVariant.destructive:
        backgroundColor = AppTheme.destructive;
        foregroundColor = Colors.white;
        break;
      case AppButtonVariant.secondary:
        backgroundColor = AppTheme.secondary;
        foregroundColor = AppTheme.primary; // secondary-foreground
        elevation = 0;
        break;
      case AppButtonVariant.outline:
        backgroundColor = AppTheme.background;
        foregroundColor = AppTheme.primary; // foreground
        borderSide = BorderSide(color: Colors.grey[300]!); // border
        elevation = 0;
        break;
      case AppButtonVariant.ghost:
         backgroundColor = Colors.transparent;
         foregroundColor = AppTheme.primary; // foreground
         elevation = 0;
        break;
       default:
        break;
    }

    // Hover/Focus/Pressed states - Material 3 handles some defaults
    final overlayColor = MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          if (variant == AppButtonVariant.primary || variant == AppButtonVariant.destructive) {
             return Colors.white.withOpacity(0.1); // Slightly lighter overlay
          } else {
             return AppTheme.accent.withOpacity(0.5); // accent hover
          }
        }
        if (states.contains(MaterialState.pressed)) {
           if (variant == AppButtonVariant.primary || variant == AppButtonVariant.destructive) {
             return Colors.white.withOpacity(0.2); // More pronounced overlay
          } else {
             return AppTheme.accent; // accent pressed
          }
        }
        return null; // Defer to the default
      },
    );


    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return backgroundColor.withOpacity(0.5);
          }
          return backgroundColor;
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
         (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return foregroundColor.withOpacity(0.5);
          }
          return foregroundColor;
        },
      ),
      elevation: MaterialStateProperty.resolveWith<double>(
         (Set<MaterialState> states) {
             if (states.contains(MaterialState.pressed)) return elevation / 2;
             if (states.contains(MaterialState.disabled)) return 0;
             return elevation;
         }
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(_getPadding()),
      minimumSize: MaterialStateProperty.all<Size>(_getMinSize()),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      side: MaterialStateProperty.all<BorderSide>(borderSide),
      overlayColor: overlayColor,
      // For focus ring (approximated with overlay)
       visualDensity: VisualDensity.standard, // Ensure consistent sizing
       tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce extra padding
    );
  }
}
