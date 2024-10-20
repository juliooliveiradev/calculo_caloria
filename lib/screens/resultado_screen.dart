import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';

class ResultadoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final UserModel user = args['user'];
    final double calories = args['calories'];
    
    // Obter o tamanho da tela para adaptar os layouts
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Resultado')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calorias diárias recomendadas: ${calories.toStringAsFixed(2)} kcal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Artigos relacionados ao seu objetivo (${user.goal}):',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: ApiService.fetchArticles(user.goal),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao carregar artigos: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhum artigo encontrado.'));
                  } else {
                    final articles = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width < 600 ? 1 : 2, // 1 coluna para celulares, 2 para tablets
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: size.width < 600 ? 3 : 2, // Ajusta a proporção dos cards
                      ),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                padding: EdgeInsets.all(16.0),
                                child: Text(articles[index]['content']),
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    articles[index]['title'],
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    articles[index]['author'],
                                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                                  ),
                                  SizedBox(height: 8.0),
                                  Expanded(
                                    child: Image.network(
                                      articles[index]['image_url'],
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
