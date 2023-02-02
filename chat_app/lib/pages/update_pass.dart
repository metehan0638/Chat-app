// ignore_for_file: use_build_context_synchronously
import 'package:fire_base_denemeleri_1/constants/consts.dart';
import 'package:fire_base_denemeleri_1/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late FirebaseAuth auth;
  bool obsuredText = false;
  TextEditingController passUpdateController = TextEditingController();
  TextEditingController passUpdateVerifyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    super.dispose();
    passUpdateController;
    passUpdateVerifyController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Şifre Yenileme'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: decoration(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                _buildWelcomeContainer(),
                _buildTextField(passUpdateController, 'E-mail'),
                const SizedBox(
                  height: 35,
                ),
                _buildTextField(
                    passUpdateVerifyController, 'E-Mail\'i doğrulayınız'),
                const SizedBox(
                  height: 25,
                ),
                _buildButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async {
    await auth.sendPasswordResetEmail(email: passUpdateVerifyController.text);
  }

  Decoration decoration() {
    return BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Constants.arkaPlanRengi_1,
        Constants.arkaPlanRengi_2,
      ],
    ));
  }

  Widget _buildWelcomeContainer() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Image.asset(Constants.forgotPass,
          fit: BoxFit.fill, filterQuality: FilterQuality.high),
    );
  }

  Future _buildAlertDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: const Text('Onayla'))
          ],
          content: const Text(
              'Kayıt Olduğunuz E-mailinize Şifre Sıfırlama Linki Gönderilmiştir'),
          title: const Text('İşlem Başarıyla Gerçekleşti'),
        );
      },
    );
  }

  Widget _buildTextField(
      TextEditingController myController, String myHintText) {
    return TextField(
      showCursor: true,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.7),
          suffixIcon: myController.text.isEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      return;
                    });
                  },
                  icon: Container())
              : IconButton(
                  onPressed: () {
                    setState(() {
                      myController.clear();
                    });
                  },
                  icon: const Icon(Icons.clear)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          hintText: myHintText,
          prefixIcon: const Icon(
            Icons.mail,
            color: Colors.indigo,
            size: 30,
          )),
      controller: myController,
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
        onPressed: () {
          if (passUpdateController.text == passUpdateVerifyController.text &&
              passUpdateController.text.isNotEmpty &&
              passUpdateVerifyController.text.isNotEmpty) {
            resetPassword();
            _buildAlertDialog();
            passUpdateController.clear();
            passUpdateVerifyController.clear();
          } else {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  color: Colors.red,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Girilen E-mail Uyuşmamaktadır Lütfen Tekrar Deneyiniz',
                          style: Constants.myModalSheetStyle,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10))),
                          child: const Text('Kapat'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 52.0, vertical: 15),
          child: Text(
            'Yeni Şifre Oluştur',
            style: TextStyle(fontSize: 16),
          ),
        ));
  }
}
