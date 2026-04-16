import 'package:flutter/material.dart';
import 'package:pill_pilot/widgets/save_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(title: const Text("Profileinstellungen")),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : isLandscape
            ? _buildLandscape(context)
            : _buildPortrait(context),
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("Portrait Layout"),
          SaveButton(onTap: () {}, isLoading: false),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return Center(
      child: Row(
        children: [
          const Text("Landscape Layout"),
          SaveButton(onTap: () {}, isLoading: false),
        ],
      ),
    );
  }
}
