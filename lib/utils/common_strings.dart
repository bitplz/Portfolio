
class CommonStrings {
  static const myDetails = {
    "email": "rchauhan439@gmail.com",
    "mobile": "+91 8810529272",
    "address": "New Delhi - 110074",
  };
  static const String aboutMe = "I'm a Flutter Developer with 5 years of experience in building mobile and web applications using Flutter and React. I specialize in crafting intuitive, user-centric designs that deliver high performance and align with business goals. Skilled in Flutter, Dart, and React, I'm well-versed in state management solutions, including GetX and Provider for Flutter, as well as Redux and Context for React. My technical expertise extends to Firebase integration, API implementation, and responsive design principles that ensure applications are both functional and visually appealing.\n\nWith a commitment to clean, scalable code and industry best practices, my work has consistently delivered measurable results including reduced load times, increased user engagement, and positive app store ratings. I thrive in collaborative environments, working seamlessly with cross-functional teams to translate design visions into technical realities. My approach balances technical excellence with business priorities, ensuring projects meet both user needs and organizational objectives. I'm passionate about creating digital experiences that make a difference and am ready to bring my frontend expertise to your next project.";
  static const educationMap = [

    {
      'title': 'Kendriya Vidyalaya JNU',
      'time': '2011 - 2013',
      'desc': 'Completed 10th grade with a solid academic record, excelling in Mathematics and Science.'
    },
    {
      'title': 'Kendriya Vidyalaya JNU',
      'time': '2013 - 2015',
      'desc': 'Completed 12th grade with a focus on Science stream, building a strong foundation in Mathematics, Physics, and Computer Science.'
    },
    {
      'title': 'Maharshi Dayanand University, Rohtak',
      'time': '2015 - 2019',
      'desc': 'Graduated with a B.Tech in Computer Science, specializing in software development and web technologies.'
    }
  ];

  static const experienceMap = [
    {
      'title': 'AWC Software, Gurugram',
      'time': 'July 2025 - Present',
      'desc':
      'Building a cross-platform mobile and web app from scratch using a single shared codebase. '
          'Implemented role-based access control, multi-theme support, and localisation '
          'for multiple regional markets.'
    },
    {
      'title': 'Shephertz Technologies, Gurugram',
      'time': 'April 2023 - March 2025',
      'desc':
      'Built an HRMS app with live GPS tracking, face recognition login, and Firebase integration, '
          'reducing redundant code by 15%. Developed an AI-powered job portal with push notifications, '
          'deep linking, and Google Sign-In using GetX state management.'
    },
    {
      'title': 'The Phantom Codes Pvt. Ltd., Gurugram',
      'time': 'January 2020 - March 2023',
      'desc':
      'Delivered 8+ Android and iOS apps across fintech, media, and lifestyle categories. '
          'Integrated Stripe, Razorpay, and Paytm payment gateways, and built real-time chat '
          'with offline support using WebSockets and Firebase Realtime Database.'
    },
  ];

  static const Map<String, String> darknetDiariesApp = {
    'playstoreUrl' : "https://play.google.com/store/apps/details?id=com.bug32.darknetdiaries&hl=en_IN",
    'coverImage': "assets/images/darknet-diaries.png",
    'title': "Darknet Diaries - Podcast",
    'iconUrl': "assets/images/dd-app-icon.png",
    'about': '''
Darknet Diaries is a Flutter-based media player application developed from scratch, designed to provide users with a seamless experience for streaming and managing podcasts. The app leverages several key technologies and services:

-  Firebase Integration: Utilizes Firebase for capturing user interactions, such as marking favorite podcasts. Firebase Authentication is implemented for secure Google Sign-In functionality.

-  Offline Storage: Features robust offline capabilities, allowing users to download podcasts and access them without an internet connection.

-  Audio Streaming: Incorporates advanced audio player libraries to facilitate smooth and high-quality streaming of online podcasts.

This modernized approach ensures a user-friendly interface, reliable offline access, and enhanced personalization features.
  ''',
    'type': "Mobile Application"
  };

  static const Map<String, String> libriVoxApp = {
    'playstoreUrl' : "https://play.google.com/store/apps/details?id=com.bug32.librivoxapi&hl=en_IN",
    'coverImage': "assets/images/librivox.png",
    'title': "LibriVox - Free Audiobooks",
    'iconUrl': "assets/images/librivox-app-icon.png",
    'about': '''
LibriVox is a Android Java-based media player application designed to provide users with free audiobooks available in the public domain. The app is built with a focus on delivering a rich and immersive reading and listening experience.

-  REST API Integration: The app fetches audiobook data through REST APIs that provide access to public domain content.

-  HTML Rendering: The entire text of the book being played is rendered on the screen, allowing users to read along with the audio.

This application combines audio playback with an interactive reading experience, offering users a convenient way to enjoy classic literature.
  ''',
    'type': "Mobile Application"
  };

  static const Map<String, String> talentAnywhereApp = {
    'playstoreUrl' : "",
    'coverImage': 'assets/images/project-cover.png',
    'title': "Talent Anywhere",
    'iconUrl': "",
    'type': "Mobile Application",
    'about': '''
Talent Anywhere is a dynamic job portal built using Flutter, designed to streamline the interaction between candidates and enterprises. It incorporates advanced AI technologies and several key features:

-  AI-Driven Resume Parsing: Leverages AI for optimizing search results, making job matching more efficient.
-  Firebase Notifications: Integrates Firebase to provide real-time notifications for job postings and candidate updates.
-  Deep Linking & Google Sign-In: Enables smooth user experiences with deep linking for easy navigation and Google Sign-In for secure authentication.
-  State Management: Follows MVVM architecture, making use of GetX for efficient state management.

This app modernizes job search processes, making it easier for candidates to find opportunities and for enterprises to connect with top talent.
'''
  };

  static const Map<String, String> workAnywhereApp = {
    'playstoreUrl' : "",
    'coverImage': 'assets/images/project-cover.png',
    'title': "Work Anywhere",
    'iconUrl': "",
    'type': "Mobile Application",
    'about': '''
Work Anywhere is a comprehensive HRMS (Human Resource Management System) application developed using Flutter. It is designed to enhance remote work efficiency by providing a range of features for attendance tracking, work progress monitoring, and project management. Key features include:

-  Real-time Location Fetching: Tracks employee location for accurate attendance marking.
-  Face Recognition: Secure authentication using Google ML Kit & Microsoft Cognitive Services.
-  Voice Recording: Enables users to record and share voice notes related to their tasks or meetings.
-  Meeting Scheduling & Calendar Integration: Allows users to schedule meetings and manage events within the app.
-  Activity Capture: Provides real-time tracking of tasks and activities through the mobile application.
-  User Management: Supports multiple roles such as Admin, Manager, and Member to facilitate proper access control.

This app is designed to support seamless remote working and efficient project management, empowering organizations to maintain productivity and communication.
'''
  };

  static const Map<String, String> portfolioApp = {
    'playstoreUrl': "",
    'coverImage': "assets/images/portfolio-cover.png",
    'title': "Personal Portfolio",
    'iconUrl': "assets/images/profile.png",
    'type': "Web Application",
    'about': '''
Indeed, the very portfolio you are browsing is a testament to my skills and expertise, meticulously crafted using the Flutter framework. This web application is designed to showcase my skills, projects, and professional journey. Developed from scratch, the portfolio incorporates modern technologies and best practices to create an engaging and responsive user experience. Key features include:

-  Responsive Design: Utilizes Responsive Builder to ensure the portfolio looks great on any device, whether it's a desktop, tablet, or mobile phone.

-  State Management: Powered by GetX for efficient state management, ensuring a smooth user experience across the application.

-  Interactive Maps: Integrated with flutter_map to display interactive maps, showcasing various project locations or any geographic-based data.

-  Contact Form: Implemented using EmailJS for seamless and efficient handling of contact form submissions, enabling users to reach out directly through the site.

-  Smooth Animations: Includes sleek transitions and animations to enhance user engagement and create a polished interface.

This portfolio serves as a personal brand statement, highlighting my expertise in Flutter development and my commitment to delivering high-quality applications.

Technologies: Built using Flutter, with GetX for state management, flutter_map for map integration, EmailJS for the contact form, and Responsive Builder for dynamic UI adaptation.
'''
  };

  static const Map<String, String> neoMartApp = {
    'playstoreUrl': "https://apps.apple.com/in/app/neomart/id1519575784",
    'coverImage': "assets/images/project-cover.png",
    'title': "NeoMart Consumer App",
    'iconUrl': "",
    'type': "Mobile Application",
    'about': '''
NeoMart Consumer App is a cutting-edge eCommerce platform designed to connect users with their favorite local markets and stores. This innovative app simplifies shopping for groceries, vegetables, fruits, medicines, and more—all from the comfort of home. Key features include:

-  **Comprehensive Shopping**: Offers a wide selection of products, allowing users to choose from various local stores and markets in one seamless app.

-  **Real-Time Communication**: Enables users to chat and call local shopkeepers, providing personalized support and enhancing the shopping experience.

-  **Push Notifications**: Integrated push notifications keep users informed about order updates, special offers, and new arrivals, ensuring they never miss out.

-  **Real-Time Delivery Tracking**: Users can monitor their order status in real time, providing transparency and improving customer satisfaction.

-  **Secure Payment Integration**: Supports multiple payment gateways, allowing users to complete transactions securely and efficiently.

-  **User-Friendly Interface**: Designed for ease of use, the app delivers a smooth and intuitive shopping experience for users of all backgrounds.

-  **Chat Support**: Built-in chat support feature helps users with any queries or issues, ensuring timely assistance.

Technologies: Developed using Flutter for cross-platform functionality, integrated with Firebase for push notifications and chat support, and real-time database features to ensure smooth order tracking and communication. This app is designed to provide a reliable and engaging eCommerce experience.
'''
  };

  static const Map<String, String> remoteCursorPackage = {
    'playstoreUrl': 'https://pub.dev/packages/remote_cursor',
    'coverImage': 'https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Ffh6eax88thjcndx9jvly.png',
    'title': 'Remote Cursor Package',
    'iconUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8ccrKgnGQ14EhsAmrL0dTt3Kkj5jx_Ilb77llYmgkqrsFokSSrt3GcxJy9iiY278ugzc&usqp=CAU',
    'type': 'Flutter Package',
    'about': '''
RemoteCursor is a powerful Flutter package that transforms your mobile device into a wireless mouse or trackpad controller. It enables precise control of your computer cursor using touch gestures or device gyroscope movements via WebSocket communication.

**Key Features:**

- **Dual Control Methods**: Use your device as a touchpad or motion-controlled pointer.
- **Precise Tracking**: Advanced algorithms ensure smooth cursor movement.
- **Customizable Sensitivity**: Fine-tune controls to match your preferences.
- **WebSocket Communication**: Establishes a low-latency connection to your computer.
- **Gesture Support**: Supports click, right-click, and double-click actions.
- **Configuration Options**: Extensive parameters to customize behavior.

**Technologies Used:**

- **Flutter**: For cross-platform mobile application development.
- **WebSocket**: Facilitates real-time communication between the mobile device and desktop.
- **Gyroscope & Touch Input**: Leverages device sensors for intuitive control.

Explore the package on pub.dev: https://pub.dev/packages/remote_cursor
'''
  };

}