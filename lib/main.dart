import 'package:ace_chat_app/firebase_options.dart';
import 'package:ace_chat_app/screens/auth/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ace Message',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: appTheme(dark: true),
      theme: appTheme(),
      home: const LoginScreen(),
    );
  }

  ThemeData appTheme({bool dark = false}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: dark ? Brightness.dark : Brightness.light),
      useMaterial3: true,
    );
  }
}
