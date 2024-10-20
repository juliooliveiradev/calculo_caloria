class Constants {
  // URL da API para buscar artigos
    static const String articlesApiUrl = 'https://api.npoint.io/cd5cc92e412c4058c90d';

  // Mensagens de erro
  static const String errorLoadingArticles = 'Erro ao carregar artigos';
  static const String invalidGenderError = 'Gênero inválido. Use "Masculino" ou "Feminino".';
  static const String invalidActivityLevelError = 'Nível de atividade inválido.';
  static const String invalidGoalError = 'Objetivo inválido. Use "Perda de peso" ou "Ganho de peso".';

  // Níveis de atividade
  static const List<String> activityLevels = [
    'Sedentário',
    'Levemente ativo',
    'Moderadamente ativo',
    'Muito ativo',
  ];

  // Objetivos
  static const List<String> goals = [
    'Perda de peso',
    'Ganho de peso',
  ];
}