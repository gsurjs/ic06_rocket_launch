import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  // Helper method to get text color based on counter value
  Color _getTextColor() {
    if (_counter == 0) return Colors.red;
    if (_counter > 50) return Colors.green;
    return Colors.orange;
  }

  // Helper method to increment counter
  void _increment() {
    setState(() {
      if (_counter < 100) {
        _counter++;
        if (_counter == 100) {
          _showLiftoffDialog();
        }
      }
    });
  }

  // Helper method to decrement counter
  void _decrement() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  // Helper method to reset counter
  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  // Show liftoff dialog
  void _showLiftoffDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('🚀 LIFTOFF! 🚀'),
          content: Text('Mission successful! The rocket has launched!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Launch Controller'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Display counter with color-coded text
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.blue,
              child: Column(
                children: [
                  Text(
                    '$_counter',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: _getTextColor(),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Show LIFTOFF message when counter reaches 100
                  if (_counter == 100)
                    Text(
                      'LIFTOFF!',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),
          
          // Slider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Slider(
              min: 0,
              max: 100,
              value: _counter.toDouble(),
              onChanged: (double value) {
                setState(() {
                  _counter = value.toInt();
                  if (_counter == 100) {
                    _showLiftoffDialog();
                  }
                });
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),
          ),
          
          SizedBox(height: 30),
          
          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Increment Ignite Button
              ElevatedButton(
                onPressed: _increment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Ignite (+1)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              
              // Decrement Abort Button
              ElevatedButton(
                onPressed: _decrement,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Abort (-1)',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              
              // Reset button
              ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}