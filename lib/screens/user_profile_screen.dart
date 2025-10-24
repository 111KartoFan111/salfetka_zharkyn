import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/ui/gradient_button.dart'; 
class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    const interests = [
      '🎭 Театр', '☕ Кофе', '📚 Чтение', '🎵 Музыка', '✈️ Путешествия', '🎨 Искусство',
    ];
    const achievementsPreview = ['🎭', '☕', '🏃'];


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Профиль', style: textTheme.displayMedium),
                    IconButton(
                      icon: const Icon(LucideIcons.settings, color: AppTheme.mutedForeground),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // Основной контент (скролл)
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 90.0), // Отступ для навигации
                  children: [
                    // Фото и инфо
                    _buildProfileHeader(context),
                    const SizedBox(height: 24),
                    // Achievements
                    _buildAchievementsPreview(context, achievementsPreview),
                    const SizedBox(height: 24),
                    // About
                    _buildInfoCard(
                      context,
                      title: 'Обо мне',
                      content: 'Люблю технологии, исследовать город, пробовать новые рестораны и ходить на живые концерты. Всегда готов(а) к приключениям!',
                    ),

                    const SizedBox(height: 24),
                    // Interests
                    _buildInterestsCard(context, interests),
                     const SizedBox(height: 24),
                    // Looking For
                    _buildInfoCard(
                      context,
                      title: 'Ищу',
                      content: 'Серьёзные отношения',
                    ),

                    const SizedBox(height: 24),
                    // Кнопка Edit
                    GradientButton(
                      label: 'Редактировать профиль',
                      onPressed: () {},
                      height: 56, // h-14
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: ClipRRect(
         borderRadius: BorderRadius.circular(24), // rounded-3xl
        child: Stack(
          fit: StackFit.expand,
          children: [
             Image.network(
              // TODO: Заменить на реальное фото пользователя
              'https://images.unsplash.com/photo-1560250097-0b93528c311a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwcm9mZXNzaW9uYWwlMjBwb3J0cmFpdHxlbnwxfHx8fDE3NjExNjUyMjJ8MA&ixlib=rb-4.1.0&q=80&w=1080',
              fit: BoxFit.cover,
            ),
             Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            // Кнопка Edit
            Positioned(
              bottom: 16, right: 16,
              child: Container(
                width: 48, height: 48, // w-12 h-12
                decoration: BoxDecoration(
                  color: AppTheme.background.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)]
                ),
                child: const Icon(LucideIcons.camera, color: AppTheme.primary),
              ),
            ),
             Positioned(
              bottom: 16, left: 16,
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Нурдаулет, 18', style: textTheme.displayMedium?.copyWith(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('Software Engineer · Астана', style: textTheme.bodyMedium?.copyWith(color: Colors.white70)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, List<Map<String, dynamic>> stats) {
    final textTheme = Theme.of(context).textTheme;
     return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // rounded-2xl
            side: BorderSide(color: Colors.grey[200]!)
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // p-4
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40, height: 40, // w-10 h-10
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [AppTheme.pink50, AppTheme.purple50]),
                  ),
                  child: Icon(stat['icon'] as IconData, size: 20, color: AppTheme.gradientPurple),
                ),
                const SizedBox(height: 8),
                 ShaderMask(
                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                  child: Text(
                    stat['value'] as String,
                    style: textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                 const SizedBox(height: 4),
                Text(
                  stat['label'] as String,
                  style: textTheme.labelSmall?.copyWith(color: AppTheme.mutedForeground),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAchievementsPreview(BuildContext context, List<String> icons) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 1,
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        side: BorderSide(color: Colors.grey[200]!)
      ),
      child: Padding(
         padding: const EdgeInsets.all(20.0), // p-5
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                  children: [
                    const Icon(LucideIcons.trophy, size: 20, color: AppTheme.gradientPurple),
                    const SizedBox(width: 8),
                    Text('Достижения', style: textTheme.headlineSmall),
                  ],
                ),
                TextButton(
                  onPressed: () { /* Navigate to Achievements */ },
                   style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: ShaderMask(
                    shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                    child: const Text('Посмотреть все', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ...icons.map((icon) => _buildAchievementIcon(icon)).toList(),
                _buildAchievementIcon('+5', isPlaceholder: true),
              ],
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildAchievementIcon(String text, {bool isPlaceholder = false}) {
     return Container(
      width: 56, height: 56, // w-14 h-14
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        gradient: isPlaceholder ? null : const LinearGradient(colors: [AppTheme.pink50, AppTheme.purple50]),
        color: isPlaceholder ? Colors.grey[100] : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: isPlaceholder ? Colors.grey[400] : null),
        ),
      ),
    );
  }

   Widget _buildInfoCard(BuildContext context, {required String title, required String content}) {
     final textTheme = Theme.of(context).textTheme;
     return Card(
       elevation: 1,
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        side: BorderSide(color: Colors.grey[200]!)
      ),
       child: Padding(
         padding: const EdgeInsets.all(20.0), // p-5
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(title, style: textTheme.headlineSmall),
             const SizedBox(height: 8),
             Text(content, style: textTheme.bodyMedium?.copyWith(color: AppTheme.mutedForeground)),
           ],
         ),
       ),
     );
   }

   Widget _buildInterestsCard(BuildContext context, List<String> interests) {
     final textTheme = Theme.of(context).textTheme;
     return Card(
      elevation: 1,
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16), // rounded-2xl
        side: BorderSide(color: Colors.grey[200]!)
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0), // p-5
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text('Интересы', style: textTheme.headlineSmall),
             const SizedBox(height: 12),
             Wrap(
              spacing: 8,
              runSpacing: 8,
              children: interests.map((interest) {
                 return Chip(
                  label: Text(interest, style: textTheme.bodySmall?.copyWith(color: AppTheme.primary)),
                  backgroundColor: AppTheme.purple50, // Mix of pink/purple
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                    side: BorderSide(color: AppTheme.purple50.withAlpha(200)), // border-purple-200
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                );
              }).toList(),
            ),
          ],
        ),
      ),
     );
   }
}
