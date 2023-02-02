// ignore_for_file: use_build_context_synchronously
import 'package:fire_base_denemeleri_1/constants/consts.dart';
import 'package:fire_base_denemeleri_1/pages/home_page.dart';
import 'package:fire_base_denemeleri_1/pages/update_pass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int groupValue = 0;
  bool obsuredText = false;
  late FirebaseAuth auth;

  final TextEditingController _passwordSignUpVerifiedController =
      TextEditingController();
  final TextEditingController _emailSignUpController = TextEditingController();
  final TextEditingController _emailSignInController = TextEditingController();
  final TextEditingController _passwordSignUpController =
      TextEditingController();

  final TextEditingController _passwordSignInController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
  }

  @override
  void dispose() {
    super.dispose();
    _emailSignUpController;
    _emailSignInController;
    _passwordSignUpController;
    _passwordSignInController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: backgroundDecoration(),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  _myAppBar(),
                  _myWelcomeContainer(),
                  _buildSwitchButtons(),
                  const SizedBox(
                    height: 32,
                  ),
                  _buildIndexStack(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    try {
      var userCredential = await auth.createUserWithEmailAndPassword(
          email: _emailSignUpController.text,
          password: _passwordSignUpController.text);
      var myUser = userCredential.user;
      
      if (!myUser!.emailVerified) {
        await myUser.sendEmailVerification();
      } else {
        debugPrint('Kullanıcı doğrulanmış');
      }

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    _emailSignUpController.clear();
                    _passwordSignUpController.clear();
                    _passwordSignUpVerifiedController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Tamam',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
            backgroundColor: Colors.white,
            title: const Center(
                child: Text(
              'Başarıyla Kayıt Oldunuz !',
              style: TextStyle(color: Colors.green),
            )),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 85,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Lütfen E-mailinizi Doğrulayınız !',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      );
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

  void _signIn() async {
    try {
      var userCredential = await auth.signInWithEmailAndPassword(
          email: _emailSignInController.text,
          password: _passwordSignInController.text);
      debugPrint(userCredential.toString());
      var myUser = userCredential.user;
      _verifiedUserRotate(myUser);
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
              'E-mail veya Şifre yanlış',
              style: TextStyle(color: Colors.red),
            )),
            content: const Icon(
              Icons.lock,
              color: Colors.red,
              size: 85,
            ),
          );
        },
      );
    }
  }

  Widget _myWelcomeContainer() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Center(
            child: Text(
          'Mesajlaşma Uygulamasına Hoş Geldiniz',
          style: Constants.myWelcomeStyle,
        )),
      ),
    );
  }

  Widget _myAppBar() {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: 55,
        child: Center(
          child: Text(
            'L  O  G  I  N',
            style: Constants.myAppBarStyle,
          ),
        ),
      ),
    );
  }

  Widget _myEmailTextField(TextEditingController mailController) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.black,
        controller: mailController,
        onChanged: (user) {
          setState(() {});
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.8),
            suffixIcon: mailController.text.isEmpty
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
                        mailController.clear();
                      });
                    },
                    icon: const Icon(Icons.clear)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
            hintText: 'E-mail',
            prefixIcon: const Icon(
              Icons.mail,
              color: Colors.indigo,
              size: 30,
            )),
      ),
    );
  }

  Widget _myPasswordTextField(
      TextEditingController passwordController, String myHintText) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        enableInteractiveSelection: false,
        autofocus: false,
        showCursor: true,
        obscuringCharacter: '*',
        obscureText: obsuredText,
        controller: passwordController,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.withOpacity(0.8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
            suffixIcon: obsuredText == false
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        obsuredText = true;
                      });
                    },
                    icon: const Icon(
                      Icons.visibility,
                      color: Colors.black,
                    ))
                : IconButton(
                    onPressed: () {
                      setState(() {
                        obsuredText = false;
                      });
                    },
                    icon:
                        const Icon(Icons.visibility_off, color: Colors.black)),
            hintText: myHintText,
            prefixIcon: const Icon(
              Icons.password,
              color: Colors.indigo,
              size: 30,
            )),
      ),
    );
  }

  _buildSwitchButtons() {
    return Center(
      child: CupertinoPageScaffold(
        backgroundColor: Colors.transparent,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: CupertinoSlidingSegmentedControl(
            backgroundColor: Colors.blueGrey.shade300,
            groupValue: groupValue,
            children: {
              0: _buildText('Giriş Yap'),
              1: _buildText('Kayıt Ol'),
            },
            onValueChanged: (groupValue) {
              setState(() {
                if (groupValue == 0) {
                  _emailSignUpController.clear();
                  _passwordSignUpController.clear();
                  _passwordSignUpVerifiedController.clear();
                } else {
                  _emailSignInController.clear();
                  _passwordSignInController.clear();
                }
                this.groupValue = groupValue!;
              });
            },
          ),
        ),
      ),
    );
  }

  _buildText(String buttonName) {
    return Container(
      padding: const EdgeInsets.only(top: 9, bottom: 9, left: 38, right: 38),
      child: Text(
        buttonName,
        style: Constants.switchButtons,
      ),
    );
  }

  _buildIndexStack() {
    return IndexedStack(
      index: groupValue,
      children: [
        Column(
          children: [
            _myEmailTextField(_emailSignInController),
            _myPasswordTextField(_passwordSignInController, 'Şifre'),
            _buildUpdatePassword(),
            _buildButton(() {
              _signIn();
            },
                Text(
                  'Giriş Yap',
                  style: Constants.myWelcomeStyle,
                )),
            Center(
              child: Row(
                children: [
                  const Expanded(
                    child: Divider(
                      indent: 30,
                      height: 57,
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Ya da',
                    style: Constants.yadaStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Expanded(
                    child: Divider(
                      endIndent: 30,
                      height: 57,
                      thickness: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: _buildImage(Constants.googleUrl)),
                _buildImage(Constants.twitterUrl),
              ],
            )
          ],
        ),
        Column(
          children: [
            _myEmailTextField(_emailSignUpController),
            _myPasswordTextField(_passwordSignUpController, 'Şifre'),
            _myPasswordTextField(
                _passwordSignUpVerifiedController, 'Şifreyi Doğrulayınız'),
            const SizedBox(
              height: 45,
            ),
            _buildButton(() {
              if (_passwordSignUpController.text ==
                  _passwordSignUpVerifiedController.text) {
                _signUp();
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
                              'Girilen Şifre Uyuşmamaktadır Lütfen Tekrar Deneyiniz',
                              style: Constants.myModalSheetStyle,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ElevatedButton(
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
            }, Text('Kayıt Ol', style: Constants.myWelcomeStyle)),
          ],
        ),
      ],
    );
  }

  Decoration backgroundDecoration() {
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

  Widget _buildImage(String url) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.white10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: 65,
                height: 65,
                child: Image.asset(url),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget _buildButton(void Function() onPressed, Widget text) {
    return ElevatedButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.indigo,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(14))),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 10),
          child: text,
        ));
  }

  void _verifiedUserRotate(myUser) {
    if (myUser!.emailVerified == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
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
              'Lütfen E-mailinizi Doğrulayınız !',
              style: TextStyle(color: Colors.red),
            )),
            content: const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
              size: 85,
            ),
          );
        },
      );
    }
  }

  Widget _buildUpdatePassword() {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdatePassword(),
                    ));
              },
              child: const Text(
                'Şifremi Unuttum',
                style: TextStyle(
                    color: Colors.white70, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const HomePage(),
    ));
  }
}
