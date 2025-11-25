import 'package:flutter/material.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';

/// Widget de configuration d'objectif d'épargne
///
/// TODO: Implémenter la configuration d'objectifs
class SavingsGoalConfigWidget extends StatefulWidget {
  final PocketEntity pocket;
  final ValueChanged<PocketEntity> onSave;

  const SavingsGoalConfigWidget({
    super.key,
    required this.pocket,
    required this.onSave,
  });

  @override
  State<SavingsGoalConfigWidget> createState() =>
      _SavingsGoalConfigWidgetState();
}

class _SavingsGoalConfigWidgetState extends State<SavingsGoalConfigWidget> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Configuration objectif à implémenter'),
    );
  }
}
