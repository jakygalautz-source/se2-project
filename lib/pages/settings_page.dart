import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/save_button.dart';
import 'package:pill_pilot/widgets/my_card.dart';
import 'package:pill_pilot/widgets/my_snackbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    setState(() => _isSaving = true);
    // !!!!! TODO: Model bauen und api, Backend verknüpfen !!!!!!!
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() => _isSaving = false);

    MySnackbar.show(context, message: "Profileinstellungen gespeichert");
  }

  bool _isSaving = false;
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(title: const Text("Einstellungen")),
      body: SafeArea(
        child: isLandscape ? _buildLandscape(context) : _buildPortrait(context),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profileinstellungen",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "Verwalten Sie Ihre persönlichen Daten.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
          _buildProfileCard(context),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: SaveButton(onTap: _handleSave, isLoading: _isSaving),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Profileinstellungen",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  "Hier können Benutzername, E-Mail-Adresse und Passwort verwaltet werden.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 260,
                    child: SaveButton(onTap: _handleSave, isLoading: _isSaving),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(children: [_buildProfileCard(context)]),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return MyCard(
      border: Border.all(color: Colors.black, width: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: "Benutzername"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: "E-Mail-Adresse"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Neues Passwort"),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmPasswordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: "Passwort bestätigen"),
          ),
        ],
      ),
    );
  }
}
