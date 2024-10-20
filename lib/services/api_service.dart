import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart'; 
import '../utils/constants.dart'; 

class ApiService {
  static Future<List<dynamic>> fetchArticles(String goal) async {
    try {
      // Mapeamento dos valores de goal para o formato esperado pela API
      Map<String, String> goalMapping = {
        "Ganho de peso": "weight_gain",
        "Perda de peso": "weight_loss",
      };

      // Converta o valor de 'goal' para o formato esperado pela API
      String apiGoal = goalMapping[goal] ?? "";
      print('Valor de goal convertido para API: $apiGoal');

      final response = await http.get(Uri.parse(Constants.articlesApiUrl));
      print('URL da API: ${Constants.articlesApiUrl}');
      print('Resposta da API: ${response.body}');
      print('Valor de goal recebido: $goal');
      
      if (response.statusCode == 200) {
        // Decodificando a resposta JSON
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // Acessando a lista de artigos
        List<dynamic> articles = jsonResponse['articles'];

        // Filtrando os artigos com base no objetivo do usuário (apiGoal)
        List<dynamic> filteredArticles = articles
            .where((article) => article['goal'].toString().toLowerCase() == apiGoal)
            .toList();
        
        print('Artigos filtrados: ${filteredArticles.length}');
        print('Quantidade total de artigos: ${articles.length}');
        return filteredArticles;
      } else {
        throw Exception('Erro ao buscar artigos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar artigos: $e');
    }
  }

  // Método para construir o widget de imagem com tratamento de erros
  static Widget buildArticleImage(String imageUrl) {
    return Image.network(
      imageUrl,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return Center(
          child: Text('Erro ao carregar a imagem'),
        );
      },
    );
  }
}
