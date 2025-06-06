import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guess_buddy_app/common/screen/dashboard_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_up_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_up_success_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const GuessBuddyApp());
}

class GuessBuddyApp extends StatelessWidget {
  const GuessBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color lightMagenta = Color(0xFFE0BBE4);

    return MaterialApp(
      title: 'GuessBuddy',
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: lightMagenta,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1F1F1F), foregroundColor: lightMagenta, elevation: 1),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F),
          selectedItemColor: lightMagenta,
          unselectedItemColor: Colors.grey,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          labelStyle: const TextStyle(color: lightMagenta),
          prefixIconColor: lightMagenta,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightMagenta,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: lightMagenta)),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white70)),
      ),
      themeMode: ThemeMode.dark,
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const DashboardScreen(),
        '/success': (context) => const SignUpSuccessScreen(),
      },
    );
  }
}
