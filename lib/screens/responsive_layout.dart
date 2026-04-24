// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLayout extends StatelessWidget {
  Widget mobileView;
  Widget? tabView;
  Widget desktopView;

  ResponsiveLayout({
    required this.mobileView,
    this.tabView,
    required this.desktopView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return SelectionArea(child: mobileView);
        } else if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return SelectionArea(child: tabView ?? mobileView);
        }
        return SelectionArea(child: desktopView);
      },
    );
  }
}
