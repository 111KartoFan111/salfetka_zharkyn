import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/neural_logo_widget.dart';
import 'package:soulmatch/widgets/swipe_card.dart';

class SwipeScreen extends StatefulWidget {
  final Function(UserProfile) onProfileClick;
  const SwipeScreen({super.key, required this.onProfileClick});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final CardSwiperController _controller = CardSwiperController();
  late List<UserProfile> _profiles;
  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _profiles = context.watch<AppState>().mockProfiles;
  }
  
  bool _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    setState(() {
      _currentIndex = currentIndex ?? 0;
    });
    
    if (direction == CardSwiperDirection.right && _profiles[previousIndex].name == 'Мариям') {
      widget.onProfileClick(_profiles[previousIndex]);
    }
    return true; 
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.backgroundGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Хедер
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const NeuralLogoWidget(size: 40),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppTheme.primaryGradient.createShader(bounds),
                      child: Text(
                        'SoulMatch',
                        style: textTheme.displaySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.info,
                          color: AppTheme.mutedForeground),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              // Карточки
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: _profiles.isEmpty
                      ? _buildNoMoreCards()
                      : CardSwiper(
                          controller: _controller,
                          cardsCount: _profiles.length,
                          onSwipe: _onSwipe,
                          onEnd: () {
                             setState(() {
                               _currentIndex = _profiles.length;
                             });
                          },
                          numberOfCardsDisplayed: 2,
                          backCardOffset: const Offset(0, 20),
                          padding: const EdgeInsets.only(bottom: 40),
                          cardBuilder: (
                            context,
                            index,
                            horizontalThresholdPercentage,
                            verticalThresholdPercentage,
                          ) {
                            return SwipeCard(profile: _profiles[index]);
                          },
                        ),
                ),
              ),

              if (_currentIndex < _profiles.length)
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0, top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: LucideIcons.x,
                        color: Colors.red[500]!,
                        size: 64,
                        onPressed: () => _controller.swipe(CardSwiperDirection.left),
                      ),
                      _buildActionButton(
                        icon: LucideIcons.star,
                        color: AppTheme.gradientPurple,
                        size: 80,
                        isGradient: true,
                        onPressed: () => _controller.swipe(CardSwiperDirection.top),
                      ),
                      _buildActionButton(
                        icon: LucideIcons.heart,
                        color: Colors.green[500]!,
                        size: 64,
                        onPressed: () => _controller.swipe(CardSwiperDirection.right),
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

  Widget _buildNoMoreCards() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NeuralLogoWidget(size: 60),
          const SizedBox(height: 16),
          Text(
            'У вас пока нет новых совпадений',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: AppTheme.mutedForeground),
          ),
          const SizedBox(height: 8),
          Text(
            'Зайдите позже, чтобы увидеть новых людей',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required double size,
    required VoidCallback onPressed,
    bool isGradient = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isGradient ? null : AppTheme.background,
        gradient: isGradient ? AppTheme.primaryGradient : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
        border: isGradient
            ? null
            : Border.all(color: Colors.grey[200]!, width: 2),
      ),
      child: IconButton(
        icon: Icon(icon, color: isGradient ? Colors.white : color),
        iconSize: size * 0.45,
        onPressed: onPressed,
      ),
    );
  }
}
