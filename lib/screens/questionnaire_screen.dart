// lib/screens/questionnaire_screen.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/theme.dart';

class QuestionnaireScreen extends StatefulWidget {
  final VoidCallback onComplete;
  const QuestionnaireScreen({super.key, required this.onComplete});

  @override
  State<QuestionnaireScreen> createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final _pageController = PageController();
  int _step = 0;
  final int _totalSteps = 5;

  void _nextStep() {
    if (_step < _totalSteps - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onComplete();
    }
  }

  void _prevStep() {
    if (_step > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_step > 0)
                          IconButton(
                            icon: const Icon(LucideIcons.chevronLeft,
                                color: AppTheme.mutedForeground),
                            onPressed: _prevStep,
                          )
                        else
                          const SizedBox(width: 48), // Placeholder
                        Text(
                          '${_step + 1} of $_totalSteps',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.mutedForeground),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Прогресс-бар
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(
                        begin: (_step) / _totalSteps,
                        end: (_step + 1) / _totalSteps,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.grey[200],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppTheme.gradientPurple),
                          borderRadius: BorderRadius.circular(100),
                          minHeight: 8,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Контент
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(), // Запрет свайпа
                  onPageChanged: (page) {
                    setState(() {
                      _step = page;
                    });
                  },
                  children: [
                    _buildStep(
                      title: 'Загрузите свои фотографии',
                      subtitle: 'Добавьте как минимум 3 фото',
                      content: _buildPhotoGrid(),
                    ),
                    _buildStep(
                      title: 'О себе',
                      subtitle: 'Расскажите немного о себе',
                      content: _buildAboutForm(),
                    ),
                    _buildStep(
                      title: 'Ваши интересы',
                      subtitle: 'Выберите то, что вам нравится',
                      content: _buildInterestsGrid(),
                    ),
                    _buildStep(
                      title: 'Цели в отношениях',
                      subtitle: 'Что вы ищете?',
                      content: _buildGoalsList(),
                    ),
                    _buildStep(
                      title: 'Тип личности',
                      subtitle: 'Как бы вы себя описали?',
                      content: _buildPersonalityList(),
                    ),
                  ],
                ),
              ),
              // Кнопка
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
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Text(
                      _step == _totalSteps - 1 ? 'Complete' : 'Continue',
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

  Widget _buildStep(
      {required String title,
      required String subtitle,
      required Widget content}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppTheme.mutedForeground),
          ),
          const SizedBox(height: 24),
          content,
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.pink50, AppTheme.purple50],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(LucideIcons.upload, color: Colors.grey[400]),
        );
      },
    );
  }

  Widget _buildAboutForm() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Ваше имя',
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Ваш возраст',
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            hintText: 'Расскажите немного о себе...',
            fillColor: AppTheme.background,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          maxLines: 4,
          minLines: 4,
        ),
      ],
    );
  }

  Widget _buildInterestsGrid() {
    const interests = [
      '🎭 Театр' , '☕ Кофе' , '🏃 Спорт' , '🎨 Искусство',
      '📚 Чтение' , '🎵 Музыка' , '🍕 Еда' , '✈️ Путешествия',
      '🎮 Игры' , '🧘 Йога' , '🎬 Кино' , '🌿 Природа',
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: interests.map((interest) {
        return OutlinedButton(
          onPressed: () {}, // Добавь логику выбора
          style: OutlinedButton.styleFrom(
            backgroundColor: AppTheme.background,
            side: BorderSide(color: Colors.grey[300]!, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(interest),
        );
      }).toList(),
    );
  }
  
  Widget _buildGoalsList() {
    const goals = [
      'Ищу что-то настоящее ❤️',
      'Весело провести время 😜',
      'Познакомиться с новыми людьми 👋',
      'Сам(а) ещё не понял(а) 🤔',
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        return OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: AppTheme.background,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          ),
          child: Text(goals[index]),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }

  Widget _buildPersonalityList() {
    const types = [
      {'label': 'Интроверт', 'emoji': '🤫'},
      {'label': 'Экстраверт', 'emoji': '🎉'},
      {'label': 'Амбиверт', 'emoji': '🎭'},
      {'label': 'Креативный', 'emoji': '🎨'},
      {'label': 'Аналитичный', 'emoji': '🧠'},
      {'label': 'Авантюрный', 'emoji': '🗺️'},
    ];
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: types.length,
      itemBuilder: (context, index) {
        return OutlinedButton.icon(
          onPressed: () {},
          icon: Text(types[index]['emoji']!, style: const TextStyle(fontSize: 24)),
          label: Text(types[index]['label']!),
          style: OutlinedButton.styleFrom(
            backgroundColor: AppTheme.background,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
