import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/prediction/model/viewmodel/prediction_card_model.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_predictions.dart';
import 'package:guess_buddy_app/common/model/exception/api_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/model/shared_preferences/shared_preferences_key.dart';
import '../model/dto/prediction_dto.dart';
import '../../vote/screen/vote_prediction_screen.dart';

class PredictionFeedScreen extends StatefulWidget {
  const PredictionFeedScreen({super.key});

  @override
  State<PredictionFeedScreen> createState() => _PredictionFeedScreenState();
}

class _PredictionFeedScreenState extends State<PredictionFeedScreen> {
  final PredictionService _predictionService = PredictionService();
  final ScrollController _scrollController = ScrollController();

  List<PredictionCardModel> predictions = [];
  bool _isLoading = false;
  bool _isPaginating = false;
  String? _error;
  String? _userId;

  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasMore = true;

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
        _error = context.message.predictionFeedUserNotFound;
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
    if (_isLoading || _isPaginating || (page > 0 && !_hasMore)) return;

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
        final newPredictions = response.predictionDtoList.map(_mapPredictionDtoToCardModel).toList();
        if (refresh) {
          predictions = newPredictions;
        } else {
          predictions.addAll(newPredictions);
        }
        _hasMore = response.number! < (response.totalPages! - 1);
        _currentPage = response.number!;
      });
    } on ApiException catch (e) {
      setState(() {
        _error = e.errorMessage;
      });
    } catch (e) {
      setState(() {
        _error = context.message.generalError;
      });
    } finally {
      setState(() {
        _isLoading = false;
        _isPaginating = false;
      });
    }
  }

  PredictionCardModel _mapPredictionDtoToCardModel(PredictionDto dto) {
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

  Widget _buildPredictionCard(PredictionCardModel prediction, bool isOtherUser) {
    final bool hasVotes = prediction.voteCount > 0;
    final bool isPositive = prediction.averageScore >= 2.5;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      shadowColor: Colors.black26,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap:
            isOtherUser
                ? () async {
                  final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => VotePredictionScreen(prediction: prediction)));
                  if (result == true) {
                    await _onRefresh();
                  }
                }
                : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with username and date
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: theme.primaryColor.withOpacity(0.2),
                    child: Text(
                      prediction.creatorUsername.isNotEmpty ? prediction.creatorUsername[0].toUpperCase() : '?',
                      style: TextStyle(fontWeight: FontWeight.bold, color: theme.primaryColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('@${prediction.creatorUsername}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey)),
                        Text(prediction.createdDate, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                      ],
                    ),
                  ),
                  if (isOtherUser)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: theme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                      child: Icon(Icons.how_to_vote, size: 16, color: theme.primaryColor),
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Title
              Text(prediction.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

              const SizedBox(height: 8),

              // Description
              Text(prediction.description, style: const TextStyle(fontSize: 15)),

              const Divider(height: 24),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Vote count
                  Row(
                    children: [
                      Icon(Icons.people, size: 18, color: theme.colorScheme.onSurface.withOpacity(0.7)),
                      const SizedBox(width: 6),
                      Text(
                        context.message.predictionFeedVoteCount(prediction.voteCount),
                        style: TextStyle(color: theme.colorScheme.onSurface.withOpacity(0.7), fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),

                  // Status indicator and score
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          isDarkMode
                              ? hasVotes
                                  ? (isPositive ? Colors.green.shade900.withOpacity(0.4) : Colors.red.shade900.withOpacity(0.4))
                                  : theme.cardColor
                              : hasVotes
                              ? (isPositive ? Colors.green.shade50 : Colors.red.shade50)
                              : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: hasVotes ? (isPositive ? Colors.green.shade700 : Colors.red.shade700) : theme.dividerColor, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          hasVotes ? (isPositive ? Icons.check_circle : Icons.cancel) : Icons.hourglass_empty,
                          size: 16,
                          color: hasVotes ? (isPositive ? Colors.green.shade400 : Colors.red.shade400) : theme.disabledColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          hasVotes
                              ? (isPositive ? context.message.predictionFeedPositive : context.message.predictionFeedNegative)
                              : context.message.predictionFeedNotVotedYet,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: hasVotes ? (isPositive ? Colors.green.shade400 : Colors.red.shade400) : theme.disabledColor,
                          ),
                        ),
                        if (hasVotes) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDarkMode ? theme.colorScheme.surface : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: theme.dividerColor),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 14),
                                const SizedBox(width: 2),
                                Text(
                                  prediction.averageScore.toStringAsFixed(1),
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(_error!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _initializeUserAndFetchPredictions,
              icon: const Icon(Icons.refresh),
              label: Text(context.message.predictionFeedTryAgain),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.content_paste_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(context.message.predictionFeedNoPredictions, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && predictions.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(), SizedBox(height: 16), Text("Loading predictions...")],
          ),
        ),
      );
    }

    if (_error != null && predictions.isEmpty) {
      return Scaffold(body: _buildErrorState());
    }

    if (_userId == null) {
      return Scaffold(body: Center(child: Text(context.message.predictionFeedUserNotFound)));
    }

    return Scaffold(
      body:
          predictions.isEmpty && !_isLoading && !_isPaginating
              ? _buildEmptyState()
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
                    return _buildPredictionCard(prediction, isOtherUser);
                  },
                ),
              ),
    );
  }
}
