import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'presentation/screen/splash_screen.dart';
import 'presentation/provider/image_gen_provider.dart';
import 'presentation/provider/chat_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => ImageGenProvider()),
      ],
      child: MaterialApp(
        title: 'AI Chat Bot',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
        home: const SplashScreen(),
      ),
    );
  }
}
