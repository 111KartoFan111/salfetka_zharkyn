import os

BASE_DIR = "./"
# Список папок, которые нужно создать
directories = [
    "android",
    "ios",
    "lib/state",
    "lib/screens",
    "lib/widgets",
    "lib/widgets/ui",
    "assets/logo",
    "assets/fonts",
    "test"
]

# Список файлов, которые нужно создать (если нет)
files = [
    "lib/state/app_state.dart",
    "lib/screens/onboarding_screen.dart",
    "lib/screens/login_screen.dart",
    "lib/screens/questionnaire_screen.dart",
    "lib/screens/swipe_screen.dart",
    "lib/screens/matches_screen.dart",
    "lib/screens/recommendations_screen.dart",
    "lib/screens/user_profile_screen.dart",
    "lib/screens/profile_detail_screen.dart",
    "lib/screens/chat_screen.dart",
    "lib/widgets/app_bottom_navigation.dart",
    "lib/widgets/neural_logo_widget.dart",
    "lib/widgets/swipe_card.dart",
    "lib/widgets/ai_date_popup.dart",
    "lib/widgets/ui/button.dart",
    "lib/widgets/ui/input.dart",
    "lib/theme.dart",
    "lib/app_shell.dart",
    "lib/main.dart",
    "assets/logo/neural_logo.svg",
    "assets/fonts/Inter-Regular.ttf",
    "test/widget_test.dart",
    "pubspec.yaml"
]

# Функция для создания директорий и файлов
def create_structure(base_dir, dirs, files):
    print(f"Создание структуры Flutter-проекта в: {os.path.abspath(base_dir)}\n")

    # Создание директорий
    for d in dirs:
        path = os.path.join(base_dir, d)
        os.makedirs(path, exist_ok=True)
        print(f"📁 Папка: {path}")

    # Создание файлов (пустых, если их нет)
    for f in files:
        path = os.path.join(base_dir, f)
        if not os.path.exists(path):
            with open(path, "w", encoding="utf-8") as file:
                # Добавим базовый комментарий для контекста
                filename = os.path.basename(f)
                file.write(f"// {filename} — создан автоматически\n")
            print(f"📝 Файл: {path}")
        else:
            print(f"✅ Уже существует: {path}")

    print("\n✅ Структура успешно создана!")

if __name__ == "__main__":
    create_structure(BASE_DIR, directories, files)
