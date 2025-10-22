// lib/screens/matches_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';

class MatchesScreen extends StatelessWidget {
  final Function(UserProfile) onMatchClick;
  const MatchesScreen({super.key, required this.onMatchClick});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Данные пока возьмем из AppState, как и в SwipeScreen
    final matches = context.watch<AppState>().mockProfiles;

    // TODO: Добавить реальные данные для matches, включая newMatch
    final demoMatches = matches.map((p) => {
      'profile': p,
      'newMatch': p.name == 'Emma' || p.name == 'Ryan', // Пример
    }).toList();


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          bottom: false, // Отключаем нижний SafeArea, т.к. есть NavigationBar
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Хедер
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Matches', style: textTheme.displayMedium),
                    const SizedBox(height: 8),
                    Text(
                      '${demoMatches.length} connections',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppTheme.mutedForeground),
                    ),
                  ],
                ),
              ),
              // Сетка мэтчей
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 90.0), // Отступ снизу для навигации
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: demoMatches.length,
                  itemBuilder: (context, index) {
                    final matchData = demoMatches[index];
                    final profile = matchData['profile'] as UserProfile;
                    final isNew = matchData['newMatch'] as bool;

                    return _buildMatchCard(context, profile, isNew, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchCard(BuildContext context, UserProfile profile, bool isNew, int index) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => onMatchClick(profile),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24), // rounded-3xl
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Изображение
            Image.network(
              profile.image,
              fit: BoxFit.cover,
            ).animate().scale(delay: (index * 50).ms, duration: 300.ms), // Анимация
            // Градиент
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // New match badge
            if (isNew)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Row(
                    children: [
                      Icon(LucideIcons.heart, size: 12, color: Colors.white),
                      SizedBox(width: 4),
                      Text('New', style: TextStyle(fontSize: 12, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            // Match percentage
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.background.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ShaderMask(
                  shaderCallback: (bounds) =>
                      AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    '${profile.compatibility}%',
                    style: textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Инфо внизу
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${profile.name}, ${profile.age}',
                    style: textTheme.headlineSmall?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: () => onMatchClick(profile), // Может, сразу в чат?
                    icon: const Icon(LucideIcons.messageCircle, size: 16, color: Colors.white),
                    label: const Text('Message', style: TextStyle(color: Colors.white, fontSize: 14)),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      side: BorderSide(color: Colors.white.withOpacity(0.3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      minimumSize: const Size(double.infinity, 36), // Занять всю ширину
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms, duration: 300.ms).moveY(begin: 20); // Анимация
  }
}
