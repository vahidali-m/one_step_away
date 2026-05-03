import 'package:flutter/material.dart';
import 'package:one_step_awayname/screen/course_screen.dart';
import 'package:one_step_awayname/screen/history_screen.dart';
import 'package:one_step_awayname/screen/home_screen.dart';
import 'package:one_step_awayname/screen/profile_screen.dart';
import 'package:one_step_awayname/theme/apptheme.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.bgCard,
          border: const Border(
            top: BorderSide(color: Color(0xFF252540), width: 1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SalomonBottomBar(
              currentIndex: _currentIndex,
              onTap: (i) => setState(() => _currentIndex = i),
              selectedItemColor: AppColors.primaryLight,
              unselectedItemColor: AppColors.textMuted,
              itemPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.home_outlined, size: 24),
                  activeIcon: const Icon(Icons.home_rounded, size: 24),
                  title: Text('Jobs', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.play_circle_outline_rounded, size: 24),
                  activeIcon: const Icon(Icons.play_circle_rounded, size: 24),
                  title: Text('Courses', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.history_rounded, size: 24),
                  activeIcon: const Icon(Icons.history_rounded, size: 24),
                  title: Text('History', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person_outline_rounded, size: 24),
                  activeIcon: const Icon(Icons.person_rounded, size: 24),
                  title: Text('Profile', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}