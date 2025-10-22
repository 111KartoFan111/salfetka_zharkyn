// lib/screens/profile_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/ui/gradient_button.dart'; // Предполагаем, что создали

class ProfileDetailScreen extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onBack;
  final VoidCallback onMessage;

  const ProfileDetailScreen({
    super.key,
    required this.profile,
    required this.onBack,
    required this.onMessage,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const interests = ['🎭 Theater', '☕ Coffee', '📚 Reading', '🎵 Music', '✈️ Travel']; // Мок-данные

    return Scaffold(
      body: Stack(
        children: [
          // Основной контент (скролл)
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                // AppBar с изображением
                SliverAppBar(
                  expandedHeight: 384, // h-96
                  pinned: false,
                  stretch: true,
                  backgroundColor: AppTheme.background,
                  automaticallyImplyLeading: false, // Убираем стандартную кнопку назад
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(profile.image, fit: BoxFit.cover),
                        // Градиент
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black.withOpacity(0.6), Colors.transparent, Colors.black.withOpacity(0.2)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                        // Имя и инфо
                        Positioned(
                          bottom: 24, left: 24, right: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${profile.name}, ${profile.age}', style: textTheme.displayMedium?.copyWith(color: Colors.white)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(LucideIcons.briefcase, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(profile.occupation, style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
                                  const SizedBox(width: 16),
                                  const Icon(LucideIcons.mapPin, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(profile.location, style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // % Match badge
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 16, // Учитываем статус-бар
                          right: 24,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppTheme.background.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Row(
                              children: [
                                const Icon(LucideIcons.sparkles, size: 16, color: AppTheme.gradientPurple),
                                const SizedBox(width: 8),
                                ShaderMask(
                                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                                  child: Text(
                                    '${profile.compatibility}% Match',
                                    style: textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    stretchModes: const [StretchMode.zoomBackground],
                  ),
                ),
                // Контент под AppBar
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 100.0), // Отступ для кнопок внизу
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      _buildSection(context, title: 'About', child: Text(profile.bio, style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground))),
                      const SizedBox(height: 24),
                      _buildSection(context, title: 'Interests', child: _buildInterestsWrap(context, interests)),
                       const SizedBox(height: 24),
                      _buildSection(context, title: 'Compatibility Breakdown', child: _buildCompatibilityBars(context)),
                      const SizedBox(height: 24),
                      _buildAIDateSuggestion(context),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          // Кнопка Назад
           Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              left: 24,
              child: Container(
                width: 40, height: 40, // w-10 h-10
                decoration: BoxDecoration(
                  color: AppTheme.background.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(LucideIcons.chevronLeft, color: AppTheme.primary),
                  onPressed: onBack,
                  padding: EdgeInsets.zero,
                  tooltip: 'Back',
                ),
              ),
            ),
          // Кнопки внизу
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.of(context).padding.bottom + 12),
              decoration: BoxDecoration(
                color: AppTheme.background,
                border: Border(top: BorderSide(color: Colors.grey[200]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () { /* Handle Like */ },
                      icon: const Icon(LucideIcons.heart, size: 20, color: AppTheme.gradientPink),
                      label: const Text('Like'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(0, 56), // h-14
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        side: const BorderSide(color: AppTheme.gradientPink, width: 2),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GradientButton(
                      onPressed: onMessage,
                      label: 'Message',
                      icon: LucideIcons.messageCircle,
                      height: 56, // h-14
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

 Widget _buildInterestsWrap(BuildContext context, List<String> interests) {
   return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: interests.map((interest) {
          return Chip(
          label: Text(interest, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.primary)),
          backgroundColor: AppTheme.purple50, // Mix of pink/purple
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: AppTheme.purple50.withAlpha(200)), // border-purple-200
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        );
      }).toList(),
    );
  }

  Widget _buildCompatibilityBars(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
     final items = [
      {'label': 'Interests', 'value': 95, 'color1': AppTheme.gradientPink, 'color2': AppTheme.gradientPink.withAlpha(200)},
      {'label': 'Communication Style', 'value': 92, 'color1': AppTheme.gradientPink.withAlpha(200), 'color2': AppTheme.gradientPurple.withAlpha(200)},
      {'label': 'Life Goals', 'value': 88, 'color1': AppTheme.gradientPurple.withAlpha(200), 'color2': AppTheme.gradientPurple},
    ];

    return Column(
      children: items.map((item) {
        final value = item['value'] as int;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item['label'] as String, style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground)),
                  ShaderMask(
                    shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                    child: Text('$value%', style: textTheme.bodyMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              ClipRRect(
                 borderRadius: BorderRadius.circular(100),
                child: LinearProgressIndicator(
                  value: value / 100,
                  minHeight: 8, // h-2
                  backgroundColor: Colors.grey[100],
                   valueColor: AlwaysStoppedAnimation<Color>(item['color1'] as Color), // Упрощенный градиент
                  // TODO: Реализовать градиентную полоску
                ).animate().slideX(begin: -1, duration: 1.seconds, delay: 200.ms, curve: Curves.easeOut),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAIDateSuggestion(BuildContext context) {
     final textTheme = Theme.of(context).textTheme;
     return Container(
      padding: const EdgeInsets.all(16), // p-4
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppTheme.pink50, AppTheme.purple50]),
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        border: Border.all(color: AppTheme.purple50.withAlpha(200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: const Icon(LucideIcons.sparkles, size: 20, color: AppTheme.gradientPurple),
          ),
           const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI Suggested First Date', style: textTheme.headlineSmall),
                const SizedBox(height: 4),
                Text(
                  'Visit a contemporary art gallery followed by coffee at a cozy café. Perfect for meaningful conversations!',
                  style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
