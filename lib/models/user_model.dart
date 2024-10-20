class UserModel {
  double weight; // Peso do usuário em kg
  double height; // Altura do usuário em cm
  int age;       // Idade do usuário em anos
  String gender; // Gênero do usuário (Masculino ou Feminino)
  String activityLevel; // Nível de atividade física
  String goal;   // Objetivo (Perda de peso ou Ganho de peso)

  UserModel({
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.activityLevel,
    required this.goal,
  });

  // Método para converter o modelo para um mapa (usado para armazenamento local)
  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'height': height,
      'age': age,
      'gender': gender,
      'activityLevel': activityLevel,
      'goal': goal,
    };
  }

  // Método para criar um modelo a partir de um mapa (usado para leitura de armazenamento local)
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      weight: json['weight'],
      height: json['height'],
      age: json['age'],
      gender: json['gender'],
      activityLevel: json['activityLevel'],
      goal: json['goal'],
    );
  }
}
