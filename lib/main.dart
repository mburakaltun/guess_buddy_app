import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
    // Define a light magenta color
    const Color lightMagenta = Color(0xFFE0BBE4); // A light purple/pink shade

    return MaterialApp(
      title: 'GuessBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: lightMagenta, // Changed from Colors.tealAccent[200]
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: lightMagenta, // Changed from Colors.tealAccent
          elevation: 1,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF1F1F1F),
          selectedItemColor: lightMagenta, // Changed from Colors.tealAccent
          unselectedItemColor: Colors.grey,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: lightMagenta), // Changed from Colors.tealAccent[200]
          prefixIconColor: lightMagenta, // Changed from Colors.tealAccent[200]
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: lightMagenta, // Changed from Colors.tealAccent[200]
            foregroundColor: Colors.black, // Keep black for contrast on light magenta
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: lightMagenta, // Changed from Colors.tealAccent[200]
          ),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white70),
        ),
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