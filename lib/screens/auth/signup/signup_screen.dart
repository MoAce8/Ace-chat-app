import 'package:ace_chat_app/cubit/signup_cubit/signup_cubit.dart';
import 'package:ace_chat_app/screens/auth/login/login_screen.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          Navigator.pop(context);
          showSnackBar(context, 'Account created successfully');
        } else if (state is SignupFailure) {
          showSnackBar(context, state.errMessage);
        }
      },
      child: Scaffold(
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
                    label: 'Name',
                    prefix: const Icon(Icons.person),
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFormField(
                    label: 'Email',
                    keyboard: TextInputType.emailAddress,
                    prefix: const Icon(FontAwesomeIcons.envelope),
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  AppTextFormField(
                    label: 'Password',
                    keyboard: TextInputType.visiblePassword,
                    controller: passwordController,
                    obscure: passwordVisible,
                    prefix: const Icon(FontAwesomeIcons.lock),
                    suffix: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
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
                      function: () async {
                        if (formKey.currentState!.validate()) {
                          SignupCubit.get(context).createNewUser(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text);
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
      ),
    );
  }
}
