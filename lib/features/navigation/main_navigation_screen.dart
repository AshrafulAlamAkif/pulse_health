import 'package:flutter/material.dart';
import 'package:pulse_health/app/theme/app_colors.dart';
import 'package:pulse_health/features/home/home_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
  });

  @override
  State<MainNavigationScreen> createState() {
    return _MainNavigationScreenState();
  }
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {
  // বর্তমানে কোন bottom navigation item selected
  // সেটা রাখছি।
  //
  // এটা শুধুমাত্র navigation UI state,
  // তাই এখন Riverpod প্রয়োজন নেই।
  int _currentIndex = 0;

  // এখনো Explore, Blood এবং Profile screen তৈরি হয়নি।
  //
  // তাই আপাতত placeholder screen ব্যবহার করছি।
  final List<Widget> _screens = const [
    HomeScreen(),
    _PlaceholderScreen(
      title: 'Explore',
      icon: Icons.explore_rounded,
    ),
    _PlaceholderScreen(
      title: 'Blood',
      icon: Icons.bloodtype_rounded,
    ),
    _PlaceholderScreen(
      title: 'Profile',
      icon: Icons.person_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Selected tab অনুযায়ী screen পরিবর্তন হবে।
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        backgroundColor: Colors.white,
        elevation: 0,

        indicatorColor: AppColors.primary.withValues(
          alpha: 0.12,
        ),

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            selectedIcon: Icon(
              Icons.home_rounded,
            ),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.explore_outlined,
            ),
            selectedIcon: Icon(
              Icons.explore_rounded,
            ),
            label: 'Explore',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.bloodtype_outlined,
            ),
            selectedIcon: Icon(
              Icons.bloodtype_rounded,
            ),
            label: 'Blood',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_outline_rounded,
            ),
            selectedIcon: Icon(
              Icons.person_rounded,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

/// যেসব screen এখনো তৈরি হয়নি,
/// তাদের জন্য temporary placeholder।
class _PlaceholderScreen extends StatelessWidget {
  const _PlaceholderScreen({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 50,
              color: AppColors.primary,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}