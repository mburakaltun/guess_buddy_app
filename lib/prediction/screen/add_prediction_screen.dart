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

  final PredictionService predictionService = PredictionService();

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
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.message.addPredictionTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Enter your prediction title",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.message.addPredictionTitleHint;
                      }
                      return null;
                    },
                    onSaved: (value) => _title = value!.trim(),
                  ),

                  const SizedBox(height: 24),

                  // Description field
                  Text(
                    context.message.addPredictionDescription,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      hintText: "Describe your prediction in detail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    maxLines: 5,
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.message.addPredictionDescriptionHint;
                      }
                      return null;
                    },
                    onSaved: (value) => _description = value!.trim(),
                  ),

                  const SizedBox(height: 32),

                  // Submit button
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitPrediction,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : Text(
                      context.message.addPredictionSubmit,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
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
}