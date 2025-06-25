import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

import '../model/exception/api_exception.dart';

class DialogUtility {
  static Future<void> handleApiError({
    required BuildContext context,
    required dynamic error,
    required String title,
  }) async {
    if (error is ApiException) {
      return showErrorDialog(
        context: context,
        title: title,
        message: error.errorMessage,
      );
    } else {
      return showErrorDialog(
        context: context,
        title: title,
        message: context.message.generalError,
      );
    }
  }

  static Future<void> showSuccessDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onDismiss,
    String? buttonText,
  }) async {
    final theme = Theme.of(context);
    final lightMagenta = theme.primaryColor;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (onDismiss != null) {
                  onDismiss();
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: lightMagenta,
                foregroundColor: Colors.black,
              ),
              child: Text(
                buttonText ?? context.message.ok,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> showErrorDialog({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
  }) async {
    final theme = Theme.of(context);
    final lightMagenta = theme.primaryColor;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
        titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: lightMagenta,
                foregroundColor: Colors.black,
              ),
              child: Text(
                buttonText ?? context.message.ok,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}