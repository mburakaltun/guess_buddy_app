import 'package:flutter/material.dart';
import 'package:guess_buddy_app/prediction/model/viewmodel/prediction_card_model.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_predictions.dart';
import 'package:guess_buddy_app/common/model/exception/api_exception.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PredictionService _predictionService = PredictionService();
  List<PredictionCardModel> predictions = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchPredictions();
  }

  Future<void> _fetchPredictions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final request = RequestGetPredictions(page: 0, size: 20);
      final response = await _predictionService.getPredictions(requestGetPredictions: request);
      setState(() {
        predictions =
            response.predictionDTOList
                .map(
                  (dto) => PredictionCardModel(
                    title: dto.title,
                    description: dto.description,
                    voteCount: dto.voteCount,
                    averageScore: dto.averageScore,
                    createdDate: dto.createdDate,
                  ),
                )
                .toList();
      });
    } on ApiException catch (e) {
      setState(() {
        _error = e.message;
      });
    } catch (e) {
      setState(() {
        _error = 'An unexpected error occurred.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(_error!), const SizedBox(height: 12), ElevatedButton(onPressed: _fetchPredictions, child: const Text('Retry'))],
        ),
      );
    }
    return predictions.isEmpty
        ? const Center(child: Text('Henüz tahmin bulunmamaktadır.'))
        : ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: predictions.length,
          itemBuilder: (context, index) {
            final prediction = predictions[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prediction.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(prediction.description, style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 8),
                    Text(prediction.createdDate, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [const Icon(Icons.how_to_vote, size: 18), const SizedBox(width: 4), Text('${prediction.voteCount} oy')]),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text('${prediction.averageScore.toStringAsFixed(1)} / 5'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}
