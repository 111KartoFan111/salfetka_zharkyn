// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/neural_logo_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentSlide = 0;
  final slides = [
    {
      'icon': const NeuralLogoWidget(size: 80),
      'title': 'Добро пожаловать в SoulMatch',
      'description':
          'ИИ-система поиска пары, которая понимает вашу личность, интересы и стиль общения, чтобы найти идеальную пару.',
    },
    {
      'icon': const Icon(LucideIcons.sparkles, size: 60, color: AppTheme.gradientPurple),
      'title': 'Умный ИИ-подбор',
      'description':
          'Наш продвинутый ИИ анализирует совместимость по множеству параметров, чтобы предложить партнеров, которые действительно вам подходят.',
    },
    {
      'icon': const Icon(LucideIcons.calendar, size: 60, color: AppTheme.gradientPink),
      'title': 'Персональные идеи для свиданий',
      'description':
          'Получайте предложения для свиданий, созданные ИИ специально для вас и вашей пары. Зарабатывайте достижения во время совместных приключений!',
    },
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentSlide = page;
    });
  }

  void _onNext() {
    if (_currentSlide < slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Кнопка Skip
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: widget.onComplete,
                  child: Text(
                    'Skip',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ),
              ),

              // Контент (Слайдер)
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: _onPageChanged,
                  itemCount: slides.length,
                  itemBuilder: (context, index) {
                    final slide = slides[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (slide['icon'] as Widget),
                          const SizedBox(height: 32),
                          // Заголовок с градиентом
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppTheme.primaryGradient.createShader(bounds),
                            child: Text(
                              slide['title'] as String,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(color: Colors.white), // Цвет будет заменен градиентом
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            slide['description'] as String,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Индикатор (точки)
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: slides.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: AppTheme.gradientPurple, // Используем один из цветов градиента
                    dotColor: Color(0xFFD6D6D6), // bg-gray-300
                    expansionFactor: 4,
                  ),
                ),
              ),

              // Кнопка Next
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0).copyWith(bottom: 24.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      _currentSlide == slides.length - 1
                          ? 'Начать'
                          : 'Далее',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
