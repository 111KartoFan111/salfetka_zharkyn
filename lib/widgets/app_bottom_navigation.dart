// lib/widgets/app_bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final currentTab = appState.navigationTab;

    // Конвертируем AppScreen в индекс для BottomNavigationBar
    int currentIndex = 0;
    switch (currentTab) {
      case AppScreen.home:
        currentIndex = 0;
        break;
      case AppScreen.matches:
        currentIndex = 1;
        break;
      case AppScreen.chats:
        currentIndex = 2;
        break;
      case AppScreen.profile:
        currentIndex = 3;
        break;
      default:
        currentIndex = 0;
    }

    // Обработчик нажатия
    void onTabTapped(int index) {
      AppScreen newTab = AppScreen.home;
      switch (index) {
        case 0:
          newTab = AppScreen.home;
          break;
        case 1:
          newTab = AppScreen.matches;
          break;
        case 2:
          newTab = AppScreen.chats;
          break;
        case 3:
          newTab = AppScreen.profile;
          break;
      }
      context.read<AppState>().navigateToTab(newTab);
    }

    return Container(
      height: 80, // h-20
      decoration: BoxDecoration(
        color: AppTheme.background,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!, width: 1), // border-t
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed, // Важно для 4+ элементов
        backgroundColor: AppTheme.background,
        elevation: 0,
        showSelectedLabels: false, // Мы используем кастомные
        showUnselectedLabels: false,
        items: [
          _buildNavItem(
            icon: LucideIcons.house,
            label: 'Главная',
            isActive: currentTab == AppScreen.home,
          ),
          _buildNavItem(
            icon: LucideIcons.heart,
            label: 'Мэтчи',
            isActive: currentTab == AppScreen.matches,
          ),
          _buildNavItem(
            icon: LucideIcons.messageCircle,
            label: 'Чаты',
            isActive: currentTab == AppScreen.chats,
          ),
          _buildNavItem(
            icon: LucideIcons.user,
            label: 'Профиль',
            isActive: currentTab == AppScreen.profile,
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8), // p-2
            decoration: BoxDecoration(
              gradient: isActive ? AppTheme.primaryGradient : null,
              borderRadius: BorderRadius.circular(12), // rounded-xl
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey[400],
            ),
          ),
          const SizedBox(height: 4),
          // Текст с градиентом
          ShaderMask(
            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            blendMode: BlendMode.srcIn, // Важно для градиентного текста
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12, // text-xs
                color: isActive ? Colors.white : Colors.grey[400],
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
      label: '', // Label не нужен, так как мы его встроили в icon
    );
  }
}
