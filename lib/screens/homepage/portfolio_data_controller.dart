import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:portfolio/models/portfolio_models.dart';
import 'package:portfolio/services/firestore_service.dart';

/// Controller for managing portfolio data from Firestore
class PortfolioDataController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  // Observables for portfolio data
  final Rx<List<Education>> educationList = Rx([]);
  final Rx<List<Experience>> experienceList = Rx([]);
  final Rx<List<Project>> projectList = Rx([]);
  final Rx<PersonalDetails> personalDetails = Rx(
    PersonalDetails(
      email: '',
      mobile: '',
      address: '',
      aboutMe: '',
    ),
  );

  // Loading states
  final RxBool educationLoading = false.obs;
  final RxBool experienceLoading = false.obs;
  final RxBool projectsLoading = false.obs;
  final RxBool personalDetailsLoading = false.obs;

  // Static getter for easy access
  static PortfolioDataController get instance =>
      Get.find(tag: 'portfolio_data_controller');

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  /// Initialize all portfolio data from Firestore
  void _initializeData() {
    fetchEducation();
    fetchExperience();
    fetchProjects();
    fetchPersonalDetails();
  }

  /// Fetch education data
  Future<void> fetchEducation() async {
    try {
      educationLoading.value = true;
      final data = await _firestoreService.getEducation();
      educationList.value = data;
    } catch (e) {
      debugPrint('Error fetching education: $e');
    } finally {
      educationLoading.value = false;
    }
  }

  /// Fetch experience data
  Future<void> fetchExperience() async {
    try {
      experienceLoading.value = true;
      final data = await _firestoreService.getExperience();
      experienceList.value = data;
    } catch (e) {
      debugPrint('Error fetching experience: $e');
    } finally {
      experienceLoading.value = false;
    }
  }

  /// Fetch projects data
  Future<void> fetchProjects() async {
    try {
      projectsLoading.value = true;
      final data = await _firestoreService.getProjects();
      projectList.value = data;
    } catch (e) {
      debugPrint('Error fetching projects: $e');
    } finally {
      projectsLoading.value = false;
    }
  }

  /// Fetch personal details
  Future<void> fetchPersonalDetails() async {
    try {
      personalDetailsLoading.value = true;
      final data = await _firestoreService.getPersonalDetails();
      personalDetails.value = data;
    } catch (e) {
      debugPrint('Error fetching personal details: $e');
    } finally {
      personalDetailsLoading.value = false;
    }
  }

  /// Get education data with fallback to empty state
  List<Education> getEducationData() {
    return educationList.value;
  }

  /// Get experience data with fallback to empty state
  List<Experience> getExperienceData() {
    return experienceList.value;
  }

  /// Get projects data with fallback to empty state
  List<Project> getProjectsData() {
    return projectList.value;
  }

  /// Get personal details with fallback
  PersonalDetails getPersonalDetailsData() {
    return personalDetails.value;
  }

  /// Refresh all data
  Future<void> refreshAll() async {
    await Future.wait([
      fetchEducation(),
      fetchExperience(),
      fetchProjects(),
      fetchPersonalDetails(),
    ]);
  }
}

