// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soulmatch/app_shell.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';

void main() {
  runApp(
    // Оборачиваем приложение в ChangeNotifierProvider для управления состоянием
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoulMatch',
      theme: AppTheme.lightTheme,
      // Мы могли бы использовать darkTheme, если бы определили его в theme.dart
      // darkTheme: AppTheme.darkTheme, 
      themeMode: ThemeMode.light, // Принудительно светлая тема
      debugShowCheckedModeBanner: false,
      home: AppShell(), // AppShell теперь управляет отображением экранов
    );
  }
}
