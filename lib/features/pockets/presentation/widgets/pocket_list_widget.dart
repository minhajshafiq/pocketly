import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/presentation/widgets/pocket_card.dart';

/// Widget liste de pockets
///
/// Affiche une liste scrollable de pockets.
class PocketListWidget extends ConsumerWidget {
  final List<PocketEntity> pockets;
  final VoidCallback? onRefresh;

  const PocketListWidget({
    super.key,
    required this.pockets,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (pockets.isEmpty) {
      return const Center(
        child: Text('Aucun pocket'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      itemCount: pockets.length,
      itemBuilder: (context, index) {
        final pocket = pockets[index];
        return Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
          child: PocketCard(
            pocket: pocket,
            transactionCount: ref.watch(transactionCountByPocketProvider(pocket.id)),
            onTap: () {
              // TODO: Navigate to details
            },
          ),
        );
      },
    );
  }
}
