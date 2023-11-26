import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../screens/Home/home_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isSignIn = true;
  @override
  Widget build(BuildContext context) => isSignIn
      ? SignInLoginWidget(onClickedSignUp: toggle)
      : SignupWidget(onClickedSignUp: toggle);

  void toggle() => setState(() => isSignIn = !isSignIn);
}

class SignupWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignupWidget({super.key, required this.onClickedSignUp});

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  var formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObsured = true;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 250,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: 'Email', border: OutlineInputBorder()),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ((email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid Email'
                          : null),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObsured,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () =>
                              setState(() => _isObsured = !_isObsured),
                          icon: _isObsured
                              ? const Icon(
                                  Icons.visibility,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  size: 20,
                                ))),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter minimum 6 characters'
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      signUp();
                    },
                    icon: const Icon(Icons.person_add_alt_1_outlined),
                    label: const Text('Sign up')),

                //Sign Up
                const SizedBox(
                  height: 10,
                ),
                RichText(
                    text: TextSpan(
                        text: 'Already a user?',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                      TextSpan(
                        text: '  Sign In',
                        style: const TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.onClickedSignUp();
                          },
                      )
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  signUp() async {
    bool isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);

      Utilis.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

class SignInLoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignInLoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<SignInLoginWidget> createState() => _SignInLoginWidgetState();
}

class _SignInLoginWidgetState extends State<SignInLoginWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObsured = true;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  void onEyePresses() => setState(() => _isObsured = !_isObsured);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: 'Email', border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                obscureText: _isObsured,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: _isObsured
                        ? passwordIcon(
                            icon: Icons.visibility, onEyePresses: onEyePresses)
                        : passwordIcon(
                            icon: Icons.visibility_off,
                            onEyePresses: onEyePresses)),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    signIn();
                  },
                  icon: const Icon(Icons.login_outlined),
                  label: const Text('Sign In')),

              //Forgot password
              const SizedBox(
                height: 5,
              ),
              TextButton(
                style: ButtonStyle(
                    overlayColor:
                        MaterialStateProperty.all(Colors.transparent)),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const ForgotPasswordPage()))),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              //Sign Up
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(
                      text: 'New User?',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                    TextSpan(
                      text: '  Create account',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.onClickedSignUp();
                        },
                    )
                  ]))
            ],
          ),
        ),
      ),
    );
  }

  signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      Utilis.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  passwordIcon({required IconData icon, required VoidCallback onEyePresses}) =>
      IconButton(
        onPressed: () => onEyePresses(),
        icon: Icon(icon),
        iconSize: 20,
      );
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: 250,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: 'Email', border: OutlineInputBorder()),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ((email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid Email'
                          : null),
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () => resetPassword(),
                    icon: const Icon(Icons.person_add_alt_1_outlined),
                    label: const Text('Reset Password')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  resetPassword() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: ((context) => const Center(child: CircularProgressIndicator())),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      Utilis.showSnackBar('Check your email to reset the password');

      // ignore: use_build_context_synchronously
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      Utilis.showSnackBar(e.message);
      Navigator.pop(context);
    }
  }
}

class Utilis {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(errorMsg, {Color color = const Color(0xFFEF9A9A)}) {
    if (errorMsg == null) return null;

    final snackBar = SnackBar(
      content: Text(errorMsg),
      backgroundColor: color,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool shouldResend = false;

  @override
  void initState() {
    super.initState();

    verificationProcess();
  }

  Future<void> verificationProcess() async {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      await sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailIfVerified());
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await user!.sendEmailVerification();

      setState(() => shouldResend = false);
      Timer.periodic(const Duration(seconds: 5), (_) {});
      setState(() => shouldResend = true);
    } catch (e) {
      Utilis.showSnackBar(e.toString());
    }
  }

  Future<void> checkEmailIfVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomeScreen()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verify Email'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'A verification email has been sent to this email',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () =>
                        shouldResend ? sendVerificationEmail() : null,
                    icon: const Icon(Icons.attach_email),
                    label: const Text("Resend Email")),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ))
              ],
            ),
          ),
        );
}
