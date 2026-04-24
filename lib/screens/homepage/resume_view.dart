import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/common_strings.dart';
import 'package:portfolio/utils/common_widgets.dart';

class ResumeView extends StatelessWidget {
  const ResumeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileView: _buildMobileLayout(context),
      desktopView: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, "Education", Icons.school_outlined),
          TimeLineListView(
            title: "Education",
            data: CommonStrings.educationMap.reversed.toList(),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(context, "Experience", Icons.school_outlined),
          TimeLineListView(
            title: "Experience",
            data: CommonStrings.experienceMap,
          ),
          const SizedBox(height: 40),
          _buildSkillsSection(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDesktopEducationHeader(context),
          TimeLineListView(
            title: "Education",
            data: CommonStrings.educationMap.reversed.toList(),
          ),
          const SizedBox(height: 20),
          _buildSectionHeader(context, "Experience", Icons.school_outlined),
          TimeLineListView(
            title: "Experience",
            data: CommonStrings.experienceMap,
          ),
          const SizedBox(height: 40),
          _buildSkillsSection(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Neumorphic(
          padding: const EdgeInsets.all(12),
          style: cardStyle(radius: 12),
          child: Icon(icon, color: AppColors.accent, size: 18),
        ),
        const SizedBox(width: 20),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  Widget _buildDesktopEducationHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Neumorphic(
              padding: const EdgeInsets.all(12),
              style: cardStyle(radius: 12),
              child: const Icon(Icons.school_outlined,
                  color: AppColors.accent, size: 18),
            ),
            const SizedBox(width: 20),
            Text(
              "Education",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        downloadCVButton(),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My Skills",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 20),
        Center(
          child: Wrap(
            runSpacing: 20,
            spacing: 20,
            children: _buildSkillCards(),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildSkillCards() {
    return [
      _SkillCard(
        title: "Flutter",
        child: SvgPicture.asset('assets/svg/flutter.svg', height: 65),
      ),
      _SkillCard(
        title: "React",
        child: SvgPicture.asset('assets/svg/react.svg', height: 65),
      ),
      _SkillCard(
        title: "React Native",
        child: SvgPicture.asset('assets/svg/react.svg', height: 65),
      ),
      _SkillCard(
        title: "Dart",
        child: SvgPicture.asset('assets/svg/dart.svg', height: 65),
      ),
      _SkillCard(
        title: "Javascript",
        child: Image.asset('assets/images/javascript.png', height: 65),
      ),
    ];
  }
}

/// Skill card widget
class _SkillCard extends StatelessWidget {
  final String title;
  final Widget? child;

  const _SkillCard({
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      style: cardStyle(radius: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          child ?? const SizedBox(),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
