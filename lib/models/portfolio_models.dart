// Data models for portfolio content
class Education {
  final String title;
  final String time;
  final String desc;

  Education({
    required this.title,
    required this.time,
    required this.desc,
  });

  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      title: map['title'] as String,
      time: map['time'] as String,
      desc: map['desc'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': time,
      'desc': desc,
    };
  }
}

class Experience {
  final String title;
  final String time;
  final String desc;

  Experience({
    required this.title,
    required this.time,
    required this.desc,
  });

  factory Experience.fromMap(Map<String, dynamic> map) {
    return Experience(
      title: map['title'] as String,
      time: map['time'] as String,
      desc: map['desc'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'time': time,
      'desc': desc,
    };
  }
}

class Project {
  final String id; // Document ID from Firestore
  final String title;
  final String type;
  final String coverImage;
  final String iconUrl;
  final String playstoreUrl;
  final String about;

  Project({
    required this.id,
    required this.title,
    required this.type,
    required this.coverImage,
    required this.iconUrl,
    required this.playstoreUrl,
    required this.about,
  });

  factory Project.fromMap(String id, Map<String, dynamic> map) {
    return Project(
      id: id,
      title: map['title'] as String? ?? '',
      type: map['type'] as String? ?? '',
      coverImage: map['coverImage'] as String? ?? '',
      iconUrl: map['iconUrl'] as String? ?? '',
      playstoreUrl: map['playstoreUrl'] as String? ?? '',
      about: map['about'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'type': type,
      'coverImage': coverImage,
      'iconUrl': iconUrl,
      'playstoreUrl': playstoreUrl,
      'about': about,
    };
  }
}

class PersonalDetails {
  final String email;
  final String mobile;
  final String address;
  final String aboutMe;

  PersonalDetails({
    required this.email,
    required this.mobile,
    required this.address,
    required this.aboutMe,
  });

  factory PersonalDetails.fromMap(Map<String, dynamic> map) {
    return PersonalDetails(
      email: map['email'] as String? ?? '',
      mobile: map['mobile'] as String? ?? '',
      address: map['address'] as String? ?? '',
      aboutMe: map['aboutMe'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'mobile': mobile,
      'address': address,
      'aboutMe': aboutMe,
    };
  }
}

