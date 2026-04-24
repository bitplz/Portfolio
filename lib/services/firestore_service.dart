import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:portfolio/models/portfolio_models.dart';

/// Service for handling all Firestore operations
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  static const String educationCollection = 'education';
  static const String experienceCollection = 'experience';
  static const String projectsCollection = 'projects';
  static const String personalDetailsCollection = 'personalDetails';
  static const String personalDetailsDoc = 'details'; // Document ID for personal details

  /// Get education history from Firestore
  Future<List<Education>> getEducation() async {
    try {
      final querySnapshot = await _firestore
          .collection(educationCollection)
          .orderBy('order', descending: false) // Optional: if you add order field
          .get();

      return querySnapshot.docs
          .map((doc) => Education.fromMap(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching education: $e');
      return [];
    }
  }

  /// Get experience history from Firestore
  Future<List<Experience>> getExperience() async {
    try {
      final querySnapshot = await _firestore
          .collection(experienceCollection)
          .orderBy('order', descending: false) // Optional: if you add order field
          .get();

      return querySnapshot.docs
          .map((doc) => Experience.fromMap(doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching experience: $e');
      return [];
    }
  }

  /// Get all projects from Firestore
  Future<List<Project>> getProjects() async {
    try {
      final querySnapshot = await _firestore
          .collection(projectsCollection)
          .orderBy('order', descending: false) // Optional: if you add order field
          .get();

      return querySnapshot.docs
          .map((doc) => Project.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      debugPrint('Error fetching projects: $e');
      return [];
    }
  }

  /// Get a single project by ID
  Future<Project?> getProjectById(String projectId) async {
    try {
      final docSnapshot = await _firestore
          .collection(projectsCollection)
          .doc(projectId)
          .get();

      if (docSnapshot.exists) {
        return Project.fromMap(docSnapshot.id, docSnapshot.data() ?? {});
      }
      return null;
    } catch (e) {
      debugPrint('Error fetching project by ID: $e');
      return null;
    }
  }

  /// Get personal details (email, mobile, address, about me)
  Future<PersonalDetails> getPersonalDetails() async {
    try {
      final docSnapshot = await _firestore
          .collection(personalDetailsCollection)
          .doc(personalDetailsDoc)
          .get();

      if (docSnapshot.exists) {
        return PersonalDetails.fromMap(docSnapshot.data() ?? {});
      }
      // Return empty details if document doesn't exist
      return PersonalDetails(
        email: '',
        mobile: '',
        address: '',
        aboutMe: '',
      );
    } catch (e) {
      debugPrint('Error fetching personal details: $e');
      return PersonalDetails(
        email: '',
        mobile: '',
        address: '',
        aboutMe: '',
      );
    }
  }

  /// Add or update a single education entry
  Future<bool> addEducation(Education education) async {
    try {
      await _firestore
          .collection(educationCollection)
          .add(education.toMap());
      return true;
    } catch (e) {
      debugPrint('Error adding education: $e');
      return false;
    }
  }

  /// Add or update a single experience entry
  Future<bool> addExperience(Experience experience) async {
    try {
      await _firestore
          .collection(experienceCollection)
          .add(experience.toMap());
      return true;
    } catch (e) {
      debugPrint('Error adding experience: $e');
      return false;
    }
  }

  /// Add a new project
  Future<bool> addProject(Project project) async {
    try {
      await _firestore
          .collection(projectsCollection)
          .add(project.toMap());
      return true;
    } catch (e) {
      debugPrint('Error adding project: $e');
      return false;
    }
  }

  /// Update personal details
  Future<bool> updatePersonalDetails(PersonalDetails details) async {
    try {
      await _firestore
          .collection(personalDetailsCollection)
          .doc(personalDetailsDoc)
          .set(details.toMap(), SetOptions(merge: true));
      return true;
    } catch (e) {
      debugPrint('Error updating personal details: $e');
      return false;
    }
  }

  /// Stream education data for real-time updates
  Stream<List<Education>> educationStream() {
    return _firestore
        .collection(educationCollection)
        .orderBy('order', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Education.fromMap(doc.data()))
          .toList();
    }).handleError((error) {
      debugPrint('Error in education stream: $error');
      return [];
    });
  }

  /// Stream experience data for real-time updates
  Stream<List<Experience>> experienceStream() {
    return _firestore
        .collection(experienceCollection)
        .orderBy('order', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Experience.fromMap(doc.data()))
          .toList();
    }).handleError((error) {
      debugPrint('Error in experience stream: $error');
      return [];
    });
  }

  /// Stream projects data for real-time updates
  Stream<List<Project>> projectsStream() {
    return _firestore
        .collection(projectsCollection)
        .orderBy('order', descending: false)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Project.fromMap(doc.id, doc.data()))
          .toList();
    }).handleError((error) {
      debugPrint('Error in projects stream: $error');
      return [];
    });
  }

  /// Stream personal details for real-time updates
  Stream<PersonalDetails> personalDetailsStream() {
    return _firestore
        .collection(personalDetailsCollection)
        .doc(personalDetailsDoc)
        .snapshots()
        .map((docSnapshot) {
      if (docSnapshot.exists) {
        return PersonalDetails.fromMap(docSnapshot.data() ?? {});
      }
      return PersonalDetails(
        email: '',
        mobile: '',
        address: '',
        aboutMe: '',
      );
    }).handleError((error) {
      debugPrint('Error in personal details stream: $error');
      return PersonalDetails(
        email: '',
        mobile: '',
        address: '',
        aboutMe: '',
      );
    });
  }
}

