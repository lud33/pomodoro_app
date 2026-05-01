class User {
  final String id;
  final String email;
  final String name;
  final int currentStreak;
  final int bestStreak;
  final UserSettings settings;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.currentStreak,
    required this.bestStreak,
    required this.settings,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'],
      email: json['email'],
      name: json['name'],
      currentStreak: json['currentStreak'] ?? 0,
      bestStreak: json['bestStreak'] ?? 0,
      settings: UserSettings.fromJson(json['settings'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
      'settings': settings.toJson(),
    };
  }
}

class UserSettings {
  final int workTime;
  final int shortBreak;
  final int longBreak;
  final bool dailyReminder;
  final String reminderTime;

  UserSettings({
    required this.workTime,
    required this.shortBreak,
    required this.longBreak,
    required this.dailyReminder,
    required this.reminderTime,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      workTime: json['workTime'] ?? 25,
      shortBreak: json['shortBreak'] ?? 5,
      longBreak: json['longBreak'] ?? 15,
      dailyReminder: json['dailyReminder'] ?? false,
      reminderTime: json['reminderTime'] ?? '09:00',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workTime': workTime,
      'shortBreak': shortBreak,
      'longBreak': longBreak,
      'dailyReminder': dailyReminder,
      'reminderTime': reminderTime,
    };
  }
}