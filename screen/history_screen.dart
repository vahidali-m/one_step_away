import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:one_step_awayname/mock/mock_data.dart';
import 'package:one_step_awayname/theme/apptheme.dart';
import '../../models/models.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filterStatus = 'All';
  final List<String> _statuses = ['All', 'Applied', 'Shortlisted', 'Interview', 'Hired', 'Rejected'];

  List<HistoryItem> get _filtered {
    if (_filterStatus == 'All') return MockData.history;
    return MockData.history.where((h) => h.status == _filterStatus).toList();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Hired':
        return AppColors.accentGreen;
      case 'Interview':
        return AppColors.accent;
      case 'Shortlisted':
        return AppColors.primaryLight;
      case 'Rejected':
        return AppColors.accentRed;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _statusIcon(String status) {
    switch (status) {
      case 'Hired':
        return Icons.check_circle_rounded;
      case 'Interview':
        return Icons.video_call_rounded;
      case 'Shortlisted':
        return Icons.star_rounded;
      case 'Rejected':
        return Icons.cancel_rounded;
      default:
        return Icons.send_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final stats = _buildStats();
    return Scaffold(
      backgroundColor: AppColors.bgDark,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0A2520), AppColors.bgDark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Applications 📊',
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 6),
                  Text(
                    'Track your job application journey',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Stats grid
                  Row(
                    children: stats
                        .asMap()
                        .entries
                        .map((e) => Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: e.key < stats.length - 1 ? 12 : 0),
                                child: _StatCard(
                                  label: e.value['label'],
                                  count: e.value['count'],
                                  color: e.value['color'],
                                  icon: e.value['icon'],
                                ).animate(delay: Duration(milliseconds: 100 * e.key + 200)).fadeIn(duration: 400.ms),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),

          // Filter tabs
          SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 24),
                itemCount: _statuses.length,
                itemBuilder: (context, i) {
                  final isSelected = _statuses[i] == _filterStatus;
                  final color = i == 0
                      ? AppColors.primary
                      : _statusColor(_statuses[i]);
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => _filterStatus = _statuses[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withOpacity(0.2)
                              : AppColors.bgCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? color : AppColors.bgCardLight,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Text(
                          _statuses[i],
                          style: GoogleFonts.plusJakartaSans(
                            color: isSelected ? color : AppColors.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ).animate(delay: 250.ms).fadeIn(duration: 400.ms),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),

          // History list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final item = _filtered[i];
                  final statusColor = _statusColor(item.status);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.bgCard,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: AppColors.bgCardLight),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: CachedNetworkImage(
                                  imageUrl: item.logo,
                                  fit: BoxFit.contain,
                                  errorWidget: (_, __, ___) => Center(
                                    child: Text(
                                      item.company[0],
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.jobTitle,
                                    style: GoogleFonts.spaceGrotesk(
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    item.company,
                                    style: GoogleFonts.plusJakartaSans(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today_outlined,
                                          color: AppColors.textMuted, size: 12),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Applied ${item.appliedDate}',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: AppColors.textMuted,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: statusColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: statusColor.withOpacity(0.3)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(_statusIcon(item.status),
                                          color: statusColor, size: 12),
                                      const SizedBox(width: 4),
                                      Text(
                                        item.status,
                                        style: GoogleFonts.plusJakartaSans(
                                          color: statusColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                        .animate(delay: Duration(milliseconds: 80 * i + 200))
                        .fadeIn(duration: 400.ms)
                        .slideX(begin: 0.1, end: 0),
                  );
                },
                childCount: _filtered.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _buildStats() {
    final history = MockData.history;
    return [
      {
        'label': 'Applied',
        'count': history.length,
        'color': AppColors.primaryLight,
        'icon': Icons.send_rounded,
      },
      {
        'label': 'Interview',
        'count': history.where((h) => h.status == 'Interview').length,
        'color': AppColors.accent,
        'icon': Icons.video_call_rounded,
      },
      {
        'label': 'Hired',
        'count': history.where((h) => h.status == 'Hired').length,
        'color': AppColors.accentGreen,
        'icon': Icons.check_circle_rounded,
      },
    ];
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;
  const _StatCard({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            count.toString(),
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

extension on CachedNetworkImage {
  CachedNetworkImage get padding => this;
}