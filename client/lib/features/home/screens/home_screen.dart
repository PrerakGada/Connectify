import 'package:connectify/features/jobs/screens/employer/employer_job_screen.dart';
import 'package:flutter/material.dart';
import '../../jobs/screens/employee/employee_job_screen.dart';
import '../../schedule/screens/calendar_screen.dart';
import '../../bluetooth/screens/bluetooth_screen.dart';
import '../../profile/screens/profile_screen.dart';

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
      EmployeeJobScreen(),
      CalendarScreen(isEmployee: true),
      BluetoothScreen(isEmployee: true),
      ProfileScreen(isEmployee: true),
    ];

    _employerTabs = [
      EmployerJobScreen(),
      CalendarScreen(isEmployee: false),
      BluetoothScreen(isEmployee: false),
      ProfileScreen(isEmployee: false),
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
