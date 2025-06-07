import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/prediction/model/dto/user_prediction_hit_rate_dto.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_user_prediction_rates.dart';
import 'package:guess_buddy_app/prediction/service/prediction_service.dart';
import '../../common/model/exception/api_exception.dart';

class RankingsScreen extends StatefulWidget {
  const RankingsScreen({super.key});

  @override
  State<RankingsScreen> createState() => _RankingsScreenState();
}

class _RankingsScreenState extends State<RankingsScreen> {
  final PredictionService _predictionService = PredictionService();

  List<UserPredictionHitRateDto> _users = [];
  bool _isLoading = false;
  bool _isPaginating = false;
  String? _error;

  int _currentPage = 0;
  final int _pageSize = 20;
  bool _hasMore = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchUsers(refresh: true);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isPaginating && _hasMore) {
      _fetchUsers(page: _currentPage + 1);
    }
  }

  Future<void> _fetchUsers({int page = 0, bool refresh = false}) async {
    if (_isLoading || _isPaginating) return;

    if (refresh) {
      setState(() {
        _isLoading = true;
        _error = null;
        _users.clear();
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
      final request = RequestGetUserPredictionRates(page: page, size: _pageSize);
      final response = await _predictionService.getUserPredictionRates(requestGetUserPredictionRates: request);

      setState(() {
        if (refresh) {
          _users = response.userPredictionHitRateDtoList;
        } else {
          _users.addAll(response.userPredictionHitRateDtoList);
        }
        _hasMore = response.number! < (response.totalPages! - 1);
        _currentPage = response.number!;
      });
    } on ApiException catch (e) {
      setState(() {
        _error = e.errorMessage;
      });
    } catch (_) {
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

  Future<void> _onRefresh() async {
    await _fetchUsers(refresh: true);
  }

  Color _getSuccessRateColor(double rate) {
    if (rate >= 0.7) return Colors.green.shade600;
    if (rate >= 0.5) return Colors.amber.shade700;
    return Colors.redAccent;
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
    );
  }

  Widget _buildUserCard(UserPredictionHitRateDto user, int index) {
    final successRate = user.successRate;
    final successRatePercent = (successRate * 100).toStringAsFixed(1);
    final successRateColor = _getSuccessRateColor(successRate);

    final isTopThree = index < 3;
    final rankIcons = ['🥇', '🥈', '🥉'];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: isTopThree ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isTopThree ? BorderSide(color: successRateColor, width: 1.5) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            if (isTopThree)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: successRateColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  rankIcons[index],
                  style: const TextStyle(fontSize: 20),
                ),
              )
            else
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: successRate,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(successRateColor),
                            minHeight: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '$successRatePercent%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: successRateColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${user.successfulPredictionCount} / ${user.totalPredictionCount} ${context.message.usersPredictions}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.redAccent.withOpacity(0.8)),
          const SizedBox(height: 16),
          Text(
            _error ?? context.message.generalError,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _fetchUsers(refresh: true),
            icon: const Icon(Icons.refresh),
            label: Text(context.message.generalTryAgain),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey.withOpacity(0.8)),
          const SizedBox(height: 16),
          Text(
            context.message.usersNoUsersFound,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading && _users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(context.message.usersLoadingUsers)
          ],
        ),
      );
    }

    if (_error != null && _users.isEmpty) {
      return _buildErrorState();
    }

    if (_users.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _users.length + (_hasMore ? 1 : 0) + 1, // +1 for header
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }

          final userIndex = index - 1;

          if (userIndex == _users.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final user = _users[userIndex];
          return _buildUserCard(user, userIndex);
        },
      ),
    );
  }
}