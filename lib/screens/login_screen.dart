import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/form_utils.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _identifier = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _identifier.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeScreen.routeName,
      (_) => false,
      arguments: HomeArgs(name: displayNameFrom(_identifier.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppPageHeader(
                title: 'Log in',
                subtitle: 'Check in to your club meetings and see who showed up.',
              ),
              const SizedBox(height: AppSpacing.xl),
              TextFormField(
                controller: _identifier,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                autofillHints: const [AutofillHints.email, AutofillHints.username],
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: const InputDecoration(labelText: 'Email or username'),
                validator: Validators.required('Enter your email or username'),
              ),
              const SizedBox(height: 20),
              PasswordField(
                controller: _password,
                label: 'Password',
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                validator: Validators.required('Enter your password'),
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(onPressed: _submit, child: const Text('Log in')),
              const SizedBox(height: AppSpacing.md),
              AuthSwitchPrompt(
                prompt: 'New to Rollcall?',
                action: 'Create an account',
                onPressed: () => Navigator.of(context).pushNamed(SignUpScreen.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
