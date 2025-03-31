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

### Если вы сами поднимаете проект - то пропустите первый пункт и создайте проект в CloudConsole)

0. Получите доступ к проекту Firebase от @timtikh (администратор проекта)

1. Сгенерируйте Ключ подписания SHA-1 и передайте его в Project Settings или администратору проекта:

   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   
   ```

2. Настройка Firebase для Android:
   - Скачайте файл `google-services.json` из [настроек проекта Firebase](https://console.firebase.google.com/project/sdvgo-8f8e5/settings/general/android:com.sirius.yandex.sdvgo?hl=ru)
   - Поместите файл в каталог `android/app/`

3. Настройка Firebase для iOS (если нужно, но у меня не заработало):
   - Скачайте файл `GoogleService-Info.plist` из настроек проекта Firebase
   - Поместите файл в каталог `ios/Runner/`

4. Установка Firebase CLI и FlutterFire:
   ```bash
   # Установка Firebase CLI (можно не через npm)
   npm install -g firebase-tools
   
   # Авторизация в Firebase
   firebase login
   
   # Установка FlutterFire CLI (macos: проверь добавился ли в zsh)
   dart pub global activate flutterfire_cli
   
   # Настройка Flutter проекта
   flutterfire configure --project=sdvgo-8f8e5
   # Соответсвенно если вы сами поднимаете: --project=<project-id>, не sdvgo
   # возможно попросит ввести com.example.app bundle - com.sirius.yandex.sdvgo
   ```

5. Перезапустите приложение:
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```
6. Cold Reboot эмуляторов
   - Вероятно, ничего не заработает, пока не перезапустите эмулятор - с Hardware-устройствами такого не наблюдалось.


## YX Scope использование

YX Scope - это инструмент для управления зависимостями и состоянием в приложении.

### Основы использования

1. **Инициализация YX Scope**:
   ```dart
   // В main.dart

   ```

2. **Регистрация сервисов**:
   ```dart
   ```

3. **Использование сервисов**:
   ```dart
   // В любом месте приложения
   ```

4. **Создание скоупов для разделения зависимостей**:
   ```dart
   // Создание нового скоупа
   
   // Регистрация сервисов в скоупе
   
   // Получение сервиса из скоупа
   ```

5. **Удаление скоупа**:
   ```dart
   ```

### Примеры использования

**Авторизация с Firebase**:
```dart

```

**Работа с пользовательскими данными**:
```dart

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