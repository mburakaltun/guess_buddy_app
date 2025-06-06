import 'package:flutter/material.dart';
import 'package:guess_buddy_app/common/extension/localization_extension.dart';
import 'package:guess_buddy_app/common/screen/users_screen.dart';
import '../../prediction/screen/prediction_feed_screen.dart';
import '../../prediction/screen/add_prediction_screen.dart';
import 'voting_pending_screen.dart';
import '../../user/screen/profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [PredictionFeedScreen(), RankingsScreen(), AddPredictionScreen(), VotingPendingScreen(), ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      context.message.dashboardHome,
      context.message.dashboardRanking,
      context.message.dashboardAddPrediction,
      context.message.dashboardVotingPending,
      context.message.dashboardProfile,
    ];

    final navItems = [
      BottomNavigationBarItem(icon: const Icon(Icons.home), label: context.message.dashboardHome),
      BottomNavigationBarItem(icon: const Icon(Icons.leaderboard), label: context.message.dashboardRanking),
      BottomNavigationBarItem(icon: const Icon(Icons.add_box), label: context.message.dashboardAddPrediction),
      BottomNavigationBarItem(icon: const Icon(Icons.how_to_vote), label: context.message.dashboardVotingPending),
      BottomNavigationBarItem(icon: const Icon(Icons.person), label: context.message.dashboardProfile),
    ];


    return Scaffold(
      appBar: AppBar(title: Text(titles[_selectedIndex])),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: navItems,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
