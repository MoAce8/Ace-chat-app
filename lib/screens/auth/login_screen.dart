import 'package:ace_chat_app/screens/auth/signup_screen.dart';
import 'package:ace_chat_app/screens/home/tabs_screen/home_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: screenHeight(context) * .2,
                color: kPrimaryColor,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Welcome',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Trying to login?',
                style: Theme.of(context).textTheme.bodyLarge,
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
                height: 6,
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forget password',
                      style: TextStyle(
                        fontSize: screenWidth(context) * 0.033,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              AppButton(
                  text: 'Login',
                  function: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ));
                  }),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Don\'t have an account? ',
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
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: Text(
                      'Sign up now',
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
    );
  }
}
