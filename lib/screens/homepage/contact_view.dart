import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:portfolio/controllers/controllers.dart';
import 'package:portfolio/screens/responsive_layout.dart';
import 'package:portfolio/utils/app_colors.dart';
import 'package:portfolio/utils/common_widgets.dart';
import 'package:portfolio/controllers/home_controller.dart';
import 'package:portfolio/controllers/portfolio_data_controller.dart';
import 'package:get/get.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>(tag: 'home_controller');

    return ResponsiveLayout(
      mobileView: _buildMobileLayout(context, homeController),
      desktopView: _buildDesktopLayout(context, homeController),
    );
  }

  Widget _buildMobileLayout(BuildContext context, HomeController controller) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ContactMap(),
            const SizedBox(height: 40),
            _ContactFormSection(controller: controller, isMobile: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, HomeController controller) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ContactMap(),
          const SizedBox(height: 40),
          _ContactFormSection(controller: controller, isMobile: false),
        ],
      ),
    );
  }
}

/// Map widget for contact view
class _ContactMap extends StatelessWidget {
  const _ContactMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.infinity,
      height: 400,
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(28.4959, 77.1848),
          initialZoom: 13,
          interactionOptions: InteractionOptions(
            flags: InteractiveFlag.doubleTapZoom,
          ),
          maxZoom: 15,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
        ],
      ),
    );
  }
}

/// Contact form section widget
class _ContactFormSection extends StatelessWidget {
  final HomeController controller;
  final bool isMobile;

  const _ContactFormSection({
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Contact Form",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        Obx(() {
          final details = portfolioDataController.personalDetails.value;
          if (details.email.isEmpty && details.mobile.isEmpty) {
            return const SizedBox.shrink();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email: ${details.email}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text('Phone: ${details.mobile}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
            ],
          );
        }),
        _ContactForm(controller: controller, isMobile: isMobile),
      ],
    );
  }
}

/// Contact form widget
class _ContactForm extends StatelessWidget {
  final HomeController controller;
  final bool isMobile;

  const _ContactForm({
    required this.controller,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isMobile)
            _buildMobileFormFields(context, controller)
          else
            _buildDesktopFormFields(context, controller),
          const SizedBox(height: 20),
          _buildSubmitButton(context, controller),
        ],
      ),
    );
  }

  Widget _buildMobileFormFields(BuildContext context, HomeController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ContactTextField(
          controller: controller.nameController.value,
          hintText: "Full Name",
          validator: (text) =>
              (text == null || text.isEmpty) ? "Enter full name!" : null,
        ),
        const SizedBox(height: 10),
        _ContactTextField(
          controller: controller.emailController.value,
          hintText: "Email address",
          validator: (text) =>
              (text == null || !GetUtils.isEmail(text))
                  ? "Enter valid email address!"
                  : null,
        ),
        const SizedBox(height: 10),
        _ContactTextField(
          controller: controller.messageController.value,
          hintText: "Your Message",
          minLines: 6,
          maxLines: null,
          minHeight: 140,
          validator: (_) => null,
        ),
      ],
    );
  }

  Widget _buildDesktopFormFields(BuildContext context, HomeController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: _ContactTextField(
                controller: controller.nameController.value,
                hintText: "Full Name",
                validator: (text) =>
                    (text == null || text.isEmpty) ? "Enter full name!" : null,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _ContactTextField(
                controller: controller.emailController.value,
                hintText: "Email address",
                validator: (text) =>
                    (text == null || !GetUtils.isEmail(text))
                        ? "Enter valid email address!"
                        : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _ContactTextField(
          controller: controller.messageController.value,
          hintText: "Your Message",
          minLines: 6,
          maxLines: null,
          minHeight: 140,
          validator: (_) => null,
        ),
      ],
    );
  }

  Widget _buildSubmitButton(BuildContext context, HomeController controller) {
    return Obx(
      () => Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: controller.loading.value
              ? null
              : () async {
                  if (controller.formKey.currentState!.validate()) {
                    await controller.sendEmail();
                  }
                },
          child: _SubmitButton(
            isLoading: controller.loading.value,
            buttonText: controller.loading.value ? "Sending..." : "Send Message",
          ),
        ),
      ),
    );
  }
}

/// Contact text field widget
class _ContactTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int minLines;
  final int? maxLines;
  final double minHeight;

  const _ContactTextField({
    required this.controller,
    required this.hintText,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.minHeight = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: _buildInputDecoration(context),
      ),
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
    );

    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: border,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.lightGray70,
          ),
      errorStyle: const TextStyle(color: Colors.redAccent),
    );
  }
}

/// Submit button widget
class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final String buttonText;

  const _SubmitButton({
    required this.isLoading,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: cardStyle(radius: 14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/svg/send.svg',
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.selectionColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              buttonText,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: AppColors.selectionColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}