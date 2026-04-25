import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:portfolio/controllers/controllers.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/common_widgets.dart';
import 'package:portfolio/controllers/portfolio_data_controller.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ResponsiveLayout(
        mobileView: portfolioDataController.personalDetailsLoading.value? const Loader(): _buildMobileLayout(context),
        desktopView: portfolioDataController.personalDetailsLoading.value? const Loader(): _buildDesktopLayout(context),
      ),
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

    return Container(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
      child: Text(portfolioDataController.personalDetails.value.aboutMe,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
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
