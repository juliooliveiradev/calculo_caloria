import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/custom_card.dart';

class ArticlesScreen extends StatelessWidget {
  final String goal;

  ArticlesScreen({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Artigos')),
      body: FutureBuilder(
        future: ApiService.fetchArticles(goal),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar artigos'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  article: snapshot.data[index],
                  onTap: () => showBottomSheet(context, snapshot.data[index]),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showBottomSheet(BuildContext context, article) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                article['title'], // Título do artigo
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                article['content'], // Conteúdo do artigo
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextButton(
                child: Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
