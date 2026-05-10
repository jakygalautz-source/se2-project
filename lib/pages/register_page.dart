import 'package:flutter/material.dart';
import 'package:pill_pilot/api/auth_api.dart';
import 'package:pill_pilot/models/auth_model.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/widgets/my_snackbar.dart';
import 'package:pill_pilot/widgets/save_button.dart';
import 'package:pill_pilot/widgets/password_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      MySnackbar.show(context, message: "Bitte alle Pflichtfelder ausfüllen");
      return;
    }

    if (password != confirmPassword) {
      MySnackbar.show(context, message: "Die Passwörter stimmen nicht überein");
      return;
    }

    if (password.length < 6) {
      MySnackbar.show(
        context,
        message: "Das Passwort muss mindestens 6 Zeichen haben",
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await AuthApi.register(
        RegisterRequest(username: username, email: email, password: password),
      );

      if (!mounted) return;

      MySnackbar.show(context, message: "Registrierung erfolgreich");

      Navigator.pushReplacementNamed(context, '/login_page');
    } catch (_) {
      if (!mounted) return;

      MySnackbar.show(context, message: "Registrierung fehlgeschlagen");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registrieren"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 24),
              Text(
                "Konto erstellen",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "Bitte geben Sie Ihre Daten ein, um Pill Pilot zu verwenden.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              MyCard(
                border: Border.all(color: Colors.black),
                child: Column(
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "Benutzername",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "E-Mail-Adresse",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 18),
                    PasswordTextfield(
                      controller: _passwordController,
                      labelText: "Passwort",
                    ),
                    const SizedBox(height: 18),
                    PasswordTextfield(
                      controller: _confirmPasswordController,
                      labelText: "Passwort bestätigen",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SaveButton(onTap: _handleRegister, isLoading: _isLoading),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login_page');
                },
                child: const Text(
                  "Ich habe bereits ein Konto",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
