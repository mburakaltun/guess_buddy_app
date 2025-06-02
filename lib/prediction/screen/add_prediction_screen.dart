import 'package:flutter/material.dart';
import 'package:guess_buddy_app/prediction/model/endpoint/prediction_endpoints.dart';
import 'package:guess_buddy_app/prediction/model/request/RequestCreatePrediction.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import '../../common/service/api_service.dart';
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
      await predictionService.create(requestCreatePrediction: RequestCreatePrediction(title: _title, description: _description));

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Prediction submitted successfully!')));
      _formKey.currentState!.reset();
    } on ApiException catch (e) {
      _showErrorDialog(e.message);
    } catch (e) {
      _showErrorDialog('An unexpected error occurred. Please try again.');
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
            title: const Text('Submission Failed'),
            content: Text(message),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
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
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description.';
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
                  child: _isSubmitting ? const CircularProgressIndicator(color: Colors.white) : const Text('Submit Prediction'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
