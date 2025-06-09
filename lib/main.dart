import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:guess_buddy_app/authentication/screen/complete_forgot_password_screen.dart';
import 'package:guess_buddy_app/common/constants/routes.dart';
import 'package:guess_buddy_app/common/screen/dashboard_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_in_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_up_screen.dart';
import 'package:guess_buddy_app/authentication/screen/sign_up_success_screen.dart';
import 'package:guess_buddy_app/common/utility/language_utility.dart';
import 'package:guess_buddy_app/prediction/screen/add_prediction_screen.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

import 'authentication/screen/start_forgot_password_screen.dart';
import 'l10n/app_localizations.dart';

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
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _loadLocale();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadLocale() async {
    final lang = await LanguageHelper.getLanguage();
    setState(() {
      _locale = Locale(lang);
    });
  }

  Future<void> _initDeepLinks() async {
    // Get the initial link that opened the app
    try {
      final appLink = await _appLinks.getInitialAppLink();
      if (appLink != null) {
        print("Initial app link: $appLink");
        _handleDeepLink(appLink);
      }
    } catch (e) {
      print("Error getting initial app link: $e");
    }

    // Listen for links while the app is running
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print("Got app link while running: $uri");
      _handleDeepLink(uri);
    }, onError: (e) {
      print("Error listening to app links: $e");
    });
  }

  void _handleDeepLink(Uri uri) {
    print("Handling deep link: $uri");
    print("Scheme: ${uri.scheme}, Host: ${uri.host}, Path: ${uri.path}");

    // For custom scheme: guessbuddy://reset-password?token=xyz
    // For https scheme: https://guessbuddy.com/reset-password?token=xyz
    if ((uri.scheme == "guessbuddy" && uri.host == "reset-password") ||
        ((uri.scheme == "http" || uri.scheme == "https") &&
            uri.host == "guessbuddy.com" && uri.path == "/reset-password")) {

      final token = uri.queryParameters['token'];
      print("Reset password token: $token");

      if (token != null && token.isNotEmpty) {
        // Wait a moment to ensure the app is fully loaded
        Future.delayed(const Duration(milliseconds: 300), () {
          _navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(
              builder: (context) => CompleteForgotPasswordScreen(token: token),
            ),
          );
        });
      }
    }
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
      navigatorKey: _navigatorKey,
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
        Routes.forgotPassword: (context) => const StartForgotPasswordScreen(),
        '/reset-password': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
          final token = args?['token'] ?? '';
          return CompleteForgotPasswordScreen(token: token);
        },
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes
        if (settings.name?.startsWith('/reset-password') == true) {
          final uri = Uri.parse(settings.name!);
          final token = uri.queryParameters['token'] ?? '';
          return MaterialPageRoute(
            builder: (context) => CompleteForgotPasswordScreen(token: token),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}