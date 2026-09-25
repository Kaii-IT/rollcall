import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/form_utils.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeScreen.routeName,
      (_) => false,
      arguments: HomeArgs(name: _name.text.trim()),
    );
  }

  void _goToLogin() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
    } else {
      navigator.pushReplacementNamed(LoginScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fieldStyle = Theme.of(context).textTheme.bodyLarge;

    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppPageHeader(
                title: 'Create your account',
                subtitle: 'Use your university email so your clubs can find you.',
              ),
              const SizedBox(height: AppSpacing.xl),
              TextFormField(
                controller: _name,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                style: fieldStyle,
                decoration: const InputDecoration(labelText: 'Full name'),
                validator: Validators.required('Enter your name'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
                style: fieldStyle,
                decoration: const InputDecoration(labelText: 'University email'),
                validator: Validators.email,
              ),
              const SizedBox(height: 20),
              PasswordField(
                controller: _password,
                label: 'Password',
                autofillHints: const [AutofillHints.newPassword],
                validator: Validators.newPassword,
              ),
              const SizedBox(height: 20),
              PasswordField(
                controller: _confirm,
                label: 'Confirm password',
                autofillHints: const [AutofillHints.newPassword],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submit(),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Re-enter your password';
                  if (value != _password.text) return 'Passwords don\u2019t match';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(onPressed: _submit, child: const Text('Sign up')),
              const SizedBox(height: AppSpacing.md),
              AuthSwitchPrompt(
                prompt: 'Already have an account?',
                action: 'Log in',
                onPressed: _goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
