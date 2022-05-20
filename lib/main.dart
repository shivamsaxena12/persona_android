import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persona Android',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const nativePersonaChannel = MethodChannel('flutter.native/persona');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persona Android'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20)),
                    side: MaterialStateProperty.all(
                        const BorderSide(width: 2, color: Colors.blue))),
                onPressed: initiatePersonaVerification,
                child: const Text('Initiate Persona Flow'))
          ],
        ),
      ),
    );
  }

  void initiatePersonaVerification() async {
    try {
      String result =
          await nativePersonaChannel.invokeMethod('persona.verification');

      if (result == "INQUIRY_CANCELED") {
        //
      } else if (result == "INQUIRY_ERROR") {
        //
      } else {
        // print(result);
      }
    } on PlatformException catch (_) {
      // print(e);
    }
  }
}
