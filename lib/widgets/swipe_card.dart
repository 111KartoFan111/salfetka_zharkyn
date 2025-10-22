// lib/widgets/swipe_card.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';

class SwipeCard extends StatelessWidget {
  final UserProfile profile;
  const SwipeCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24), // rounded-3xl
        color: AppTheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: 2,
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Column(
          children: [
            // Изображение
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    profile.image,
                    fit: BoxFit.cover,
                  ),
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
                  // % Match
                  Positioned(
                    top: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.background.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppTheme.primaryGradient,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppTheme.primaryGradient.createShader(bounds),
                            child: Text(
                              '${profile.compatibility}% Match',
                              style: textTheme.bodyMedium?.copyWith(
                                color: Colors.white, // Заменится градиентом
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
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${profile.name}, ${profile.age}',
                          style: textTheme.displayMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(LucideIcons.briefcase,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              profile.occupation,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(width: 16),
                            const Icon(LucideIcons.mapPin,
                                color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              profile.location,
                              style: textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Био
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Text(
                  profile.bio,
                  style: textTheme.bodyLarge
                      ?.copyWith(color: AppTheme.mutedForeground),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
