import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/screens/homepage/home_controller.dart';
import 'package:portfolio/screens/homepage/portfolio_data_controller.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/common_strings.dart';
import 'package:portfolio/utils/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController(), tag: 'home_controller');
    Get.put(PortfolioDataController(), tag: 'portfolio_data_controller');
    final maxWidth = MediaQuery.of(context).size.width;
    final double padding =
        (maxWidth > 1200) ? (maxWidth - 1200) / 2 : 10;

    return Material(
      color: AppColors.smokeyBlack,
      child: ResponsiveLayout(
        desktopView: _buildDesktopLayout(homeController, maxWidth, padding),
        mobileView: _buildMobileLayout(homeController),
        tabView: _buildTabLayout(homeController, padding),
      ),
    );
  }

  Widget _buildDesktopLayout(
    HomeController homeController,
    double maxWidth,
    double padding,
  ) {
    return Container(
      // constraints: BoxConstraints(
      //   maxWidth: maxWidth < 1440 ? maxWidth : 1440,
      // ),
      padding: EdgeInsets.symmetric(horizontal: padding),
      color: AppColors.smokeyBlack,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 24,
            child: _SideBar(homeController: homeController),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 76,
            child: _MainPage(homeController: homeController),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(HomeController homeController) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(Get.context!).copyWith(scrollbars: false),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                _SideBar(homeController: homeController),
                _MainPage(homeController: homeController),
              ],
            ),
          ),
          Obx(
            () => CustomContainer(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              bgColor: AppColors.lightBlackContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildTabItems(homeController),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabLayout(HomeController homeController, double padding) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(Get.context!).copyWith(scrollbars: false),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10).copyWith(top: 20),
                children: [
                  _SideBar(homeController: homeController),
                  _MainPage(homeController: homeController),
                ],
              ),
            ),
            Obx(
              () => CustomContainer(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                bgColor: AppColors.lightBlackContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildTabItems(homeController),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTabItems(HomeController homeController) {
    return [
      _TabItem(
        title: "About",
        onTap: () => homeController.onSelectTab(0),
        isSelected: homeController.selectedTabIndex.value == 0,
      ),
      _TabItem(
        title: "Resume",
        onTap: () => homeController.onSelectTab(1),
        isSelected: homeController.selectedTabIndex.value == 1,
      ),
      _TabItem(
        title: "Projects",
        onTap: () => homeController.onSelectTab(2),
        isSelected: homeController.selectedTabIndex.value == 2,
      ),
      _TabItem(
        title: "Contact",
        onTap: () => homeController.onSelectTab(3),
        isSelected: homeController.selectedTabIndex.value == 3,
      ),
    ];
  }
}

/// Main page content widget
class _MainPage extends StatelessWidget {
  final HomeController homeController;

  const _MainPage({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ResponsiveLayout(
        mobileView: _buildMobileMainView(context),
        desktopView: _buildDesktopMainView(context),
      ),
    );
  }

  Widget _buildMobileMainView(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPageHeader(context),
          homeController.getTabView(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildDesktopMainView(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60, bottom: 30),
        child: CustomContainer(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageHeaderWithTabs(context),
              homeController.getTabView(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 16),
              child: Text(
                homeController.getTabName(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, top: 15),
              width: 45,
              height: 6,
              decoration: BoxDecoration(
                gradient: AppColors.yellowGradient,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ],
        ),
        if (homeController.selectedTabIndex.value == 1)
          Padding(
            padding: const EdgeInsets.only(right: 10, top: 16),
            child: downloadCVButton(),
          ),
      ],
    );
  }

  Widget _buildPageHeaderWithTabs(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 16),
          child: Text(
            homeController.getTabName(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        CustomContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          bgColor: AppColors.lightBlackContainer,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(17),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TabItemDesktop(
                title: "About",
                onTap: () => homeController.onSelectTab(0),
                isSelected: homeController.selectedTabIndex.value == 0,
              ),
              _TabItemDesktop(
                title: "Resume",
                onTap: () => homeController.onSelectTab(1),
                isSelected: homeController.selectedTabIndex.value == 1,
              ),
              _TabItemDesktop(
                title: "Projects",
                onTap: () => homeController.onSelectTab(2),
                isSelected: homeController.selectedTabIndex.value == 2,
              ),
              _TabItemDesktop(
                title: "Contact",
                onTap: () => homeController.onSelectTab(3),
                isSelected: homeController.selectedTabIndex.value == 3,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Sidebar widget
class _SideBar extends StatelessWidget {
  final HomeController homeController;

  const _SideBar({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ResponsiveLayout(
        mobileView: _buildMobileSidebar(context),
        tabView: _buildTabSidebar(context),
        desktopView: _buildDesktopSidebar(context),
      ),
    );
  }

  Widget _buildMobileSidebar(BuildContext context) {
    return CustomContainer(
      clip: Clip.antiAlias,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildProfileHeader(context, isMobile: true),
          if (homeController.isExpanded.value)
            _buildContactInfo(context, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildTabSidebar(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.only(bottom: 10),
      clip: Clip.antiAlias,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildProfileHeader(context, isMobile: true),
          if (homeController.isExpanded.value)
            _buildContactInfo(context, isMobile: true),
        ],
      ),
    );
  }

  Widget _buildDesktopSidebar(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60, bottom: 30, right: 10),
        child: CustomContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProfileImage(context),
              _buildProfileName(context),
              const SizedBox(height: 20),
              _buildProfileBadge(context),
              const SizedBox(height: 20),
              const Divider(
                color: AppColors.borderColor,
                thickness: 1,
                endIndent: 16,
                indent: 16,
              ),
              const SizedBox(height: 20),
              _buildContactInfo(context, isMobile: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, {required bool isMobile}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ProfileImage(isSmall: isMobile),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileName(context),
                  const SizedBox(height: 10),
                  _buildProfileBadge(context),
                ],
              ),
            ],
          ),
        ),
        _ExpandButton(homeController: homeController),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: AvatarContainer(
        padding: EdgeInsets.zero,
        child: Image.asset("assets/images/profile.png", fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildProfileName(BuildContext context) {
    return Text(
      "Rahul Chauhan",
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProfileBadge(BuildContext context) {
    return CustomContainer(
      bgColor: AppColors.lightBlackContainer,
      borderColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      border: 8,
      child: Text(
        "Flutter Developer",
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context, {required bool isMobile}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMobile) const SizedBox() else const Divider(color: AppColors.borderColor, thickness: 1),
          _CustomListTile(
            icon: Icons.mail_outline_rounded,
            title: "EMAIL",
            subtitle: CommonStrings.myDetails['email'],
            onTap: () {
              launchUrl(
                Uri(scheme: "mailto", path: CommonStrings.myDetails['email']),
                mode: LaunchMode.platformDefault,
              );
            },
          ),
          _CustomListTile(
            icon: Icons.phone_android,
            title: "PHONE",
            subtitle: CommonStrings.myDetails['mobile'],
            onTap: () {
              launchUrl(
                Uri(scheme: "tel", path: CommonStrings.myDetails['mobile']),
                mode: LaunchMode.platformDefault,
              );
            },
          ),
          _CustomListTile(
            icon: Icons.location_on_outlined,
            title: "LOCATION",
            subtitle: CommonStrings.myDetails['address'],
          ),
        ],
      ),
    );
  }
}

/// Profile image widget
class _ProfileImage extends StatelessWidget {
  final bool isSmall;

  const _ProfileImage({required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return AvatarContainer(
      radius: 20,
      padding: EdgeInsets.zero,
      height: isSmall ? 80 : 120,
      width: isSmall ? 80 : 120,
      child: Image.asset("assets/images/profile.png", fit: BoxFit.cover),
    );
  }
}

/// Expand button widget for sidebar
class _ExpandButton extends StatelessWidget {
  final HomeController homeController;

  const _ExpandButton({required this.homeController});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: homeController.toggleExpanded,
      child: CustomContainer(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          topRight: Radius.circular(17),
        ),
        padding: const EdgeInsets.all(6),
        child: Icon(
          homeController.isExpanded.value
              ? Icons.expand_less_rounded
              : Icons.expand_more,
          size: 16,
          color: homeController.isExpanded.value
              ? AppColors.selectionColor
              : AppColors.white,
        ),
      ),
    );
  }
}

/// Tab item widget for mobile/tab
class _TabItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const _TabItem({
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? AppColors.selectionColor : AppColors.white,
              ),
        ),
      ),
    );
  }
}

/// Tab item widget for desktop
class _TabItemDesktop extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const _TabItemDesktop({
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isSelected ? AppColors.selectionColor : AppColors.white,
              ),
        ),
      ),
    );
  }
}

/// Custom list tile widget
class _CustomListTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final IconData? icon;
  final VoidCallback? onTap;

  const _CustomListTile({
    this.title,
    this.subtitle,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileView: ListTile(
        dense: true,
        onTap: onTap,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Neumorphic(
            padding: const EdgeInsets.all(6),
            style: cardStyle(radius: 6),
            child: Icon(icon, color: AppColors.accent, size: 16),
          ),
        ),
        title: Text(
          title ?? "",
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.lightGray70,
              ),
        ),
        subtitle: Text(
          subtitle ?? "",
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
      desktopView: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
          leading: Neumorphic(
            padding: const EdgeInsets.all(12),
            style: cardStyle(radius: 12),
            child: Icon(icon, color: AppColors.accent, size: 18),
          ),
          title: Text(
            title ?? "",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.lightGray70,
                ),
          ),
          subtitle: Text(
            subtitle ?? "",
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.white,
                ),
          ),
        ),
      ),
    );
  }
}

