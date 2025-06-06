import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/prediction/model/request/request_create_prediction.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import '../../common/model/exception/api_exception.dart';

class AddPredictionScreen extends StatefulWidget {
  const AddPredictionScreen({super.key});

  @override
  State<AddPredictionScreen> createState() => _AddPredictionPageState();
}

class _AddPredictionPageState extends State<AddPredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  bool _isSubmitting = false;

  final PredictionService predictionService = PredictionService();

  Future<void> _submitPrediction() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() {
      _isSubmitting = true;
    });

    try {
      await predictionService.createPrediction(requestCreatePrediction: RequestCreatePrediction(title: _title, description: _description));

      if (!mounted) return;
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.message.addPredictionSuccess)));
      _formKey.currentState!.reset();
    } on ApiException catch (e) {
      _showErrorDialog(e.errorMessage);
    } catch (e) {
      _showErrorDialog(context.message.generalError);
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.message.addPredictionFailed),
            content: Text(message),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(context.message.ok))],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: context.message.addPredictionTitle, border: const OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.message.addPredictionTitleHint;
                  }
                  return null;
                },
                onSaved: (value) => _title = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: context.message.addPredictionDescription, border: const OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.message.addPredictionDescriptionHint;
                  }
                  return null;
                },
                onSaved: (value) => _description = value!.trim(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitPrediction,
                  child: _isSubmitting ? const CircularProgressIndicator(color: Colors.white) : Text(context.message.addPredictionSubmit),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
