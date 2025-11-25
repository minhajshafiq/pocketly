import 'package:flutter/material.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';

/// Formulaire réutilisable pour créer/éditer un pocket
///
/// TODO: Implémenter le formulaire complet avec validation
class PocketForm extends StatefulWidget {
  final PocketEntity? pocket;
  final ValueChanged<PocketEntity> onSave;

  const PocketForm({
    super.key,
    this.pocket,
    required this.onSave,
  });

  @override
  State<PocketForm> createState() => _PocketFormState();
}

class _PocketFormState extends State<PocketForm> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Formulaire à implémenter'),
    );
  }
}
