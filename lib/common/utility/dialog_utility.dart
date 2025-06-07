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
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onDismiss != null) {
                onDismiss();
              }
            },
            child: Text(buttonText ?? context.message.ok),
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
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(buttonText ?? context.message.ok),
          ),
        ],
      ),
    );
  }
}