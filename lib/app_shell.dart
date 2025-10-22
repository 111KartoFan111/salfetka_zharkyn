// lib/app_shell.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/screens/onboarding_screen.dart';
import 'package:soulmatch/screens/login_screen.dart';
import 'package:soulmatch/screens/questionnaire_screen.dart';
import 'package:soulmatch/screens/swipe_screen.dart';
import 'package:soulmatch/screens/matches_screen.dart';
import 'package:soulmatch/screens/recommendations_screen.dart';
import 'package:soulmatch/screens/user_profile_screen.dart';
import 'package:soulmatch/screens/profile_detail_screen.dart';
import 'package:soulmatch/screens/chat_screen.dart';
import 'package:soulmatch/widgets/app_bottom_navigation.dart';

// Этот виджет заменяет App.tsx
// Он слушает AppState и отображает нужный экран
class AppShell extends StatelessWidget {
  AppShell({super.key});

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // Получаем текущее состояние экрана
    final appScreen = context.watch<AppState>().currentScreen;

    // Экраны, на которых должна отображаться нижняя навигация
    const screensWithNav = [
      AppScreen.home,
      AppScreen.matches,
      AppScreen.chats,
      AppScreen.profile,
    ];

    bool showNavigation = screensWithNav.contains(appScreen);

    return Scaffold(
      body: _buildScreen(context, appScreen),
      bottomNavigationBar:
          showNavigation ? const AppBottomNavigation() : null,
    );
  }

  // Метод-помощник для выбора экрана
  // Используем PageView или AnimatedSwitcher для анимаций, как в motion/react
  Widget _buildScreen(BuildContext context, AppScreen screen) {
    final appState = context.read<AppState>();

    // Используем AnimatedSwitcher для плавных переходов
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Анимация появления/исчезновения
        return FadeTransition(opacity: animation, child: child);
      },
      child: KeepAlivePage(
        // Используем Key, чтобы AnimatedSwitcher понимал, что виджет изменился
        key: ValueKey<AppScreen>(screen),
        child: switch (screen) {
          AppScreen.onboarding => OnboardingScreen(
              onComplete: appState.completeOnboarding,
            ),
          AppScreen.login => LoginScreen(
              onLogin: appState.login,
            ),
          AppScreen.questionnaire => QuestionnaireScreen(
              onComplete: appState.completeQuestionnaire,
            ),
          AppScreen.home => SwipeScreen(
              onProfileClick: appState.selectProfile,
            ),
          AppScreen.matches => MatchesScreen(
              onMatchClick: appState.selectProfile,
            ),
          // В React-проекте 'chats' ведет на 'RecommendationsScreen'
          AppScreen.chats => RecommendationsScreen(
              onProfileClick: appState.selectProfile,
            ),
          AppScreen.profile => const UserProfileScreen(),
          AppScreen.profileDetail => ProfileDetailScreen(
              profile: appState.selectedProfile!,
              onBack: appState.backToMain,
              onMessage: appState.messageFromProfile,
            ),
          AppScreen.chat => ChatScreen(
              profile: appState.selectedProfile!,
              onBack: appState.backToMain,
            ),
          // Добавь остальные экраны по аналогии
          _ => Center(child: Text('Экран не найден: $screen')),
        },
      ),
    );
  }
}

// Вспомогательный виджет, чтобы экраны не "умирали" при переключении
class KeepAlivePage extends StatefulWidget {
  final Widget child;
  const KeepAlivePage({required Key key, required this.child}) : super(key: key);

  @override
  State<KeepAlivePage> createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context); // Важно для AutomaticKeepAliveClientMixin
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
