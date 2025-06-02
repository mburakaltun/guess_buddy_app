import 'package:flutter/material.dart';
import 'package:guess_buddy_app/screens/users_screen.dart';
import 'home_screen.dart';
import '../prediction/screen/add_prediction_screen.dart';
import 'voting_pending_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    UsersScreen(),
    AddPredictionScreen(),
    VotingPendingScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = [
    'Home',
    'Users',
    'Add Prediction',
    'Voting Pending',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Users'),
    BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Add'),
    BottomNavigationBarItem(icon: Icon(Icons.how_to_vote), label: 'Voting'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _navItems,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
