import 'package:flutter/material.dart';
import '../services/tmb_service.dart';
import '../models/user_model.dart';
import '../utils/shared_preferences_util.dart';

class UserInputScreen extends StatefulWidget {
  @override
  _UserInputScreenState createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final _formKey = GlobalKey<FormState>();
  double weight = 0;
  double height = 0;
  int age = 0;
  String gender = 'Masculino';
  String activityLevel = 'Sedentário';
  String goal = 'Perda de peso';

  void _calculateCalories() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      UserModel user = UserModel(
        weight: weight,
        height: height,
        age: age,
        gender: gender,
        activityLevel: activityLevel,
        goal: goal,
      );

      double calories = TmbService.calculateDailyCalories(user);
      await SharedPreferencesUtil.saveLastCalculation(user, calories);

      Navigator.pushNamed(context, '/resultado', arguments: {'user': user, 'calories': calories});
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Calcule suas calorias')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextFormField(
                label: 'Peso (kg)',
                onSaved: (value) => weight = double.parse(value!),
              ),
              SizedBox(height: 16.0),
              _buildTextFormField(
                label: 'Altura (cm)',
                onSaved: (value) => height = double.parse(value!),
              ),
              SizedBox(height: 16.0),
              _buildTextFormField(
                label: 'Idade',
                onSaved: (value) => age = int.parse(value!),
              ),
              SizedBox(height: 16.0),
              _buildDropdownFormField(
                label: 'Gênero',
                value: gender,
                items: ['Masculino', 'Feminino'],
                onChanged: (newValue) => setState(() => gender = newValue!),
              ),
              SizedBox(height: 16.0),
              _buildDropdownFormField(
                label: 'Nível de atividade',
                value: activityLevel,
                items: ['Sedentário', 'Levemente ativo', 'Moderadamente ativo', 'Muito ativo'],
                onChanged: (newValue) => setState(() => activityLevel = newValue!),
              ),
              SizedBox(height: 16.0),
              _buildDropdownFormField(
                label: 'Objetivo',
                value: goal,
                items: ['Perda de peso', 'Ganho de peso'],
                onChanged: (newValue) => setState(() => goal = newValue!),
              ),
              SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  onPressed: _calculateCalories,
                  child: Text('Calcular'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.2,
                      vertical: 16.0,
                    ),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required FormFieldSetter<String> onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      keyboardType: TextInputType.number,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownFormField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
