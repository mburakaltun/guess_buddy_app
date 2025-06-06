import 'package:flutter/material.dart';
import 'package:guess_buddy_app/prediction/model/viewmodel/prediction_card_model.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_predictions.dart';
import 'package:guess_buddy_app/common/model/exception/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/model/shared_preferences/shared_preferences_key.dart';
import '../prediction/model/dto/prediction_dto.dart';
import '../vote/screen/vote_prediction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PredictionService _predictionService = PredictionService();
  List<PredictionCardModel> predictions = [];
  bool _isLoading = false;
  bool _isPaginating = false;
  String? _error;
  String? _userId;

  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeUserAndFetchPredictions();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadMorePredictions();
    }
  }

  Future<void> _initializeUserAndFetchPredictions() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(SharedPreferencesKey.userId);

    if (userId == null) {
      setState(() {
        _error = 'Kullanıcı bilgisi bulunamadı.';
      });
      return;
    }

    setState(() {
      _userId = userId;
    });

    _currentPage = 0;
    _hasMore = true;
    await _fetchPredictions(page: _currentPage, refresh: true);
  }

  Future<void> _fetchPredictions({required int page, bool refresh = false}) async {
    if (_isLoading || _isPaginating || (page > 0 && !_hasMore)) {
      return;
    }

    if (refresh) {
      setState(() {
        _isLoading = true;
        _error = null;
        predictions.clear();
        _currentPage = 0;
        _hasMore = true;
      });
    } else {
      setState(() {
        _isPaginating = true;
        _error = null;
      });
    }

    try {
      final request = RequestGetPredictions(page: page, size: _pageSize);
      final response = await _predictionService.getPredictions(requestGetPredictions: request);
      setState(() {
        if (refresh) {
          predictions = response.predictionDTOList.map(_mapPredictionDtoToCardModel).toList();
        } else {
          predictions.addAll(response.predictionDTOList.map(_mapPredictionDtoToCardModel).toList());
        }
        _hasMore = response.number! < (response.totalPages! - 1);
        _currentPage = response.number!;
      });
    } on ApiException catch (e) {
      setState(() {
        _error = e.message;
      });
    } catch (e) {
      print('Error fetching predictions: $e');
      setState(() {
        _error = 'Beklenmedik bir hata oluştu.';
      });
    } finally {
      setState(() {
        _isLoading = false;
        _isPaginating = false;
      });
    }
  }

  PredictionCardModel _mapPredictionDtoToCardModel(PredictionDTO dto) {
    return PredictionCardModel(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      voteCount: dto.voteCount,
      averageScore: dto.averageScore,
      createdDate: dto.createdDate,
      creatorUserId: dto.creatorUserId,
      userScore: dto.userScore,
      creatorUsername: dto.creatorUsername,
    );
  }

  Future<void> _loadMorePredictions() async {
    if (_hasMore && !_isPaginating) {
      await _fetchPredictions(page: _currentPage + 1);
    }
  }

  Future<void> _onRefresh() async {
    await _fetchPredictions(page: 0, refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && predictions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_error != null && predictions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_error!),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _initializeUserAndFetchPredictions, child: const Text('Tekrar Dene')),
            ],
          ),
        ),
      );
    }
    if (_userId == null) {
      return const Scaffold(body: Center(child: Text("Kullanıcı bilgisi alınamadı.")));
    }

    return Scaffold(
      body:
          predictions.isEmpty && !_isLoading && !_isPaginating
              ? const Center(child: Text('Henüz tahmin bulunmamaktadır.'))
              : RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: predictions.length + (_hasMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == predictions.length) {
                      return const Padding(padding: EdgeInsets.symmetric(vertical: 16.0), child: Center(child: CircularProgressIndicator()));
                    }

                    final prediction = predictions[index];
                    final isOtherUser = _userId != null && prediction.creatorUserId.toString() != _userId;

                    return GestureDetector(
                      onTap:
                          isOtherUser
                              ? () async {
                                final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => VotePredictionScreen(prediction: prediction)));
                                if (result == true) {
                                  await _onRefresh();
                                }
                              }
                              : null,
                      child: Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.only(bottom: 16.0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(prediction.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text('@${prediction.creatorUsername}', style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.grey)),
                                  const SizedBox(height: 8),
                                  Text(prediction.description),
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
                          ),
                          if (isOtherUser) const Positioned(top: 8, right: 8, child: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
