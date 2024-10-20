import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final dynamic article; // Defina um modelo mais específico se necessário
  final VoidCallback onTap;

  CustomCard({required this.article, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(article['title']),
        subtitle: Text(article['summary']),
        onTap: onTap,
      ),
    );
  }
}
