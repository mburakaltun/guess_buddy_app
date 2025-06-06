import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/utility/language_utility.dart';

import '../../main.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLang = 'en';

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final lang = await LanguageHelper.getLanguage();
    setState(() {
      _selectedLang = lang;
    });
  }

  Future<void> _onLanguageSelected(String lang) async {
    await LanguageHelper.setLanguage(lang);
    setState(() {
      _selectedLang = lang;
    });
    if (context.mounted) {
      GuessBuddyApp.setLocale(context, Locale(lang));
    }
    Navigator.pop(context, lang);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.message.languageSelectionTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(context.message.languageSelectionEnglish),
            trailing: _selectedLang == context.message.languageSelectionEnglishKey ? const Icon(Icons.check) : null,
            onTap: () => _onLanguageSelected(context.message.languageSelectionEnglishKey),
          ),
          const Divider(height: 0),
          ListTile(
            title: Text(context.message.languageSelectionTurkish),
            trailing: _selectedLang == context.message.languageSelectionTurkishKey ? const Icon(Icons.check) : null,
            onTap: () => _onLanguageSelected(context.message.languageSelectionTurkishKey),
          ),
        ],
      ),
    );
  }
}
