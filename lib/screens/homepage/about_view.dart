import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/common_widgets.dart';
import 'package:portfolio/screens/homepage/portfolio_data_controller.dart';
import 'package:get/get.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure portfolio controller is initialized so data is available
    Get.put(PortfolioDataController(), tag: 'portfolio_data_controller');

    return ResponsiveLayout(
      mobileView: _buildMobileLayout(context),
      desktopView: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutSection(context, horizontalPadding: 10),
        _buildServicesSection(context, horizontalPadding: 10),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAboutSection(context, horizontalPadding: 30),
        _buildServicesSection(context, horizontalPadding: 30),
      ],
    );
  }

  Widget _buildAboutSection(BuildContext context, {required double horizontalPadding}) {
    final controller = Get.find<PortfolioDataController>(tag: 'portfolio_data_controller');
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      child: Obx(() {
        final about = controller.personalDetails.value.aboutMe;
        if (about.isEmpty) {
          // Fallback to legacy hardcoded text
          return buildAboutMeRichText(context);
        }
        return Text(
          about,
          style: Theme.of(context).textTheme.bodyLarge,
        );
      }),
    );
  }

  Widget buildAboutMeRichText(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          _bold("Flutter Developer with 5+ years of experience"),
          const TextSpan(text: " building "),
          _bold("mobile and web applications"),
          const TextSpan(text: " for Android, iOS, and the web using "),
          _bold("Flutter, Dart, and React"),
          const TextSpan(text: ". I follow "),
          _bold("MVVM, MVC, and Clean Architecture"),
          const TextSpan(
              text: " patterns to keep code clean, maintainable, and easy "
                  "to scale.\n\nI have production experience with "),
          _bold("GetX, BLoC, Provider, and Riverpod"),
          const TextSpan(text: " for state management in Flutter, and "),
          _bold("Redux and Context API"),
          const TextSpan(text: " in React. I regularly integrate "),
          _bold("REST APIs"),
          const TextSpan(text: ", "),
          _bold("Firebase"),
          const TextSpan(
              text: " (Auth, Firestore, Realtime Database, Cloud Messaging) "
                  "and "),
          _bold("WebSockets"),
          const TextSpan(
              text: " for real-time features.\n\nI handle projects end to end, "
                  "from "),
          _bold("architecture and API integration"),
          const TextSpan(text: " to "),
          _bold("responsive UI, performance optimisation, and app store deployment"),
          const TextSpan(
              text: ", always focusing on results that work for both the "
                  "user and the business."),
        ],
      ),
    );
  }

  TextSpan _bold(String text) {
    return TextSpan(
      text: text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildServicesSection(BuildContext context, {required double horizontalPadding}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "What I'm doing",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          ResponsiveLayout(
            mobileView: _buildMobileServices(context),
            desktopView: _buildDesktopServices(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileServices(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ServiceCard(
          icon: 'assets/svg/mobile-phone.svg',
          title: "Mobile Apps",
          description: "Professional development of applications for iOS and Android.",
          iconHeight: 55,
        ),
        SizedBox(height: 10),
        _ServiceCard(
          icon: 'assets/svg/web-dev.svg',
          title: "Web Development",
          description: "High-quality development of sites at the professional level.",
          iconHeight: 55,
        ),
      ],
    );
  }

  Widget _buildDesktopServices(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: _ServiceCard(
            icon: 'assets/svg/mobile-phone.svg',
            title: "Mobile Apps",
            description: "Professional development of applications for iOS and Android.",
            iconHeight: 65,
            padding: EdgeInsets.all(30),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: _ServiceCard(
            icon: 'assets/svg/web-dev.svg',
            title: "Web Development",
            description: "High-quality development of sites at the professional level.",
            iconHeight: 55,
            padding: EdgeInsets.all(30),
          ),
        ),
      ],
    );
  }
}

/// Reusable service card widget
class _ServiceCard extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final double iconHeight;
  final EdgeInsets padding;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    this.iconHeight = 55,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      padding: padding,
      style: cardStyle(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon, height: iconHeight),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
