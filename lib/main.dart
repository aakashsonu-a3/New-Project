import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:newproject/dashboard.dart';
import 'package:provider/provider.dart';
import 'custom_clippers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 247, 108, 108)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    var stack = Stack(
          children: [
            Material(
              elevation: 10,
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: ClipPath(
                clipper: BigClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Bigcard(pair: pair),
                  SizedBox(height:10),
                ElevatedButton(
                  onPressed: () { 
                    appState.getNext();
                  },
                  child: Text ('Next'),
                ),
              ],
            ),
          ),
        ],
        );
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {
          Navigator.push(context,
                MaterialPageRoute(builder: (context) => DashboardPage()),
              );
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 94, 255, 72),
                Color.fromARGB(255, 1, 200, 34),
                Color.fromARGB(255, 1, 153, 21),
                Color.fromARGB(255, 1, 73, 7),
              ],
            ),
          ),  
          child: stack,
        ),
      ),
    );
  }
}

class Bigcard extends StatelessWidget {
  const Bigcard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary,
    );

    return Card(
      elevation: 10,
      color: theme.colorScheme.primary, 
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase, 
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
          ),
      ),
    );
  }
}
