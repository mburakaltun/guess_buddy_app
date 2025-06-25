import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/utility/dialog_utility.dart';
import 'package:guess_buddy_app/user/model/request/request_submit_feedback.dart';

import '../model/enums/feedback_category.dart';
import '../service/feedback_service.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  FeedbackCategory _selectedFeedbackCategory = FeedbackCategory.suggestion;
  bool _isSubmitting = false;
  final feedbackService = FeedbackService();

  final List<Map<String, dynamic>> _feedbackCategories = [
    {'value': FeedbackCategory.suggestion, 'icon': Icons.lightbulb_outline, 'color': Colors.amber},
    {'value': FeedbackCategory.bugReport, 'icon': Icons.bug_report_outlined, 'color': Colors.redAccent},
    {'value': FeedbackCategory.question, 'icon': Icons.help_outline, 'color': Colors.blueAccent},
    {'value': FeedbackCategory.other, 'icon': Icons.chat_bubble_outline, 'color': Colors.greenAccent},
  ];

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    if (_formKey.currentState?.validate() != true) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      RequestSubmitFeedback request = RequestSubmitFeedback(
        category: _selectedFeedbackCategory.value, // Send the enum value to match Java backend
        content: _feedbackController.text.trim(),
      );

      await feedbackService.submitFeedback(request);

      if (!mounted) return;

      await DialogUtility.showSuccessDialog(
        context: context,
        title: context.message.feedbackSuccessTitle,
        message: context.message.feedbackSuccessMessage,
        onDismiss: () => Navigator.pop(context),
      );
    } catch (e) {
      if (!mounted) return;

      DialogUtility.handleApiError(
        context: context,
        error: e,
        title: context.message.feedbackErrorTitle,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Widget _buildFeedbackTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            context.message.feedbackTypeLabel,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _feedbackCategories.map((type) {
                final isSelected = _selectedFeedbackCategory == type['value'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    avatar: Icon(
                      type['icon'] as IconData,
                      color: isSelected
                          ? Colors.black
                          : type['color'] as Color,
                      size: 18,
                    ),
                    label: Text(
                      _getFeedbackTypeLabel(type['value'] as FeedbackCategory),
                      style: TextStyle(
                        color: isSelected
                            ? Colors.black
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Theme.of(context).primaryColor,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedFeedbackCategory = type['value'] as FeedbackCategory;
                        });
                      }
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  String _getFeedbackTypeLabel(FeedbackCategory category) {
    switch (category) {
      case FeedbackCategory.suggestion:
        return context.message.feedbackTypeSuggestion;
      case FeedbackCategory.bugReport:
        return context.message.feedbackTypeBug;
      case FeedbackCategory.question:
        return context.message.feedbackTypeQuestion;
      case FeedbackCategory.other:
        return context.message.feedbackTypeOther;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.message.feedbackScreenTitle),
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Header
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.all(16),
                child: Icon(
                  Icons.feedback,
                  color: Theme.of(context).primaryColor,
                  size: 40,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.message.feedbackIntroText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // Feedback type selector
            _buildFeedbackTypeSelector(),
            const SizedBox(height: 24),

            // Feedback message field
            TextFormField(
              controller: _feedbackController,
              decoration: InputDecoration(
                labelText: context.message.feedbackMessageLabel,
                hintText: context.message.feedbackMessageHint,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              maxLines: 6,
              minLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.message.feedbackMessageRequired;
                }
                if (value.trim().length < 10) {
                  return context.message.feedbackMessageTooShort;
                }
                return null;
              },
            ),
            const SizedBox(height: 32),

            // Submit button
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
                    : Text(
                  context.message.feedbackSubmitButton,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}