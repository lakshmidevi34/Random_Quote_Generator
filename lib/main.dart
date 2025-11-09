import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(AnimatedQuoteApp());
}

class AnimatedQuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Quote Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: AnimatedQuotePage(),
    );
  }
}

class AnimatedQuotePage extends StatefulWidget {
  @override
  _AnimatedQuotePageState createState() => _AnimatedQuotePageState();
}

class _AnimatedQuotePageState extends State<AnimatedQuotePage> {
  final List<String> quotes = [
    "Believe you can and you're halfway there. – Theodore Roosevelt",
    "The best way to get started is to quit talking and begin doing. – Walt Disney",
    "Don’t let yesterday take up too much of today. – Will Rogers",
    "It always seems impossible until it’s done. – Nelson Mandela",
    "Act as if what you do makes a difference. It does. – William James",
    "Success is not in what you have, but who you are. – Bo Bennett",
    "Your time is limited, so don’t waste it living someone else’s life. – Steve Jobs",
    "Everything you can imagine is real. – Pablo Picasso",
    "Turn your wounds into wisdom. – Oprah Winfrey",
    "Dream big and dare to fail. – Norman Vaughan",
  ];

  String currentQuote = "Tap below to get inspired ✨";
  Color startColor = Colors.deepPurple;
  Color endColor = Colors.pinkAccent;

  void generateQuote() {
    final random = Random();

    setState(() {
      currentQuote = quotes[random.nextInt(quotes.length)];

      // Random gradient color
      startColor = Colors.primaries[random.nextInt(Colors.primaries.length)];
      endColor = Colors.accents[random.nextInt(Colors.accents.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.format_quote, size: 80, color: Colors.white),
                  const SizedBox(height: 40),

                  // Animated quote text
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      key: ValueKey<String>(currentQuote),
                      currentQuote,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  ElevatedButton(
                    onPressed: generateQuote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: startColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "✨ Generate Quote",
                      style: TextStyle(fontSize: 18),
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
}
