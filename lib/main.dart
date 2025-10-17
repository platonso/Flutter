import 'package:flutter/cupertino.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Путешествия',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.activeBlue,
        scaffoldBackgroundColor: CupertinoColors.systemBackground,
      ),
      home: const HomeScreen(),
    );
  }
}