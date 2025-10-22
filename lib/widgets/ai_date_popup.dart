// lib/widgets/ai_date_popup.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/ui/gradient_button.dart';

class AIDatePopup extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onLater;
  final VoidCallback onClose;

  const AIDatePopup({
    super.key,
    required this.onAccept,
    required this.onLater,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent, // Делаем фон диалога прозрачным
      insetPadding: const EdgeInsets.all(16.0), // p-4
      alignment: Alignment.bottomCenter, // Выравниваем по низу
      child: Container(
        padding: const EdgeInsets.all(24), // p-6
        decoration: BoxDecoration(
          color: AppTheme.background,
          borderRadius: BorderRadius.circular(24), // rounded-3xl
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)], // shadow-2xl
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Занимать минимально необх. высоту
          children: [
            // AI Иконка
            Container(
              width: 64, height: 64, // w-16 h-16
              margin: const EdgeInsets.only(bottom: 16),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
              ),
              child: const Icon(LucideIcons.sparkles, size: 32, color: Colors.white),
            ),
            // Контент
            Text('AI Suggests', style: textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(
              'Based on your shared interests and compatibility:',
              style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Карточка с идеей
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppTheme.pink50, AppTheme.purple50]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.purple50.withAlpha(200)),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🎭', style: TextStyle(fontSize: 30)),
                      SizedBox(width: 8),
                      Text('Go to the theater', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)), // h4 equivalent
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row( // Обертка для центрирования
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('Earn the ', style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground)),
                       ShaderMask(
                         shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                         child: const Text('Literary Route', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                       ),
                       Text(' achievement', style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground)),
                    ],
                  )
                ],
              ),
            ),
             const SizedBox(height: 24),
            // Детали
            _buildDateDetail('Catch a Broadway show this weekend'),
            _buildDateDetail('Dinner at a nearby restaurant afterward'),
            _buildDateDetail('Perfect for deep conversations'),
            const SizedBox(height: 24),
            // Кнопки
            GradientButton(
              onPressed: onAccept,
              label: 'Accept & Send',
              height: 48, // h-12
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onLater,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48), // h-12
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                side: BorderSide(color: Colors.grey[300]!),
              ),
              child: const Text('Maybe Later'),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).moveY(begin: 100, end: 0, duration: 300.ms, curve: Curves.easeOut); // Анимация
  }

  Widget _buildDateDetail(String text) {
     return Padding(
       padding: const EdgeInsets.only(bottom: 8.0),
       child: Row(
        children: [
          Container(
            width: 6, height: 6, // w-1.5 h-1.5
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14, color: AppTheme.mutedForeground))),
        ],
           ),
     );
  }
}
