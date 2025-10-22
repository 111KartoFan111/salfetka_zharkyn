// lib/state/app_state.dart
import 'package:flutter/material.dart';

// Перечисление для всех экранов, как в App.tsx
enum AppScreen {
  onboarding,
  login,
  questionnaire,
  home,
  matches,
  chats, // В React-проекте это 'chats', но ведет на 'RecommendationsScreen'
  profile,
  profileDetail,
  chat,
  achievements
  // recommendations не нужен, так как 'chats' ведет на него
}

// Модель профиля (упрощенная)
class UserProfile {
  final String id;
  final String name;
  final int age;
  final String image;
  final String location;
  final String occupation;
  final String bio;
  final int compatibility;

  UserProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.image,
    required this.location,
    required this.occupation,
    required this.bio,
    required this.compatibility,
  });
}

// Это наш главный класс для управления состоянием, эквивалент React-хуков в App.tsx
class AppState extends ChangeNotifier {
  // Текущий отображаемый экран
  AppScreen _currentScreen = AppScreen.onboarding;
  AppScreen get currentScreen => _currentScreen;

  // Текущая вкладка в нижней навигации
  AppScreen _navigationTab = AppScreen.home;
  AppScreen get navigationTab => _navigationTab;

  // Выбранный профиль для детального просмотра или чата
  UserProfile? _selectedProfile;
  UserProfile? get selectedProfile => _selectedProfile;

  // Мок-данные для профилей
  final List<UserProfile> mockProfiles = [
    UserProfile(
      id: '1',
      name: 'Emma',
      age: 26,
      image: 'https://images.unsplash.com/photo-1675705445381-db30ca7834de?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHlvdW5nJTIwd29tYW58ZW58MXx8fHwxNzYxMDgwMTgyfDA&ixlib=rb-4.1.0&q=80&w=1080',
      location: 'New York',
      occupation: 'Designer',
      bio: 'Love art galleries and weekend coffee adventures ☕🎨',
      compatibility: 92,
    ),
    UserProfile(
      id: '2',
      name: 'Alex',
      age: 28,
      image: 'https://images.unsplash.com/photo-1596690097396-bb75a1d6c807?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwb3J0cmFpdCUyMHlvdW5nJTIwbWFufGVufDF8fHx8MTc2MTEyMjkwNXww&ixlib=rb-4.1.0&q=80&w=1080',
      location: 'Brooklyn',
      occupation: 'Software Engineer',
      bio: 'Tech enthusiast, hiking lover, and amateur chef 🏔️👨‍🍳',
      compatibility: 88,
    ),
    // ... (добавь остальные профили)
  ];

  // --- Методы для изменения состояния ---

  // Завершение онбординга
  void completeOnboarding() {
    _currentScreen = AppScreen.login;
    notifyListeners(); // Уведомляем виджеты об изменениях
  }

  // Вход в систему
  void login() {
    _currentScreen = AppScreen.questionnaire;
    notifyListeners();
  }

  // Завершение опросника
  void completeQuestionnaire() {
    _currentScreen = AppScreen.home;
    _navigationTab = AppScreen.home;
    notifyListeners();
  }

  // Клик по профилю
  void selectProfile(UserProfile profile) {
    _selectedProfile = profile;
    _currentScreen = AppScreen.profileDetail;
    notifyListeners();
  }

  // Переход по нижней навигации
  void navigateToTab(AppScreen tab) {
    _navigationTab = tab;
    _currentScreen = tab;
    notifyListeners();
  }

  // Возврат на главный экран (с детального)
  void backToMain() {
    _currentScreen = _navigationTab;
    notifyListeners();
  }

  // Начать чат (с экрана профиля)
  void messageFromProfile() {
    if (_selectedProfile != null) {
      _currentScreen = AppScreen.chat;
      notifyListeners();
    }
  }
}
