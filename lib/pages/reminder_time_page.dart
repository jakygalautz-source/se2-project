import 'package:flutter/material.dart';
import 'package:pill_pilot/api/reminder_time_api.dart';
import 'package:provider/provider.dart';
import 'package:pill_pilot/models/day_part.dart';
import 'package:pill_pilot/models/reminder_time_model.dart';
import 'package:pill_pilot/widgets/save_button.dart';

class ReminderTimePage extends StatefulWidget {
  const ReminderTimePage({super.key});

  @override
  State<ReminderTimePage> createState() => _ReminderTimePageState();
}

class _ReminderTimePageState extends State<ReminderTimePage> {
  bool isSaving = false;

  void _handleSave() async {
    final model = context.read<ReminderTimeModel>();

    setState(() => isSaving = true);

    try {
      await ReminderTimeApi.saveReminderTimes(model.toJson());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erinnerungszeiten gespeichert')),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Backend nicht erreichbar (Testmodus)')),
      );
    }

    // immer zurück (auch bei Fehler)
    if (!mounted) return;

    Navigator.pop(context);

    if (mounted) {
      setState(() => isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ReminderTimeModel>();
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(title: const Text("Erinnerungszeiten")),
      body: SafeArea(
        child: isLandscape ? _buildLandscape(model) : _buildPortrait(model),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SaveButton(onTap: _handleSave, isLoading: isSaving),
        ),
      ),
    );
  }

  Widget _buildPortrait(ReminderTimeModel model) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: DayPart.values.map((part) {
        return _buildTile(model, part);
      }).toList(),
    );
  }

  Widget _buildLandscape(ReminderTimeModel model) {
    final parts = DayPart.values;

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: (parts.length / 2).ceil(),
      itemBuilder: (context, index) {
        final left = parts[index * 2];
        final rightIndex = index * 2 + 1;
        final right = rightIndex < parts.length ? parts[rightIndex] : null;

        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Expanded(child: _buildTile(model, left)),
              const SizedBox(width: 12),
              Expanded(
                child: right != null
                    ? _buildTile(model, right)
                    : const SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTile(ReminderTimeModel model, DayPart dayPart) {
    final time = model.getTime(dayPart);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          _label(dayPart),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _formatTime(time),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () async {
          final picked = await showTimePicker(
            context: context,
            initialTime: time,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );

          if (picked != null) {
            model.setTime(dayPart, picked);
          }
        },
      ),
    );
  }

  String _label(DayPart part) {
    switch (part) {
      case DayPart.morning:
        return "Morgens";
      case DayPart.noon:
        return "Mittags";
      case DayPart.evening:
        return "Abends";
      case DayPart.night:
        return "Nachts";
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
