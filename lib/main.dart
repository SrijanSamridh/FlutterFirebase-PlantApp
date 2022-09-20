import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_house/UI/Screens/MyFiles/my_files.dart';

import 'UI/Screens/CameraPage/cam_page.dart';
import 'UI/Screens/Favourite/favourite.dart';
import 'UI/Screens/Home/home_page.dart';
import 'UI/Screens/Login/login_page.dart';
import 'UI/Screens/Profile/profile.dart';
import 'UI/Screens/Scan/scan.dart';
import 'UI/Screens/details/details_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plant House',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: _buildWidget(),
        ),
      ),
      routes: {
        "/home": (context) => _buildWidget(),
        "/scan": (context) => const Scan(),
        "/login": (context) => LoginPage(press: signIn),
        "/details": (context) => const DetailsScreen(),
        "/my_files": (context) => MyFiles(),
        "/favourite": (context) => const Favourite(),
        "/profile": (context) => const Profile(),
        "/cam_page": (context) => const CamPage(),
      },
    );
  }

  Widget _buildWidget() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return HomePage(
        profilePicture: GoogleUserCircleAvatar(identity: user),
        name: user.displayName!,
        email: user.email,
        press: signOut,
      );
    } else {
      return LoginPage(press: signIn);
    }
  }

  void signOut() {
    _googleSignIn.disconnect();
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print("Error Signing In $e");
    }
  }
}

