import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HomeWidget.registerBackgroundCallback(backgroundCallback);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            ElevatedButton(
              onPressed: openLight,
              child: Text('Open'),
            ),
            ElevatedButton(
              onPressed: closeLight,
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> backgroundCallback(Uri? uri) async {
  if (uri?.host == 'open') {
    openLight.call();
  } else if (uri?.host == 'close') {
    closeLight.call();
  }
}

openLight() async {
  try {
    await TorchLight.enableTorch();
  } on Exception catch (_) {
    // Handle error
  }
}

closeLight() async {
  try {
    await TorchLight.disableTorch();
  } on Exception catch (_) {
    // Handle error
  }
}
