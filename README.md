# SDVGO

СуперАпп для зумеров!

## Содержание
- [Обзор проекта](#обзор-проекта)
- [Установка и настройка](#установка-и-настройка)
- [Архитектура](#архитектура)
- [Firebase настройка](#firebase-настройка)
- [YX Scope использование](#yx-scope-использование)
- [Разработка](#разработка)
- [Тестирование](#тестирование)

## Обзор проекта
Краткое описание проекта и его целей.

## Установка и настройка
1. Клонирование репозитория
   ```bash
   git clone https://github.com/username/sdvgo.git
   cd sdvgo
   ```

2. Установка зависимостей
   ```bash
   flutter pub get
   ```

3. Настройка Firebase (см. раздел [Firebase настройка](#firebase-настройка))

4. Запуск приложения
   ```bash
   flutter run
   ```

## Архитектура
Проект построен на принципах Clean Architecture:

- **Presentation Layer**: UI компоненты, виджеты, страницы
- **Domain Layer**: Бизнес-логика, сервисы, модели
- **Data Layer**: Репозитории, источники данных

Подробнее о нашей архитектуре:
- [Статья про архитектуру](https://habr.com/ru/articles/733960/)

## Firebase настройка

### Для участников команды

1. Получите доступ к проекту Firebase от @timtikh

2. Настройка Firebase для Android:
   - Скачайте файл `google-services.json` из [настроек проекта Firebase](https://console.firebase.google.com/project/sdvgo-8f8e5/settings/general/android:com.sirius.yandex.sdvgo?hl=ru)
   - Поместите файл в каталог `android/app/`

3. Настройка Firebase для iOS (если нужно):
   - Скачайте файл `GoogleService-Info.plist` из настроек проекта Firebase
   - Поместите файл в каталог `ios/Runner/`

4. Установка Firebase CLI и FlutterFire:
   ```bash
   # Установка Firebase CLI
   npm install -g firebase-tools
   
   # Авторизация в Firebase
   firebase login
   
   # Установка FlutterFire CLI (проверь добавился ли в zsh)
   dart pub global activate flutterfire_cli
   
   # Настройка Flutter проекта
   flutterfire configure --project=sdvgo-8f8e5
   ```

5. Перезапустите приложение:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

## YX Scope использование

YX Scope - это инструмент для управления зависимостями и состоянием в приложении.

### Основы использования

1. **Инициализация YX Scope**:
   ```dart
   // В main.dart
   void main() {
     YxScope.init();
     runApp(MyApp());
   }
   ```

2. **Регистрация сервисов**:
   ```dart
   YxScope.register<AuthService>(() => AuthService());
   ```

3. **Использование сервисов**:
   ```dart
   // В любом месте приложения
   final authService = YxScope.get<AuthService>();
   ```

4. **Создание скоупов для разделения зависимостей**:
   ```dart
   // Создание нового скоупа
   final userScope = YxScope.createScope('user');
   
   // Регистрация сервисов в скоупе
   userScope.register<UserRepository>(() => UserRepository());
   
   // Получение сервиса из скоупа
   final userRepo = userScope.get<UserRepository>();
   ```

5. **Удаление скоупа**:
   ```dart
   YxScope.removeScope('user');
   ```

### Примеры использования

**Авторизация с Firebase**:
```dart
final authService = YxScope.get<AuthService>();
try {
  await authService.signInWithGoogle();
} catch (e) {
  // Обработка ошибок
}
```

**Работа с пользовательскими данными**:
```dart
final userRepository = YxScope.get<UserRepository>();
final userData = await userRepository.getUserData();
```

## Разработка

### Соглашения по коду
- Используйте анализаторы кода и линтеры (скоро прекоммит)
- Следуйте принципам Clean Architecture
- Создавайте модульные и переиспользуемые компоненты

### TODO
- Донастроить аналайзер
- Добавить экстеншн на удаление ненужных импортов
- Настроить прекоммит скрипт для проверки кода

## Тестирование
Инструкции по тестированию приложения.