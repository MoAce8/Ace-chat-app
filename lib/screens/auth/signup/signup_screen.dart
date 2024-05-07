import 'package:ace_chat_app/screens/auth/login/login_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Create a new account',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFormField(
                  label: 'name',
                  prefix: const Icon(Icons.person),
                  controller: nameController,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFormField(
                  label: 'email',
                  keyboard: TextInputType.emailAddress,
                  prefix: const Icon(FontAwesomeIcons.envelope),
                  controller: emailController,
                ),
                const SizedBox(
                  height: 16,
                ),
                AppTextFormField(
                  label: 'password',
                  keyboard: TextInputType.visiblePassword,
                  controller: passwordController,
                  obscure: passwordVisible,
                  prefix: const Icon(FontAwesomeIcons.lock),
                  suffix: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppButton(
                    text: 'Sign Up',
                    function: () async{
                      if (formKey.currentState!.validate()) {
                        try {
                          await createNewUser();
                          showSnackBar(context, 'Account created successfully');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                              ));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(context,
                                'The account already exists for that email.');
                          }else{
                            showSnackBar(context,
                                e.toString());
                          }
                        } catch (e) {
                          showSnackBar(context, 'There was an error');
                        }
                      }

                    }),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: screenWidth(context) * 0.033,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ));
                      },
                      child: Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue[200],
                            fontSize: screenWidth(context) * 0.033,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createNewUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }
}
