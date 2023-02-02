/*import 'package:flutter/material.dart';

class FirebaseFunctions{
  static void _signUp() async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: _emailSignUpController.text,
          password: _passwordSignUpController.text);

      debugPrint(userCredential.toString());
    } catch (e) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Geri',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
            backgroundColor: Colors.white,
            title: const Center(
                child: Text(
              'Zaten böle bir kullanıcı mevcut.',
              style: TextStyle(color: Colors.green),
            )),
            content: const Icon(
              Icons.supervised_user_circle_rounded,
              color: Colors.green,
              size: 85,
            ),
          );
        },
      );
    }
  }
}*/