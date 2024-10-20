class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Map<String, dynamic>? lastCalculation;

  @override
  void initState() {
    super.initState();
    _loadLastCalculation();
  }

  Future<void> _loadLastCalculation() async {
    final prefs = await SharedPreferences.getInstance();
    String? calculation = prefs.getString('last_calculation');
    if (calculation != null) {
      setState(() {
        lastCalculation = jsonDecode(calculation);
      });
    }
  }

  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_calculation');
    setState(() {
      lastCalculation = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Histórico de Cálculos'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: lastCalculation != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Último Cálculo:', style: TextStyle(fontSize: 24)),
                  Text('Peso: ${lastCalculation!['weight']} kg'),
                  Text('Altura: ${lastCalculation!['height']} cm'),
                  Text('Idade: ${lastCalculation!['age']} anos'),
                  Text('Gênero: ${lastCalculation!['gender']}'),
                  Text('Nível de Atividade: ${lastCalculation!['activityLevel']}'),
                  Text('Objetivo: ${lastCalculation!['goal']}'),
                  Text('Calorias: ${lastCalculation!['calories'].toStringAsFixed(2)}'),
                ],
              ),
            )
          : Center(child: Text('Nenhum cálculo realizado')),
    );
  }
}
