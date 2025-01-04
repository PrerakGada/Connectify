import 'package:auto_route/auto_route.dart';
import 'package:connectify/core/router/app_router.dart';
import 'package:flutter/material.dart';
import '../../jobs/screens/jobs_screen.dart';
import '../../schedule/screens/calendar_screen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final bool isEmployee;

  const HomeScreen({
    super.key,
    required this.isEmployee,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _employeeTabs;
  late final List<Widget> _employerTabs;

  @override
  void initState() {
    super.initState();
    _employeeTabs = [
      JobsScreen(isEmployee: true),
      CalendarScreen(isEmployee: true),
      const Center(child: Text('Bluetooth - Employee View')),
      const Center(child: Text('Profile - Employee View')),
    ];

    _employerTabs = [
      JobsScreen(isEmployee: false),
      CalendarScreen(isEmployee: false),
      const Center(child: Text('Bluetooth - Employer View')),
      const Center(child: Text('Profile - Employer View')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.isEmployee ? _employeeTabs : _employerTabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth),
            label: 'Bluetooth',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
