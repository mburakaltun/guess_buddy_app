import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:guess_buddy_app/common/constants/routes.dart';
import 'package:guess_buddy_app/common/screen/dashboard_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_up_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_up_success_screen.dart';
import 'package:guess_buddy_app/common/utility/language_utility.dart';
import 'package:guess_buddy_app/prediction/screen/add_prediction_screen.dart';

import 'authentication/screen/forgot_password_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const GuessBuddyApp());
}

class GuessBuddyApp extends StatefulWidget {
  const GuessBuddyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _GuessBuddyAppState? state = context.findAncestorStateOfType<_GuessBuddyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<GuessBuddyApp> createState() => _GuessBuddyAppState();
}

class _GuessBuddyAppState extends State<GuessBuddyApp> {
  Locale? _locale;

  @override
  void initState() {
    super.initState();
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final lang = await LanguageHelper.getLanguage();
    setState(() {
      _locale = Locale(lang);
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color lightMagenta = Color(0xFFE0BBE4);

    return MaterialApp(
      title: 'GuessBuddy',
      locale: _locale,
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
      initialRoute: Routes.signIn,
      routes: {
        Routes.signIn: (context) => const SignInPage(),
        Routes.signUp: (context) => const SignUpPage(),
        Routes.dashboard: (context) => const DashboardScreen(),
        Routes.signUpSuccess: (context) => const SignUpSuccessScreen(),
        Routes.addPrediction: (context) => const AddPredictionScreen(),
        Routes.forgotPassword: (context) => const ForgotPasswordScreen(),
      },
    );
  }
}