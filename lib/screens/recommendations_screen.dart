// lib/screens/recommendations_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/ui/gradient_button.dart'; // Предполагаем, что создали кастомную кнопку

class RecommendationsScreen extends StatelessWidget {
  final Function(UserProfile) onProfileClick;
  const RecommendationsScreen({super.key, required this.onProfileClick});

  // Мок-данные, как в React-компоненте
  final List<Map<String, dynamic>> topMatches = const [
    {
      'id': '1',
      'name': 'Emma',
      'age': 26,
      'image': 'https://images.unsplash.com/photo-1675705445381-db30ca7834de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHlvdW5nJTIwd29tYW58ZW58MXx8fHwxNzYxMDgwMTgyfDA&ixlib=rb-4.1.0&q=80&w=1080',
      'location': 'New York',
      'compatibility': 92,
      'dateIdea': '🎨 Visit a contemporary art gallery',
      'reason': 'You both love art and creative expression',
    },
    {
      'id': '2',
      'name': 'Ryan',
      'age': 29,
      'image': 'https://images.unsplash.com/photo-1656582117510-3a177bf866c3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxoYXBweSUyMHBlcnNvbiUyMHBvcnRyYWl0fGVufDF8fHx8MTc2MTA3NzYwNnww&ixlib=rb-4.1.0&q=80&w=1080',
      'location': 'Queens',
      'compatibility': 90,
      'dateIdea': '📸 Photography walk in Central Park',
      'reason': 'Shared interest in photography and nature',
    },
    {
      'id': '3',
      'name': 'Alex',
      'age': 28,
      'image': 'https://images.unsplash.com/photo-1596690097396-bb75a1d6c807?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHlvdW5nJTIwbWFufGVufDF8fHx8MTc2MTEyMjkwNXww&ixlib=rb-4.1.0&q=80&w=1080',
      'location': 'Brooklyn',
      'compatibility': 88,
      'dateIdea': '🍳 Cooking class and dinner',
      'reason': 'Both passionate about food and cooking',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Находим реальные профили по ID (или используем мок-данные напрямую)
    final profiles = context.read<AppState>().mockProfiles;
    final matchProfiles = topMatches.map((matchData) {
       final profile = profiles.firstWhere((p) => p.id == matchData['id'], orElse: () => profiles.first); // Fallback
       return {'data': matchData, 'profile': profile};
    }).toList();


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Хедер
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(LucideIcons.sparkles,
                            size: 28, color: AppTheme.gradientPurple),
                        const SizedBox(width: 8),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppTheme.primaryGradient.createShader(bounds),
                          child: Text(
                            'AI Recommendations',
                            style: textTheme.displayMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your top matches for today',
                      style: textTheme.bodyLarge
                          ?.copyWith(color: AppTheme.mutedForeground),
                    ),
                  ],
                ),
              ),
              // Список рекомендаций
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 90.0), // Отступ для навигации
                  itemCount: matchProfiles.length + 1, // +1 для сообщения в конце
                  itemBuilder: (context, index) {
                    if (index == matchProfiles.length) {
                      return _buildEndOfList(context);
                    }
                    final match = matchProfiles[index]['data'] as Map<String, dynamic>;
                    final profile = matchProfiles[index]['profile'] as UserProfile;
                    return _buildRecommendationCard(context, match, profile, index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, Map<String, dynamic> match, UserProfile profile, int index) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)), // rounded-3xl
      clipBehavior: Clip.antiAlias, // Для обрезки изображения
      child: Column(
        children: [
          // Изображение с оверлеями
          SizedBox(
            height: 256, // h-64
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(match['image'], fit: BoxFit.cover),
                // Градиент
                 Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                // Ранг
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    width: 48, height: 48, // w-12 h-12
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.primaryGradient,
                      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6)]
                    ),
                    child: Center(
                      child: Text('#${index + 1}', style: textTheme.titleLarge?.copyWith(color: Colors.white)),
                    ),
                  ),
                ),
                // % Match
                 Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.background.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8, height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppTheme.primaryGradient,
                          ),
                          // TODO: Добавить анимацию пульсации
                        ),
                        const SizedBox(width: 8),
                        ShaderMask(
                          shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                          child: Text(
                            '${match['compatibility']}%',
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Инфо внизу
                Positioned(
                  bottom: 16, left: 16, right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${match['name']}, ${match['age']}', style: textTheme.headlineMedium?.copyWith(color: Colors.white)),
                      const SizedBox(height: 4),
                       Row(
                        children: [
                          const Icon(LucideIcons.mapPin, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(match['location'], style: textTheme.bodySmall?.copyWith(color: Colors.white70)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Контент под фото
          Padding(
            padding: const EdgeInsets.all(20), // p-5
            child: Column(
              children: [
                // AI Suggestion
                Container(
                  padding: const EdgeInsets.all(12), // p-3
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppTheme.pink50, AppTheme.purple50]),
                    borderRadius: BorderRadius.circular(16), // rounded-2xl
                    border: Border.all(color: AppTheme.purple50.withAlpha(200)), // border-purple-200
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Icon(LucideIcons.sparkles, size: 16, color: AppTheme.gradientPurple),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(match['dateIdea'], style: textTheme.bodyMedium),
                            const SizedBox(height: 4),
                            Text(match['reason'], style: textTheme.bodySmall?.copyWith(color: AppTheme.mutedForeground)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Кнопки
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () { /* Handle Like */ },
                        icon: const Icon(LucideIcons.heart, size: 18, color: AppTheme.gradientPink),
                        label: const Text('Like'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 44), // h-11
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          side: BorderSide(color: Colors.grey[300]!, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GradientButton( // Используем кастомную кнопку
                        onPressed: () => onProfileClick(profile),
                        label: 'View Profile',
                        icon: LucideIcons.messageCircle,
                        height: 44, // h-11
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: (index * 100).ms, duration: 400.ms).moveY(begin: 30);
  }

  Widget _buildEndOfList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        children: [
          Text(
            "That's all for today!",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground),
          ),
          const SizedBox(height: 8),
          Text(
            "Check back tomorrow for fresh recommendations",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }
}
