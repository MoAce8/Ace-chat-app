import 'package:ace_chat_app/cubit/login_cubit/login_cubit.dart';
import 'package:ace_chat_app/screens/auth/forget_password/forget_password_screen.dart';
import 'package:ace_chat_app/screens/auth/signup/signup_screen.dart';
import 'package:ace_chat_app/shared/app_logo.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showSnackBar(context, 'Login successful');
          } else if (state is LoginFailure) {
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
                    const AppLogo(),
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
                      height: 6,
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgetPasswordScreen(),
                                ));
                          },
                          child: Text(
                            'Forget password?',
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
                        function: () async {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                          }
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
                            Navigator.push(
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
          ),
        ),
      ),
    );
  }
}
