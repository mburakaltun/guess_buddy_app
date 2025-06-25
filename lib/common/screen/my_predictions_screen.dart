import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/prediction/model/viewmodel/prediction_card_model.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_user_predictions.dart';
import 'package:guess_buddy_app/common/model/exception/api_exception.dart';

class MyPredictionsScreen extends StatefulWidget {
  final Function(int)? onNavigate;
  const MyPredictionsScreen({super.key, this.onNavigate});

  @override
  State<MyPredictionsScreen> createState() => _MyPredictionsScreenState();
}

class _MyPredictionsScreenState extends State<MyPredictionsScreen> {
  final PredictionService _predictionService = PredictionService();
  final ScrollController _scrollController = ScrollController();

  List<PredictionCardModel> predictions = [];
  bool _isLoading = false;
  bool _isPaginating = false;
  String? _error;

  int _currentPage = 0;
  final int _pageSize = 5;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchPredictions(page: _currentPage, refresh: true);
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
      final request = RequestGetUserPredictions(page: page, size: _pageSize);
      final response = await _predictionService.getUserPredictions(requestGetUserPredictions: request);

      setState(() {
        final newPredictions = response.predictionDtoList.map((dto) => PredictionCardModel(
          id: dto.id,
          title: dto.title,
          description: dto.description,
          voteCount: dto.voteCount,
          averageScore: dto.averageScore,
          createdDate: dto.createdDate,
          creatorUserId: dto.creatorUserId,
          userScore: dto.userScore,
          creatorUsername: dto.creatorUsername,
        )).toList();

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

  Future<void> _loadMorePredictions() async {
    if (_hasMore && !_isPaginating) {
      await _fetchPredictions(page: _currentPage + 1);
    }
  }

  Future<void> _onRefresh() async {
    await _fetchPredictions(page: 0, refresh: true);
  }

  Widget _buildPredictionCard(PredictionCardModel prediction) {
    final bool hasVotes = prediction.voteCount > 0;
    final bool isPositive = prediction.averageScore >= 2.5;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Created date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    prediction.createdDate,
                    style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurface.withOpacity(0.6))
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Title
            Text(
                prediction.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
            ),

            const SizedBox(height: 8),

            // Description
            Text(
                prediction.description,
                style: const TextStyle(fontSize: 15)
            ),

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
                      style: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),

                // Rating status
                if (prediction.voteCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDarkMode
                          ? (isPositive ? Colors.green.shade900.withOpacity(0.4) : Colors.red.shade900.withOpacity(0.4))
                          : (isPositive ? Colors.green.shade50 : Colors.red.shade50),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isPositive ? Colors.green.shade700 : Colors.red.shade700,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isPositive ? Icons.check_circle : Icons.cancel,
                          size: 16,
                          color: isPositive ? Colors.green.shade400 : Colors.red.shade400,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isPositive
                              ? context.message.predictionFeedPositive
                              : context.message.predictionFeedNegative,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isPositive ? Colors.green.shade400 : Colors.red.shade400,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? theme.colorScheme.surface
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                prediction.averageScore.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDarkMode ? theme.cardColor : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.dividerColor, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.hourglass_empty,
                          size: 16,
                          color: theme.disabledColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          context.message.predictionFeedNotVotedYet,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: theme.disabledColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
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
              onPressed: () => _fetchPredictions(page: 0, refresh: true),
              icon: const Icon(Icons.refresh),
              label: Text(context.message.generalTryAgain),
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
            Icon(Icons.psychology, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
                context.message.myPredictionsEmpty,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700)
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to "Add Prediction" tab (index 2) instead of pushing a new route
                if (widget.onNavigate != null) {
                  widget.onNavigate!(2); // 2 is the index for AddPredictionScreen in your tabs
                }
              },
              icon: const Icon(Icons.add),
              label: Text(context.message.myPredictionsCreate),
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

  @override
  Widget build(BuildContext context) {
    if (_isLoading && predictions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(context.message.myPredictionsLoadingPredictions, style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onSurface))
          ],
        ),
      );
    }

    if (_error != null && predictions.isEmpty) {
      return _buildErrorState();
    }

    return predictions.isEmpty && !_isLoading && !_isPaginating
        ? _buildEmptyState()
        : RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: predictions.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == predictions.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return _buildPredictionCard(predictions[index]);
        },
      ),
    );
  }
}