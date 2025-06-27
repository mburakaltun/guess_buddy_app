import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/prediction/model/viewmodel/prediction_card_model.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_predictions.dart';
import 'package:guess_buddy_app/common/model/exception/api_exception.dart';
import 'package:guess_buddy_app/common/utility/dialog_utility.dart';
import 'package:guess_buddy_app/vote/service/vote_service.dart';
import 'package:guess_buddy_app/vote/model/request/request_vote_prediction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/model/shared_preferences/shared_preferences_key.dart';
import '../model/dto/prediction_dto.dart';

class PredictionFeedScreen extends StatefulWidget {
  const PredictionFeedScreen({super.key});

  @override
  State<PredictionFeedScreen> createState() => _PredictionFeedScreenState();
}

class _PredictionFeedScreenState extends State<PredictionFeedScreen> {
  final PredictionService _predictionService = PredictionService();
  final VoteService _voteService = VoteService();
  final ScrollController _scrollController = ScrollController();

  List<PredictionCardModel> predictions = [];
  bool _isLoading = false;
  bool _isPaginating = false;
  String? _error;
  String? _userId;
  int? _activePredictionId;

  // Track which prediction is being voted on
  String? _votingPredictionId;

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

  Future<void> _handleVote(int predictionId, int score) async {
    if (_votingPredictionId != null) return;

    setState(() {
      _votingPredictionId = predictionId.toString();
    });

    try {
      final response = await _voteService.votePrediction(
          requestVotePrediction: RequestVotePrediction(
              predictionId: predictionId,
              score: score
          )
      );

      setState(() {
        final index = predictions.indexWhere((p) => p.id == predictionId);
        if (index != -1) {
          final updatedPrediction = predictions[index];

          // Create updated prediction with backend response data
          predictions[index] = PredictionCardModel(
            id: updatedPrediction.id,
            title: updatedPrediction.title,
            description: updatedPrediction.description,
            voteCount: response.voteCount ?? updatedPrediction.voteCount + 1,
            averageScore: response.averageScore ?? updatedPrediction.averageScore,
            createdDate: updatedPrediction.createdDate,
            creatorUserId: updatedPrediction.creatorUserId,
            userScore: score, // Set to the new score
            creatorUsername: updatedPrediction.creatorUsername,
          );

          // Close the voting section after voting
          _activePredictionId = null;
        }
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.message.votePredictionSuccess),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: context.message.generalDismiss,
              textColor: Colors.white,
              onPressed: () {},
            ),
          )
      );

    } catch (e) {
      DialogUtility.handleApiError(
          context: context,
          error: e,
          title: context.message.votePredictionFailed
      );
    } finally {
      setState(() {
        _votingPredictionId = null;
      });
    }
  }

  void _toggleVotingSection(int predictionId) {
    setState(() {
      _activePredictionId = _activePredictionId == predictionId ? null : predictionId;
    });
  }

  void _resetUserScore(int predictionId) {
    final index = predictions.indexWhere((p) => p.id == predictionId);
    if (index != -1) {
      final prediction = predictions[index];
      setState(() {
        predictions[index] = PredictionCardModel(
          id: prediction.id,
          title: prediction.title,
          description: prediction.description,
          voteCount: prediction.voteCount,
          averageScore: prediction.averageScore,
          createdDate: prediction.createdDate,
          creatorUserId: prediction.creatorUserId,
          userScore: 0,
          creatorUsername: prediction.creatorUsername,
        );
        // Open the voting section
        _activePredictionId = predictionId;
      });
    }
  }

  Widget _buildPredictionCard(PredictionCardModel prediction, bool isOtherUser) {
    final bool hasVotes = prediction.voteCount > 0;
    final bool isPositive = prediction.averageScore >= 2.5;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isVoting = _votingPredictionId == prediction.id.toString();
    final showVotingUI = isOtherUser && (prediction.userScore == null || _activePredictionId == prediction.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primary.withOpacity(0.2),
                  radius: 20,
                  child: Text(
                    prediction.creatorUsername.isNotEmpty ? prediction.creatorUsername[0].toUpperCase() : '?',
                    style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '@${prediction.creatorUsername}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface.withOpacity(0.7)
                          )
                      ),
                      Text(
                          prediction.createdDate,
                          style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onSurface.withOpacity(0.5)
                          )
                      ),
                    ],
                  ),
                ),

                // Vote now badge or user's score
                if (isOtherUser)
                  prediction.userScore != null
                      ? _buildUserRatingBadge(prediction.userScore!.toInt(), colorScheme)
                      : _buildVoteNowBadge(colorScheme),
              ],
            ),
          ),

          // Prediction content
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  prediction.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  prediction.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),

                const SizedBox(height: 16),

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Vote count
                    Row(
                      children: [
                        Icon(
                            Icons.people,
                            size: 16,
                            color: colorScheme.onSurface.withOpacity(0.6)
                        ),
                        const SizedBox(width: 4),
                        Text(
                          context.message.predictionFeedVoteCount(prediction.voteCount),
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),

                    // Status indicator
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: hasVotes
                            ? (isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1))
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            hasVotes
                                ? (isPositive ? Icons.thumb_up : Icons.thumb_down)
                                : Icons.pending,
                            size: 14,
                            color: hasVotes
                                ? (isPositive ? Colors.green : Colors.red)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hasVotes
                                ? (isPositive
                                ? context.message.predictionFeedPositive
                                : context.message.predictionFeedNegative)
                                : context.message.predictionFeedNotVotedYet,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: hasVotes
                                  ? (isPositive ? Colors.green : Colors.red)
                                  : Colors.grey,
                            ),
                          ),
                          if (hasVotes) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.star, size: 12, color: Colors.amber),
                                  const SizedBox(width: 2),
                                  Text(
                                    prediction.averageScore.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
                                    ),
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

                // Voting action for other users' predictions
                if (isOtherUser) ...[
                  const SizedBox(height: 12),
                  _buildVoteActionRow(prediction, colorScheme),
                ],
              ],
            ),
          ),

          // Voting UI
          if (showVotingUI && !isVoting)
            _buildVotingSection(prediction.id, colorScheme),

          // Loading UI when voting
          if (isVoting)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.5),
                border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.message.predictionFeedSubmittingVote,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUserRatingBadge(int score, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.tertiary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.tertiary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Text(
            context.message.predictionFeedYourRating,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.tertiary,
            ),
          ),
          ...List.generate(
            score,
                (index) => const Icon(Icons.star, size: 12, color: Colors.amber),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteNowBadge(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.how_to_vote, size: 12, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            context.message.predictionFeedVoteNow,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoteActionRow(PredictionCardModel prediction, ColorScheme colorScheme) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _toggleVotingSection(prediction.id),
            icon: const Icon(Icons.star_rate, size: 16),
            label: Text(prediction.userScore != null
                ? context.message.predictionFeedChangeRating
                : context.message.predictionFeedRatePrediction),
            style: ElevatedButton.styleFrom(
              backgroundColor: prediction.userScore != null
                  ? Colors.transparent
                  : colorScheme.primary,
              foregroundColor: prediction.userScore != null
                  ? colorScheme.primary
                  : colorScheme.onPrimary,
              elevation: prediction.userScore != null ? 0 : 2,
              padding: const EdgeInsets.symmetric(vertical: 10),
              side: prediction.userScore != null
                  ? BorderSide(color: colorScheme.primary.withOpacity(0.5))
                  : BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVotingSection(int predictionId, ColorScheme colorScheme) {
    // Find the current prediction to get user's score if it exists
    final prediction = predictions.firstWhere((p) => p.id == predictionId);
    final int? userScore = prediction?.userScore;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        border: Border(top: BorderSide(color: colorScheme.outlineVariant)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              final score = index + 1;
              final bool isSelected = userScore != null && score <= userScore;

              return GestureDetector(
                onTap: () => _handleVote(predictionId, score),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        isSelected ? Icons.star : Icons.star_border,
                        size: 32,
                        color: isSelected
                            ? Colors.amber
                            : Colors.amber.withOpacity(0.5),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        score.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          Divider(color: colorScheme.outlineVariant),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => _toggleVotingSection(predictionId),
              child: Text(context.message.generalCancel),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.error,
              ),
            ),
          ),
        ],
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
            Icon(Icons.content_paste_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
                context.message.predictionFeedNoPredictions,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey.shade700)
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && predictions.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(context.message.predictionFeedLoadingPredictions)
            ],
          ),
        ),
      );
    }

    if (_error != null && predictions.isEmpty) {
      return Scaffold(body: _buildErrorState());
    }

    if (_userId == null) {
      return Scaffold(
          body: Center(child: Text(context.message.predictionFeedUserNotFound))
      );
    }

    return Scaffold(
      body: predictions.isEmpty && !_isLoading && !_isPaginating
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
            final prediction = predictions[index];
            final isOtherUser = _userId != null && prediction.creatorUserId.toString() != _userId;
            return _buildPredictionCard(prediction, isOtherUser);
          },
        ),
      ),
    );
  }
}