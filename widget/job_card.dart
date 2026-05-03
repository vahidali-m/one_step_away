import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:one_step_awayname/theme/apptheme.dart';
import '../models/models.dart';

class JobCard extends StatefulWidget {
  final Job job;
  const JobCard({super.key, required this.job});

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool _saved = false;

  Color get _typeColor {
    switch (widget.job.type) {
      case 'Remote': return AppColors.accentGreen;
      case 'Part-time': return AppColors.accentWarm;
      case 'Contract': return AppColors.accentRed;
      default: return AppColors.primaryLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.bgCardLight, width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          splashColor: AppColors.primary.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 2))],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: CachedNetworkImage(
                          imageUrl: widget.job.logo, fit: BoxFit.contain,
                          errorWidget: (_, __, ___) => Center(child: Text(widget.job.company[0],
                            style: TextStyle(color: widget.job.accentColor ?? AppColors.primary, fontWeight: FontWeight.w800, fontSize: 20))),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget.job.company, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(widget.job.title, style: GoogleFonts.spaceGrotesk(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700), maxLines: 1, overflow: TextOverflow.ellipsis),
                  ])),
                  GestureDetector(
                    onTap: () => setState(() => _saved = !_saved),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: _saved ? AppColors.primary.withOpacity(0.15) : AppColors.bgCardLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(_saved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                        color: _saved ? AppColors.primaryLight : AppColors.textMuted, size: 20),
                    ),
                  ),
                ]),
                const SizedBox(height: 14),
                Row(children: [
                  _Tag(label: widget.job.type, color: _typeColor),
                  const SizedBox(width: 8),
                  _Tag(label: widget.job.category, color: AppColors.accent),
                  const Spacer(),
                  Row(children: [
                    const Icon(Icons.access_time_rounded, color: AppColors.textMuted, size: 13),
                    const SizedBox(width: 4),
                    Text(widget.job.postedDate, style: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 12)),
                  ]),
                ]),
                const SizedBox(height: 14),
                const Divider(color: AppColors.bgCardLight, height: 1),
                const SizedBox(height: 14),
                Row(children: [
                  const Icon(Icons.location_on_outlined, color: AppColors.textMuted, size: 15),
                  const SizedBox(width: 4),
                  Text(widget.job.location, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 13)),
                  const Spacer(),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(widget.job.salary, style: GoogleFonts.spaceGrotesk(color: AppColors.accentGreen, fontSize: 14, fontWeight: FontWeight.w700)),
                    Text('${widget.job.applicants} applicants', style: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 11)),
                  ]),
                ]),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8, runSpacing: 8,
                  children: widget.job.skills.take(3).map((skill) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: AppColors.bgCardLight, borderRadius: BorderRadius.circular(8)),
                    child: Text(skill, style: GoogleFonts.plusJakartaSans(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
                  )).toList(),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity, height: 46,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4))],
                    ),
                    child: Center(child: Text('Apply Now', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: GoogleFonts.plusJakartaSans(color: color, fontSize: 11, fontWeight: FontWeight.w700)),
    );
  }
}