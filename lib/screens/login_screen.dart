// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/neural_logo_widget.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onLogin;
  const LoginScreen({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.backgroundGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Логотип и заголовок
                  const NeuralLogoWidget(size: 80),
                  const SizedBox(height: 24),
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppTheme.primaryGradient.createShader(bounds),
                    child: Text(
                      'SoulMatch',
                      style: textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find your AI-powered match',
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppTheme.mutedForeground,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Поля ввода
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      prefixIcon: Icon(LucideIcons.mail,
                          color: AppTheme.mutedForeground),
                      fillColor: AppTheme.background, // bg-white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16), // rounded-2xl
                        borderSide: BorderSide(color: Colors.grey[300]!), // border-gray-200
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(LucideIcons.lock,
                          color: AppTheme.mutedForeground),
                      fillColor: AppTheme.background,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),

                  // Кнопка Sign In
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton(
                      onPressed: onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text('Sign In'),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Разделитель
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[300])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'or continue with',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.mutedForeground),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[300])),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Кнопки соцсетей (упрощенно)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onLogin,
                          icon: const Icon(LucideIcons.activity,
                              color: Color(0xFF4285F4)), // Placeholder
                          label: const Text('Google'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppTheme.background,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: onLogin,
                          icon: const Icon(LucideIcons.apple),
                          label: const Text('Apple'),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppTheme.background,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Sign up
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppTheme.mutedForeground),
                      ),
                      TextButton(
                        onPressed: onLogin,
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              AppTheme.primaryGradient.createShader(bounds),
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.white, // Будет заменено градиентом
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
