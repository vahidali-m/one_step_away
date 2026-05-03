import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:one_step_awayname/screen/login_screen.dart';
import 'package:one_step_awayname/theme/apptheme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<_OnboardData> _pages = [
    _OnboardData(
      emoji: '🚀',
      title: 'Land your\ndream job',
      subtitle: 'Browse thousands of jobs from top companies worldwide, all in one place.',
      gradient: AppColors.primaryGradient,
      bgColor: const Color(0xFF1A1040),
    ),
    _OnboardData(
      emoji: '📚',
      title: 'Level up your\nskills',
      subtitle: 'Curated courses from industry experts to make you job-ready faster.',
      gradient: AppColors.accentGradient,
      bgColor: const Color(0xFF0A2535),
    ),
    _OnboardData(
      emoji: '📊',
      title: 'Track every\napplication',
      subtitle: 'Never lose track of where you applied. Stay organized, stay ahead.',
      gradient: const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFF059669)],
      ),
      bgColor: const Color(0xFF0A2520),
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemCount: _pages.length,
            itemBuilder: (context, i) => _OnboardPage(data: _pages[i]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 52),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.bgDark.withOpacity(0.95)],
                ),
              ),
              child: Column(
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: _pages.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.primary,
                      dotColor: AppColors.bgCard,
                      dotHeight: 8,
                      dotWidth: 8,
                      expansionFactor: 3,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      if (_currentPage > 0)
                        GestureDetector(
                          onTap: () => _controller.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          ),
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.bgCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.bgCardLight),
                            ),
                            child: const Icon(Icons.arrow_back_rounded,
                                color: AppColors.textSecondary),
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: _next,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: _pages[_currentPage].gradient,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.4),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                _currentPage == _pages.length - 1
                                    ? 'Get Started'
                                    : 'Continue',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _goToLogin,
                    child: Text(
                      'Skip for now',
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.textMuted,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardData {
  final String emoji;
  final String title;
  final String subtitle;
  final LinearGradient gradient;
  final Color bgColor;
  const _OnboardData({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.bgColor,
  });
}

class _OnboardPage extends StatelessWidget {
  final _OnboardData data;
  const _OnboardPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgDark,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: data.bgColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Text(data.emoji, style: const TextStyle(fontSize: 100))
                        .animate()
                        .scale(
                          begin: const Offset(0.5, 0.5),
                          duration: 600.ms,
                          curve: Curves.elasticOut,
                        ),
                    const SizedBox(height: 32),
                    _buildIllustration(data),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 36, 32, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        data.gradient.createShader(bounds),
                    child: Text(
                      data.title,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.1,
                      ),
                    ),
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 16),
                  Text(
                    data.subtitle,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration(_OnboardData data) {
    return Container(
      width: 220,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ...List.generate(3, (i) => Positioned(
            left: i * 30.0,
            child: Container(
              width: 140 - i * 10,
              height: 75 - i * 5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    data.gradient.colors[0].withOpacity(0.3 - i * 0.08),
                    data.gradient.colors[1].withOpacity(0.2 - i * 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: data.gradient.colors[0].withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}