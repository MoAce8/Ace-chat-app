import 'package:ace_chat_app/shared/app_logo.dart';
import 'package:ace_chat_app/shared/constants.dart';
import 'package:ace_chat_app/widgets/app_button.dart';
import 'package:ace_chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  var emailController = TextEditingController();

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
              const AppLogo(),
              const SizedBox(
                height: 16,
              ),
              Text(
                'Reset Password',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Please Enter Your Email',
                style: Theme.of(context).textTheme.bodyMedium,
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
              AppButton(
                  text: 'Send Email',
                  function: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) {
                          Navigator.pop(context);
                          showSnackBar(context, 'Check your email');
                        })
                        .onError((error, stackTrace) {
                          showSnackBar(context, error.toString());
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
