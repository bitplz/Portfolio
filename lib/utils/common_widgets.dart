
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/controllers.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timeline_tile/timeline_tile.dart' as tt;
import 'package:url_launcher/url_launcher.dart';

import 'app_colors.dart';

NeumorphicStyle cardStyle({double? radius}) {
  return NeumorphicStyle(
      shape: NeumorphicShape.concave,
      disableDepth: false,
      boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(radius ?? 14)),
      depth: .8,
      oppositeShadowLightSource: false,
      intensity: .25,
      surfaceIntensity: .01,
      shadowDarkColor: AppColors.lightBlackContainer,
      lightSource: LightSource.topLeft,
      color: AppColors.lightBlackContainer,
      shadowLightColor: AppColors.white
  );
}

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? border;
  final Color? borderColor, bgColor;
  final BorderRadius? borderRadius;
  final Clip? clip;

  const CustomContainer({
    Key? key,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.border,
    this.borderColor,
    this.bgColor,
    this.borderRadius,
    this.clip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      clipBehavior: clip ?? Clip.none,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16.0),  // Default padding if none is provided
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor ?? AppColors.bgContainer,  // Background color
        borderRadius: borderRadius ?? BorderRadius.circular(border ?? 20),  // Border radius
        border: Border.all(  // Border with 1px solid
          color: borderColor ?? AppColors.borderColor,
          width: 1.0,
        ),
      ),
      child: child,  // The content inside the container
    );
  }
}

class AvatarContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? radius;
  final Gradient? gradient;
  final BorderRadiusGeometry? borderRadius;
  final Clip? clip;

  const AvatarContainer({
    Key? key,
    this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.radius,
    this.gradient,
    this.borderRadius,
    this.clip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: clip ?? Clip.none,
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16.0),  // Default padding if none is provided
      margin: margin,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            offset: Offset(-4, 8), // Horizontal and vertical offset
            blurRadius: 24, // Blur radius
            color: Color.fromRGBO(0, 0, 0, 0.25), // Semi-transparent black color
          ),
        ],
        gradient: gradient ?? AppColors.linearGradient,// k color
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 30),  // Border radius
        border: Border.all(  // Border with 1px solid
          color: AppColors.borderColor,
          width: 1.0,
        ),
      ),
      child: Center(child: child),  // The content inside the container
    );
  }
}

class TimeLineListView extends StatelessWidget {
  List<Map<String, String>> data;
  String? title;
  TimeLineListView({
    required this.data,
    required this.title,
    super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if(index == 0) {
          return TimelineTile(
            afterLineStyle: const LineStyle(
                color: AppColors.borderColor,
                thickness: 1.3
            ),
            beforeLineStyle: const LineStyle(
                color: AppColors.borderColor,
                thickness: 1.3
            ),
            alignment: TimelineAlign.start,
            isFirst: true,
            indicatorStyle: tt.IndicatorStyle(
                drawGap: false,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                height: 0,
                width: 0,
                indicatorXY: 0,
            ),
            endChild: const SizedBox(height: 40,),
          );
        }
        return ResponsiveLayout(
          mobileView: TimelineTile(
              afterLineStyle: const LineStyle(
                  color: AppColors.borderColor,
                  thickness: 1.3
              ),
              beforeLineStyle: const LineStyle(
                  color: AppColors.borderColor,
                  thickness: 1.3
              ),
              alignment: TimelineAlign.start,
              isLast: index == data.length,
              indicatorStyle: tt.IndicatorStyle(
                  drawGap: false,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 14,
                  width: 14,
                  indicatorXY: 0,
                  color: Colors.purple,
                  indicator: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.selectionColor,
                        border: Border.all(
                            color: AppColors.borderColor,
                            width: 3.3
                        )
                    ),
                  )
              ),
              endChild: Container(
                padding: const EdgeInsets.only(left: 20, right: 10, bottom: 30, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index - 1]['title']!, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.white,
                    ),),
                    const SizedBox(height: 8,),
                    Text(data[index - 1]['time']!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.selectionColor
                    ),),
                    Text(data[index - 1]['desc']!, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              )
          ),
          desktopView: TimelineTile(
              afterLineStyle: const LineStyle(
                  color: AppColors.borderColor,
                  thickness: 1.3
              ),
              beforeLineStyle: const LineStyle(
                  color: AppColors.borderColor,
                  thickness: 1.3
              ),
              alignment: TimelineAlign.start,
              isLast: index == data.length,
              indicatorStyle: tt.IndicatorStyle(
                  drawGap: false,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  height: 14,
                  width: 14,
                  indicatorXY: 0,
                  color: Colors.purple,
                  indicator: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.selectionColor,
                        border: Border.all(
                            color: AppColors.borderColor,
                            width: 3.3
                        )
                    ),
                  )
              ),
              endChild: Container(
                padding: const EdgeInsets.only(left: 20, right: 30, bottom: 30, top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index - 1]['title']!, style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.white,
                    ),),
                    const SizedBox(height: 8,),
                    Text(data[index - 1]['time']!, style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.selectionColor
                    ),),
                    Text(data[index - 1]['desc']!, style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              )
          )
        );
      },
      itemCount: data.length + 1,
    );
  }
}

class TabItem extends StatelessWidget {
  void Function() onTap;
  String title;
  bool isSelected;
  EdgeInsets? padding;
  TabItem({required this.onTap, required this.title, this.padding, this.isSelected = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(title, style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
              color: isSelected? AppColors.selectionColor: AppColors.white
          ),),
        ),
      ),
    );
  }
}

Widget downloadCVButton() {
  return InkWell(
    onTap: () async {
      // analyticServices.logEvent(eventName: "CV downloaded");
      launchUrl(
          Uri.parse("https://drive.google.com/file/d/1wLE1ViAMXpBkOz5kDCPRkXci-Ejiwzf6/view"), // CV pdf link
          mode: LaunchMode.platformDefault
      );
    },
    child: Neumorphic(
      style: NeumorphicStyle(
          shape: NeumorphicShape.concave,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: .4,
          lightSource: LightSource.topLeft,
          color: AppColors.lightBlackContainer,
          shadowLightColor: AppColors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.download, size: 18, color: AppColors.selectionColor,),
            const SizedBox(width: 8,),
            Text("Download CV", style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                color: AppColors.white
            ),)
          ],
        ),
      ),
    ),
  );
}
