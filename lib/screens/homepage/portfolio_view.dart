import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:portfolio/screens/homepage/portfolio_data_controller.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/common_strings.dart';
import 'package:portfolio/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure portfolio controller is initialized
    Get.put(PortfolioDataController(), tag: 'portfolio_data_controller');

    return ResponsiveLayout(
      mobileView: _buildMobileLayout(context),
      desktopView: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: GetX<PortfolioDataController>(
        tag: 'portfolio_data_controller',
        builder: (controller) {
          final children = _buildPortfolioCards(context);
          return Wrap(
            spacing: 20,
            runSpacing: 30,
            crossAxisAlignment: WrapCrossAlignment.center,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            children: children,
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: GetX<PortfolioDataController>(
        tag: 'portfolio_data_controller',
        builder: (controller) {
          final children = _buildPortfolioCards(context);
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            children: children,
          );
        },
      ),
    );
  }

  List<Widget> _buildPortfolioCards(BuildContext context) {
    final controller = Get.find<PortfolioDataController>(tag: 'portfolio_data_controller');
    final projects = controller.projectList.value;
    if (projects.isEmpty) {
      // Fallback to legacy list
      final portfolios = [
        CommonStrings.remoteCursorPackage,
        CommonStrings.portfolioApp,
        CommonStrings.workAnywhereApp,
        CommonStrings.talentAnywhereApp,
        CommonStrings.darknetDiariesApp,
        CommonStrings.neoMartApp,
        CommonStrings.libriVoxApp,
      ];
      return portfolios.map((p) => _PortfolioCard(portfolioInfo: p)).toList();
    }
    return projects
        .map((proj) => _PortfolioCard(portfolioInfo: {
              'title': proj.title,
              'type': proj.type,
              'coverImage': proj.coverImage,
              'iconUrl': proj.iconUrl,
              'playstoreUrl': proj.playstoreUrl,
              'about': proj.about,
            }))
        .toList();
  }
}

/// Portfolio card widget
class _PortfolioCard extends StatelessWidget {
  final Map<String, String> portfolioInfo;

  const _PortfolioCard({required this.portfolioInfo});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileView: _buildMobileCard(context),
      desktopView: _buildDesktopCard(context),
    );
  }

  Widget _buildMobileCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PortfolioImage(
          image: portfolioInfo['coverImage']!,
          maxWidth: 350,
          onTap: () => _showPortfolioDialog(context),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _PortfolioInfo(
            title: portfolioInfo['title']!,
            type: portfolioInfo['type']!,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PortfolioImage(
          image: portfolioInfo['coverImage']!,
          maxWidth: 250,
          maxHeight: 200,
          onTap: () => _showPortfolioDialog(context),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _PortfolioInfo(
            title: portfolioInfo['title']!,
            type: portfolioInfo['type']!,
          ),
        ),
      ],
    );
  }

  void _showPortfolioDialog(BuildContext context) {
    Get.dialog(
      _PortfolioDialog(portfolioInfo: portfolioInfo),
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 500),
      transitionCurve: Curves.easeInOut,
      useSafeArea: true,
    );
  }
}

/// Portfolio image widget
class _PortfolioImage extends StatelessWidget {
  final String image;
  final double? maxWidth;
  final double? maxHeight;
  final VoidCallback onTap;

  const _PortfolioImage({
    required this.image,
    required this.onTap,
    this.maxWidth,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? double.infinity,
          maxHeight: maxHeight ?? double.infinity,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: image.startsWith('http')
              ? Image.network(image, fit: BoxFit.cover)
              : Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}

/// Portfolio info widget
class _PortfolioInfo extends StatelessWidget {
  final String title;
  final String type;

  const _PortfolioInfo({
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 1,
        ),
        Text(
          type,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 1,
        ),
      ],
    );
  }
}

/// Portfolio dialog widget
class _PortfolioDialog extends StatelessWidget {
  final Map<String, String> portfolioInfo;

  const _PortfolioDialog({required this.portfolioInfo});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileView: _buildMobileDialog(context),
      desktopView: _buildDesktopDialog(context),
    );
  }

  Widget _buildMobileDialog(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Material(
            elevation: 0,
            color: Colors.transparent,
            child: CustomContainer(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDialogHeader(context, isMobile: true),
                  const SizedBox(height: 20),
                  Expanded(
                    child: _buildDialogBody(context, isMobile: true),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopDialog(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Get.width * 0.45,
          maxHeight: Get.height * 0.7,
        ),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Material(
            elevation: 0,
            color: Colors.transparent,
            child: CustomContainer(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogLeftColumn(context),
                  Expanded(child: _buildDialogBody(context, isMobile: false)),
                  _buildCloseButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context, {required bool isMobile}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _PortfolioIcon(portfolioInfo: portfolioInfo, size: 80),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  portfolioInfo['title']!,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                _buildStoreButton(context, isMobile: isMobile),
              ],
            ),
          ),
        ),
        _buildCloseButton(),
      ],
    );
  }

  Widget _buildDialogLeftColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _PortfolioIcon(portfolioInfo: portfolioInfo, size: 160),
        const SizedBox(height: 40),
        _buildStoreButton(context, isMobile: false),
      ],
    );
  }

  Widget _buildDialogBody(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 20),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Flexible(
                  child: Text(
                    portfolioInfo['title']!,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              if (!isMobile) const SizedBox(height: 20),
              Flexible(
                child: Text(
                  portfolioInfo['about']!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoreButton(BuildContext context, {required bool isMobile}) {
    if (portfolioInfo['playstoreUrl']!.isEmpty) {
      return const SizedBox();
    }

    final isPubDev = portfolioInfo['playstoreUrl']!.contains('pub.dev');
    final buttonText = isPubDev ? "pub.dev" : "Play Store";
    final svgPath = isPubDev ? 'assets/svg/dart.svg' : 'assets/svg/playstore.svg';

    return InkWell(
      onTap: () async {
        if (!await launchUrl(Uri.parse(portfolioInfo['playstoreUrl']!))) {
          throw Exception("could not launch url");
        }
      },
      child: CustomContainer(
        bgColor: AppColors.lightBlackContainer,
        borderColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: isMobile ? 8 : 8,
        ),
        border: 8,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(svgPath, height: 20),
            const SizedBox(width: 8),
            if (!isMobile)
              Text(
                "  $buttonText",
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return InkWell(
      onTap: Get.back,
      child: const AvatarContainer(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(3),
        radius: 8,
        child: Icon(Icons.close, size: 20, color: AppColors.lightGray),
      ),
    );
  }
}

/// Portfolio icon widget
class _PortfolioIcon extends StatelessWidget {
  final Map<String, String> portfolioInfo;
  final double size;

  const _PortfolioIcon({
    required this.portfolioInfo,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AvatarContainer(
      clip: Clip.antiAlias,
      padding: EdgeInsets.zero,
      height: size,
      width: size,
      child: portfolioInfo['iconUrl']! == ""
          ? Image.asset('assets/images/app-icon.jpg', fit: BoxFit.cover)
          : portfolioInfo['iconUrl']!.startsWith('http')
              ? Image.network(portfolioInfo['iconUrl']!, fit: BoxFit.cover)
              : Image.asset(portfolioInfo['iconUrl']!, fit: BoxFit.cover),
    );
  }
}
