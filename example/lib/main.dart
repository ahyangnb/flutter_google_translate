import 'package:flutter/material.dart';
import 'package:flutter_google_translate/flutter_google_translate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Translation _translation;
  final String _text =
      'Toda persona tiene derecho a la educación. La educación debe ser gratuita, al menos en lo concerniente a la instrucción elemental y fundamental. La instrucción elemental será obligatoria. La instrucción técnica y profesional habrá de ser generalizada; el acceso a los estudios superiores será igual para todos, en función de los méritos respectivos.';
  TranslationModel _translated =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');
  TranslationModel _detected =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');

  @override
  void initState() {
    _translation = Translation(
      apiKey: 'YOUR_API_KEY',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translate demo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Initial text',
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(_text),
              SizedBox(height: 30),
              Text('Translated text',
                  style: Theme.of(context).textTheme.headline3),
              Text(_translated.translatedText,
                  style: TextStyle(color: Colors.blueAccent)),
              Text('Detected language - ${_translated.detectedSourceLanguage}',
                  style: TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              Text(
                  'Language detected with detectLang, without translation - ${_detected.detectedSourceLanguage}',
                  style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _translated = await _translation.translate(text: _text, to: 'en');
          _detected = await _translation.detectLang(text: _text);
          setState(() {});
        },
        tooltip: 'Translate',
        child: Icon(Icons.language),
      ),
    );
  }
}
