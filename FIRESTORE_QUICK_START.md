# Firestore Quick Start Guide

## Quick Setup (5 minutes)

### Step 1: Create Firestore Collections in Firebase Console
Go to: `firebase.google.com` → Project `portfolio-d4714` → Firestore Database

Create these collections (auto-ID documents):
- `education`
- `experience`
- `projects`
- `personalDetails` (one document with ID: `details`)

### Step 2: Seed Data (Choose One Option)

**Option A: Manual Entry (Firebase Console)**
- Add documents matching the structure below

**Option B: Automatic Migration (Code)**
```dart
import 'package:portfolio/utils/firestore_migration.dart';

// Call this once to migrate all data from common_strings.dart
await seedFirestoreWithLegacyData();
```

## Document Structures

### `education` Collection
```json
{
  "title": "Maharshi Dayanand University, Rohtak",
  "time": "2015 - 2019",
  "desc": "Graduated with a B.Tech in Computer Science...",
  "order": 2
}
```

### `experience` Collection
```json
{
  "title": "AWC Software, Gurugram",
  "time": "July 2025 - Present",
  "desc": "Building a cross-platform mobile and web app...",
  "order": 0
}
```

### `projects` Collection
```json
{
  "title": "Darknet Diaries - Podcast",
  "type": "Mobile Application",
  "coverImage": "assets/images/darknet-diaries.png",
  "iconUrl": "assets/images/dd-app-icon.png",
  "playstoreUrl": "https://play.google.com/store/apps/...",
  "about": "Darknet Diaries is a Flutter-based media player...",
  "order": 0
}
```

### `personalDetails/details` Document
```json
{
  "email": "rchauhan439@gmail.com",
  "mobile": "+91 8810529272",
  "address": "New Delhi - 110074",
  "aboutMe": "I'm a Flutter Developer with 5 years of experience..."
}
```

## Use in Views

### Simple Access
```dart
final controller = PortfolioDataController.instance;
List<Education> education = controller.getEducationData();
```

### Reactive (Auto-Updates)
```dart
Obx(() {
  return ListView(
    children: PortfolioDataController.instance.educationList.value
        .map((e) => ListTile(title: Text(e.title)))
        .toList()
  );
})
```

### Real-Time Stream
```dart
StreamBuilder<List<Education>>(
  stream: FirestoreService().educationStream(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) return CircularProgressIndicator();
    return ListView(
      children: snapshot.data!.map((e) => Text(e.title)).toList()
    );
  }
)
```

## Common Tasks

| Task | Code |
|------|------|
| Get Education | `PortfolioDataController.instance.getEducationData()` |
| Get Experience | `PortfolioDataController.instance.getExperienceData()` |
| Get Projects | `PortfolioDataController.instance.getProjectsData()` |
| Get Personal Details | `PortfolioDataController.instance.getPersonalDetailsData()` |
| Refresh All Data | `await PortfolioDataController.instance.refreshAll()` |
| Watch for Changes | Use `Obx(() => ...)` wrapper |

## File Reference

| File | Purpose |
|------|---------|
| `lib/models/portfolio_models.dart` | Data type definitions |
| `lib/services/firestore_service.dart` | Firestore operations |
| `lib/screens/homepage/portfolio_data_controller.dart` | State management |
| `lib/utils/firestore_migration.dart` | Data migration utility |

## Firebase Console URLs

- **Firestore Database**: https://console.firebase.google.com/project/portfolio-d4714/firestore
- **Security Rules**: https://console.firebase.google.com/project/portfolio-d4714/firestore/rules

## Firestore Security Rules (Read-Only)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read: if true;
      allow write: if request.auth != null; // Restrict writes if needed
    }
  }
}
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| No data loading | Check web config in `firebase_options.dart` matches Console project |
| Permission denied | Update Firestore Security Rules to allow read |
| Data not ordered | Add `order` field to all documents |
| Type errors | Verify field names match document structure exactly |

## Next: Enable Real-Time Updates

Replace `get*()` calls with `*Stream()` for automatic UI updates:

```dart
// Before (static data)
final education = await FirestoreService().getEducation();

// After (real-time)
final educationStream = FirestoreService().educationStream();
```

Then use with `StreamBuilder` to automatically rebuild when data changes! 🎉

