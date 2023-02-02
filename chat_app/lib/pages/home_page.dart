import 'package:fire_base_denemeleri_1/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseAuth auth1;
  @override
  void initState() {
    super.initState();
    auth1 = FirebaseAuth.instance;
    auth1.authStateChanges().listen((User? user) {
      if (user != null) {
        debugPrint('kullanıcı oturum açtı');
      } else {
        debugPrint('kullanıcı oturum kapattı');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Home page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                  signOut();
                },
                child: const Text('text'))
          ],
        ),
      ),
    );
  }

  void signOut() async {
    GoogleSignIn().disconnect();
    auth1.signOut();
  }
}
