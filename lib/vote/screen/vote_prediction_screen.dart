import 'package:flutter/material.dart';
import 'package:guess_buddy_app/prediction/model/viewmodel/prediction_card_model.dart';
import 'package:guess_buddy_app/vote/service/vote_service.dart';
import '../model/request/request_vote_prediction.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';

class VotePredictionScreen extends StatefulWidget {
  final PredictionCardModel prediction;

  const VotePredictionScreen({super.key, required this.prediction});

  @override
  State<VotePredictionScreen> createState() => _VotePredictionScreenState();
}

class _VotePredictionScreenState extends State<VotePredictionScreen> {
  final VoteService _voteService = VoteService();
  int? selectedScore;
  bool isVoting = false;
  bool hasVoted = false;

  @override
  void initState() {
    super.initState();
    selectedScore = widget.prediction.userScore;
  }

  void _handleVote(int score) async {
    if (isVoting) return;
    final previousScore = selectedScore;

    setState(() {
      selectedScore = score;
      isVoting = true;
    });

    try {
      await _voteService.votePrediction(requestVotePrediction: RequestVotePrediction(predictionId: widget.prediction.id, score: score));
      setState(() {
        hasVoted = true;
      });
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.message.votePredictionSuccess)));
      }
    } catch (e) {
      setState(() {
        selectedScore = previousScore;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.message.votePredictionFailed)));
    } finally {
      setState(() {
        isVoting = false;
      });
    }
  }

  Future<bool> _onWillPop() async {
    Navigator.pop(context, hasVoted);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final prediction = widget.prediction;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(context.message.votePredictionTitle), centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prediction.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(prediction.description, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 12),
                      Text(context.message.votePredictionPublished(prediction.createdDate), style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(context.message.votePredictionHowMuchAgree, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final score = index + 1;
                  return GestureDetector(
                    onTap: () => _handleVote(score),
                    child: AnimatedOpacity(
                      opacity: isVoting && selectedScore != score ? 0.6 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.star, size: 36, color: selectedScore != null && score <= selectedScore! ? Colors.amber : Colors.grey.shade400),
                    ),
                  );
                }),
              ),
              if (selectedScore != null) const Padding(padding: EdgeInsets.only(top: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}