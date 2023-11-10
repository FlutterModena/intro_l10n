import 'package:flutter/material.dart';

enum IvaPercentage {
  percent10,
  percent22,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  double? _iva;
  IvaPercentage _selectedIvaPercentage = IvaPercentage.percent22;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Prezzo"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _updateIvaPercentage(IvaPercentage.percent22);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _selectedIvaPercentage == IvaPercentage.percent22
                                  ? Colors.blue
                                  : Colors.white,
                        ),
                        child: Text(
                          "22%",
                          style: TextStyle(
                            color: _selectedIvaPercentage ==
                                    IvaPercentage.percent22
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _updateIvaPercentage(IvaPercentage.percent10);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _selectedIvaPercentage == IvaPercentage.percent10
                                  ? Colors.blue
                                  : Colors.white,
                        ),
                        child: Text(
                          "10%",
                          style: TextStyle(
                            color: _selectedIvaPercentage ==
                                    IvaPercentage.percent10
                                ? Colors.white
                                : Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        double price = double.parse(_controller.text);
                        double calculatedIva = _calculateIva(price);
                        setState(() {
                          _iva = calculatedIva;
                        });
                      }
                    },
                    child: const Text("Calcola l'IVA!"),
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                    visible: _iva != null,
                    child: RichText(
                      text: TextSpan(
                        text: "L'IVA sul prezzo corrisponde a : ",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: _iva != null ? '$_iva €' : '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateIvaPercentage(IvaPercentage percentage) {
    setState(() {
      _selectedIvaPercentage = percentage;
    });
  }

  double _calculateIva(double price) {
    switch (_selectedIvaPercentage) {
      case IvaPercentage.percent10:
        return price * 0.10;
      case IvaPercentage.percent22:
        return price * 0.22;
    }
  }
}
