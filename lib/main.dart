import 'package:ace_chat_app/cubit/login_cubit/login_cubit.dart';
import 'package:ace_chat_app/cubit/theme_cubit/theme_cubit.dart';
import 'package:ace_chat_app/cubit/user_cubit/user_cubit.dart';
import 'package:ace_chat_app/firebase_options.dart';
import 'package:ace_chat_app/screens/auth/login/login_screen.dart';
import 'package:ace_chat_app/screens/home/tabs_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: const ThemedApp(),
    );
  }
}

class ThemedApp extends StatefulWidget {
  const ThemedApp({
    super.key,
  });

  @override
  State<ThemedApp> createState() => _ThemedAppState();
}

class _ThemedAppState extends State<ThemedApp> {
  @override
  void initState() {
    ThemeCubit.get(context).getPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => UserCubit(),
          child: MaterialApp(
            title: 'Ace Message',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeCubit.get(context).theme,
            darkTheme: appTheme(context, dark: true),
            theme: appTheme(context),
            home: StreamBuilder(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const HomeScreen();
                } else {
                  return BlocProvider(
                      create: (context) => LoginCubit(),
                      child: const LoginScreen());
                }
              },
            ),
          ),
        );
      },
    );
  }

  ThemeData appTheme(BuildContext context, {bool dark = false}) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: ThemeCubit.get(context).mainColor,
          brightness: dark ? Brightness.dark : Brightness.light),
      useMaterial3: true,
    );
  }
}
