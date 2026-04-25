import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:portfolio/screens/homepage/about_view.dart';
import 'package:portfolio/screens/homepage/contact_view.dart';
import 'package:portfolio/screens/homepage/portfolio_view.dart';
import 'package:portfolio/screens/homepage/resume_view.dart';
import 'package:portfolio/utils/common_methods.dart';
import 'package:portfolio/utils/environment.dart';

class HomeController extends GetxController {
  // Observables
  final RxInt selectedTabIndex = 0.obs;
  final RxBool loading = false.obs;
  final RxBool isExpanded = false.obs;

  // Controllers
  late final ScrollController scrollController;
  late final Rx<TextEditingController> emailController;
  late final Rx<TextEditingController> nameController;
  late final Rx<TextEditingController> messageController;
  late final GlobalKey<FormState> formKey;

  // Instance
  static HomeController get instance => Get.find(tag: 'home_controller');

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
    _initializeEmailJS();
  }

  /// Initialize all text editing controllers
  void _initializeControllers() {
    scrollController = ScrollController();
    emailController = TextEditingController().obs;
    nameController = TextEditingController().obs;
    messageController = TextEditingController().obs;
    formKey = GlobalKey<FormState>();
  }

  /// Initialize EmailJS service with error handling
  void _initializeEmailJS() {
    try {
      emailjs.init(
        emailjs.Options(
          publicKey: Environment.publicKey,
          privateKey: Environment.privateKey,
          limitRate: const emailjs.LimitRate(
            id: 'web-app',
            throttle: 10000,
          ),
        )
      );
    } catch (e) {
      debugPrint('EmailJS initialization error: $e');
    }
  }

  /// Toggle expanded state for sidebar
  void toggleExpanded() => isExpanded.value = !isExpanded.value;

  /// Select tab by index
  void onSelectTab(int index) {
    selectedTabIndex.value = index;
  }

  /// Get the corresponding tab view
  Widget getTabView() {
    switch (selectedTabIndex.value) {
      case 0:
        return const AboutView();
      case 1:
        return const ResumeView();
      case 2:
        return const PortfolioView();
      case 3:
        return const ContactView();
      default:
        return const AboutView();
    }
  }

  /// Send email via EmailJS
  Future<bool> sendEmail() async {
    try {
      loading.value = true;

      await emailjs.send(
        Environment.serviceId,
        Environment.templateId,
        {
          'to_name': nameController.value.text.trim(),
          'user_email': emailController.value.text.trim(),
          'reply_to': "rchauhan439@gmail.com",
          'message': messageController.value.text.trim(),
        },
        emailjs.Options(
          publicKey: Environment.publicKey,
          privateKey: Environment.privateKey,
          limitRate: const emailjs.LimitRate(
            id: 'web-app',
            throttle: 10000,
          ),
        ),
      );

      CommonMethods().showSuccessToast("Message Sent!");
      _clearForm();
      return true;
    } catch (error) {
      CommonMethods().showDangerToast("Something went wrong!");
      debugPrint('Email sending error: $error');
      if (error is emailjs.EmailJSResponseStatus) {
        debugPrint('EmailJS Error: ${error.status}: ${error.text}');
      }
      return false;
    } finally {
      loading.value = false;
    }
  }

  /// Clear form fields
  void _clearForm() {
    nameController.value.clear();
    emailController.value.clear();
    messageController.value.clear();
  }

  @override
  void onClose() {
    scrollController.dispose();
    emailController.value.dispose();
    nameController.value.dispose();
    messageController.value.dispose();
    super.onClose();
  }

  String getTabName() {
    switch (selectedTabIndex.value) {
      case 0:
        return "About Me";
      case 1:
        return "Resume";
      case 2:
        return "Portfolio";
      case 3:
        return "Contact";
      default:
        return "About Me";
    }
  }
}