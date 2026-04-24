// Migration guide and utilities for seeding Firestore with existing portfolio data
// This file helps migrate data from common_strings.dart to Firestore

import 'package:portfolio/models/portfolio_models.dart';
import 'package:portfolio/utils/common_strings.dart';

/// Utility class for migrating legacy hardcoded data to Firestore
class FirestoreMigration {
  /// Get all education data from legacy CommonStrings for Firestore import
  static List<Map<String, dynamic>> getLegacyEducationData() {
    return (CommonStrings.educationMap as List)
        .asMap()
        .entries
        .map((entry) {
          final map = entry.value as Map;
          return {
            'title': map['title'],
            'time': map['time'],
            'desc': map['desc'],
            'order': entry.key, // Use index as order
          };
        })
        .toList();
  }

  /// Get all experience data from legacy CommonStrings for Firestore import
  static List<Map<String, dynamic>> getLegacyExperienceData() {
    return (CommonStrings.experienceMap as List)
        .asMap()
        .entries
        .map((entry) {
          final map = entry.value as Map;
          return {
            'title': map['title'],
            'time': map['time'],
            'desc': map['desc'],
            'order': entry.key, // Use index as order
          };
        })
        .toList();
  }

  /// Get all projects data from legacy CommonStrings for Firestore import
  static List<Map<String, dynamic>> getLegacyProjectsData() {
    final projects = [
      (CommonStrings.darknetDiariesApp, 0),
      (CommonStrings.libriVoxApp, 1),
      (CommonStrings.talentAnywhereApp, 2),
      (CommonStrings.workAnywhereApp, 3),
      (CommonStrings.portfolioApp, 4),
      (CommonStrings.neoMartApp, 5),
      (CommonStrings.remoteCursorPackage, 6),
    ];

    return projects
        .map((entry) {
          final map = entry.$1 as Map;
          return {
            'title': map['title'],
            'type': map['type'] ?? 'Mobile Application',
            'coverImage': map['coverImage'] ?? '',
            'iconUrl': map['iconUrl'] ?? '',
            'playstoreUrl': map['playstoreUrl'] ?? '',
            'about': map['about'] ?? '',
            'order': entry.$2,
          };
        })
        .toList();
  }

  /// Get personal details from legacy CommonStrings
  static Map<String, dynamic> getLegacyPersonalDetailsData() {
    final details = CommonStrings.myDetails as Map;
    return {
      'email': details['email'],
      'mobile': details['mobile'],
      'address': details['address'],
      'aboutMe': CommonStrings.aboutMe,
    };
  }

  /// Convert legacy data to model objects
  static List<Education> getEducationModels() {
    return getLegacyEducationData()
        .map((data) => Education.fromMap(data))
        .toList();
  }

  static List<Experience> getExperienceModels() {
    return getLegacyExperienceData()
        .map((data) => Experience.fromMap(data))
        .toList();
  }

  static List<Project> getProjectModels() {
    final projects = getLegacyProjectsData();
    return projects
        .asMap()
        .entries
        .map((entry) => Project.fromMap('project_${entry.key}', entry.value))
        .toList();
  }

  static PersonalDetails getPersonalDetailsModel() {
    return PersonalDetails.fromMap(getLegacyPersonalDetailsData());
  }
}

/// Helper method to migrate data to Firestore
/// USAGE: Call this once in main.dart or a setup screen to seed Firestore with initial data
/// Uncomment below in utilities.dart or a separate setup service to activate
/*
import 'package:portfolio/services/firestore_service.dart';

Future<void> seedFirestoreWithLegacyData() async {
  final firestoreService = FirestoreService();

  debugPrint('Starting Firestore data migration...');

  // Migrate education
  for (var education in FirestoreMigration.getEducationModels()) {
    await firestoreService.addEducation(education);
  }
  debugPrint('✅ Education data migrated');

  // Migrate experience
  for (var experience in FirestoreMigration.getExperienceModels()) {
    await firestoreService.addExperience(experience);
  }
  debugPrint('✅ Experience data migrated');

  // Migrate projects
  for (var project in FirestoreMigration.getProjectModels()) {
    await firestoreService.addProject(project);
  }
  debugPrint('✅ Projects data migrated');

  // Migrate personal details
  await firestoreService.updatePersonalDetails(
    FirestoreMigration.getPersonalDetailsModel(),
  );
  debugPrint('✅ Personal details migrated');

  debugPrint('✅ Firestore migration complete!');
}
*/

