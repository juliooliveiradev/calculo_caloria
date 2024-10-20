import '../models/user_model.dart';

class TmbService {
  static double calculateTMB(UserModel user) {
    if (user.gender == 'Masculino') {
      return 88.362 + (13.397 * user.weight) + (4.799 * user.height) - (5.677 * user.age);
    } else {
      return 447.593 + (9.247 * user.weight) + (3.098 * user.height) - (4.330 * user.age);
    }
  }

  static double calculateDailyCalories(UserModel user) {
    double tmb = calculateTMB(user);
    double activityFactor;

    switch (user.activityLevel) {
      case 'Sedentário':
        activityFactor = 1.2;
        break;
      case 'Levemente ativo':
        activityFactor = 1.375;
        break;
      case 'Moderadamente ativo':
        activityFactor = 1.55;
        break;
      case 'Muito ativo':
        activityFactor = 1.725;
        break;
      default:
        activityFactor = 1.0;
    }

    double dailyCalories = tmb * activityFactor;

    if (user.goal == 'Perda de peso') {
      return dailyCalories * 0.8; // Reduz 20% para perda de peso
    } else {
      return dailyCalories * 1.15; // Aumenta 15% para ganho de peso
    }
  }
}
