import 'package:flutter/material.dart';
import 'package:pill_pilot/api/auth_api.dart';
import 'package:pill_pilot/models/auth_model.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/widgets/my_snackbar.dart';
import 'package:pill_pilot/widgets/login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      MySnackbar.show(
        context,
        message: "Bitte E-Mail-Adresse und Passwort eingeben",
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await AuthApi.login(LoginRequest(email: email, password: password));

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/home_page');
    } catch (_) {
      if (!mounted) return;

      MySnackbar.show(context, message: "Login fehlgeschlagen");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anmelden"), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),
              Text(
                "Willkommen zurück",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                "Bitte melden Sie sich mit Ihrer E-Mail-Adresse und Ihrem Passwort an.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              MyCard(
                border: Border.all(color: Colors.black),
                child: Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "E-Mail-Adresse",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Passwort",
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              LoginButton(onTap: _handleLogin, isLoading: _isLoading),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register_page');
                },
                child: const Text(
                  "Noch kein Konto? Jetzt registrieren",
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
