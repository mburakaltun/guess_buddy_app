import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/prediction/model/request/request_create_prediction.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import '../../common/model/exception/api_exception.dart';
import '../../common/utility/dialog_utility.dart';

class AddPredictionScreen extends StatefulWidget {
  const AddPredictionScreen({super.key});

  @override
  State<AddPredictionScreen> createState() => _AddPredictionPageState();
}

class _AddPredictionPageState extends State<AddPredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _title = '';
  String _description = '';
  bool _isSubmitting = false;
  int _titleCharCount = 0;
  int _descriptionCharCount = 0;
  final int _titleMaxLength = 100;
  final int _descriptionMaxLength = 500;

  final PredictionService predictionService = PredictionService();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      setState(() {
        _titleCharCount = _titleController.text.length;
      });
    });

    _descriptionController.addListener(() {
      setState(() {
        _descriptionCharCount = _descriptionController.text.length;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitPrediction() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isSubmitting = true;
    });

    try {
      await predictionService.createPrediction(
          requestCreatePrediction: RequestCreatePrediction(
              title: _title,
              description: _description
          )
      );

      if (!mounted) return;
      FocusScope.of(context).unfocus();

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.message.addPredictionSuccess),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: context.message.generalDismiss,
              textColor: Colors.white,
              onPressed: () {},
            ),
          )
      );

      _titleController.clear();
      _descriptionController.clear();
      _formKey.currentState!.reset();
    } catch (e) {
      DialogUtility.handleApiError(
        context: context,
        error: e,
        title: context.message.addPredictionFailed,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Introduction text
                  Text(
                    context.message.addPredictionIntro,
                    style: TextStyle(
                      fontSize: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Title field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.message.addPredictionTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$_titleCharCount/$_titleMaxLength',
                        style: TextStyle(
                          fontSize: 12,
                          color: _titleCharCount > _titleMaxLength * 0.8
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _titleController,
                    maxLength: _titleMaxLength,
                    decoration: InputDecoration(
                      hintText: context.message.addPredictionTitleHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      filled: true,
                      fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                      counterText: '',
                      prefixIcon: Icon(Icons.title, color: colorScheme.primary.withOpacity(0.7)),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.message.addPredictionTitleRequired;
                      }
                      if (value.length > _titleMaxLength) {
                        return context.message.addPredictionTitleTooLong;
                      }
                      return null;
                    },
                    onSaved: (value) => _title = value!.trim(),
                  ),

                  const SizedBox(height: 32),

                  // Description field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.message.addPredictionDescription,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$_descriptionCharCount/$_descriptionMaxLength',
                        style: TextStyle(
                          fontSize: 12,
                          color: _descriptionCharCount > _descriptionMaxLength * 0.8
                              ? colorScheme.error
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _descriptionController,
                    maxLength: _descriptionMaxLength,
                    decoration: InputDecoration(
                      hintText: context.message.addPredictionDescriptionHint,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: colorScheme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                      filled: true,
                      fillColor: colorScheme.surfaceVariant.withOpacity(0.3),
                      counterText: '',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 7,
                    minLines: 5,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.message.addPredictionDescriptionRequired;
                      }
                      if (value.length > _descriptionMaxLength) {
                        return context.message.addPredictionDescriptionTooLong;
                      }
                      return null;
                    },
                    onSaved: (value) => _description = value!.trim(),
                  ),

                  const SizedBox(height: 40),

                  // Guidelines section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: colorScheme.outlineVariant),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tips_and_updates, color: colorScheme.primary),
                            const SizedBox(width: 8),
                            Text(
                              context.message.addPredictionTipsTitle,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildTipItem(context.message.addPredictionTip1, colorScheme),
                        _buildTipItem(context.message.addPredictionTip2, colorScheme),
                        _buildTipItem(context.message.addPredictionTip3, colorScheme),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Submit button
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitPrediction,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      disabledBackgroundColor: colorScheme.onSurface.withOpacity(0.12),
                    ),
                    child: _isSubmitting
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: colorScheme.onPrimary,
                            strokeWidth: 2.5,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          context.message.addPredictionSubmitting,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          context.message.addPredictionSubmit,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTipItem(String text, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, size: 16, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}