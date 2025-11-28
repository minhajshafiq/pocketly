import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/transactions/domain/entities/transaction_entity.dart';
import 'package:pocketly/features/transactions/presentation/providers/transaction_provider.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/core/router/app_route_paths.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/pockets/pockets.dart';
import 'package:pocketly/features/category/category.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Provider pour récupérer les occurrences d'une transaction
final transactionOccurrencesProvider = Provider.autoDispose
    .family<List<TransactionEntity>, String>((ref, transactionId) {
      // Lire l'état actuel des transactions (sans déclencher de chargement)
      final transactionState = ref.watch(transactionProvider);
      final allTransactions = transactionState.allTransactions;

      // Trouver la transaction par ID (avec gestion d'erreur)
      final transactionIndex = allTransactions.indexWhere(
        (t) => t.id == transactionId,
      );

      if (transactionIndex == -1) {
        // Transaction non trouvée
        return [];
      }

      final transaction = allTransactions[transactionIndex];

      if (!transaction.isRecurring) {
        // Si la transaction n'est pas récurrente, retourner seulement elle-même
        return [transaction];
      }

      // Si récurrente, récupérer toutes les transactions du même groupe de récurrence
      if (transaction.recurrenceGroupId != null) {
        final occurrences = allTransactions
            .where((t) => t.recurrenceGroupId == transaction.recurrenceGroupId)
            .toList();

        // Trier par date (du plus récent au plus ancien)
        occurrences.sort((a, b) => b.date.compareTo(a.date));

        return occurrences;
      }

      // Générer les occurrences entre la date de début et maintenant
      final now = DateTime.now();
      final startDate = transaction.recurrenceStartDate ?? transaction.date;

      return transaction.getOccurrencesBetween(start: startDate, end: now);
    });

/// Modal de détails d'une transaction avec design amélioré
class TransactionDetailModal extends ConsumerWidget {
  final String transactionId;

  const TransactionDetailModal({required this.transactionId, super.key});

  bool get _isIOS => !kIsWeb && Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final transactionState = ref.watch(transactionProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        Widget content;

        // Si les transactions ne sont pas encore chargées, charger
        if (transactionState.allTransactions.isEmpty &&
            !transactionState.isLoadingState) {
          // Déclencher le chargement une seule fois
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(transactionProvider.notifier).loadTransactions();
          });
          content = _buildLoadingContent();
        } else if (transactionState.isLoadingState) {
          content = _buildLoadingContent();
        } else if (transactionState.hasError) {
          content = _buildErrorContent(
            l10n,
            isDark,
            transactionState.errorMessage ?? 'Unknown error',
          );
        } else {
          try {
            final occurrences = ref.watch(
              transactionOccurrencesProvider(transactionId),
            );

            if (occurrences.isEmpty) {
              content = _buildErrorContent(
                l10n,
                isDark,
                'Transaction introuvable',
              );
            } else {
              final transaction = occurrences.first;
              content = _buildContentScrollable(
                context,
                ref,
                transaction,
                occurrences,
                scrollController,
                isDark,
                l10n,
              );
            }
          } catch (e) {
            content = _buildErrorContent(
              l10n,
              isDark,
              'Erreur: ${e.toString()}',
            );
          }
        }

        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.backgroundDark : AppColors.background,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radiusXL),
            ),
          ),
          child: Column(
            children: [
              // Handle pour indiquer qu'on peut swiper
              _buildHandle(isDark),

              // Header avec titre et boutons d'action
              _buildHeader(context, ref, l10n, isDark),

              // Contenu
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle(bool isDark) {
    return Container(
      margin: EdgeInsets.only(
        top: AppDimensions.paddingM,
        bottom: AppDimensions.paddingS,
      ),
      width: 48,
      height: 5,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.borderDark.withValues(alpha: 0.8)
            : AppColors.borderLight.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    bool isDark,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Titre
          Expanded(
            child: Text(
              l10n.transactionDetails,
              style: AppTypography.heading.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
            ),
          ),

          // Bouton éditer
          _buildHeaderButton(
            context: context,
            icon: _isIOS ? CupertinoIcons.pencil : AppIcons.edit,
            onPressed: () => _handleEdit(context, ref),
            isDark: isDark,
          ),

          SizedBox(width: AppDimensions.paddingS),

          // Bouton supprimer
          _buildHeaderButton(
            context: context,
            icon: _isIOS ? CupertinoIcons.delete : AppIcons.delete,
            onPressed: () => _handleDelete(context, ref, l10n),
            isDark: isDark,
            isDestructive: true,
          ),

          SizedBox(width: AppDimensions.paddingS),

          // Bouton fermer
          _buildHeaderButton(
            context: context,
            icon: _isIOS ? CupertinoIcons.xmark : AppIcons.close,
            onPressed: () => Navigator.of(context).pop(),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isDark,
    bool isDestructive = false,
  }) {
    final color = isDestructive
        ? AppColors.error
        : (isDark ? AppColors.textOnDark : AppColors.textPrimary);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.backgroundDark : AppColors.background,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
        color: color,
        padding: EdgeInsets.all(AppDimensions.paddingS),
        constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      ),
    );
  }

  Widget _buildContentScrollable(
    BuildContext context,
    WidgetRef ref,
    TransactionEntity transaction,
    List<TransactionEntity> occurrences,
    ScrollController scrollController,
    bool isDark,
    AppLocalizations l10n,
  ) {
    final category = ref.watch(categoryByIdProvider(transaction.categoryId));
    final totalAmount = occurrences.fold<double>(
      0.0,
      (sum, t) => sum + t.amount,
    );

    return ListView(
      controller: scrollController,
      padding: EdgeInsets.all(AppDimensions.paddingL),
      children: [
        // Icône de transaction
        _buildTransactionIcon(context, ref, transaction, category, isDark),

        SizedBox(height: AppDimensions.paddingL),

        // Nom
        Center(
          child: Text(
            transaction.name,
            style: AppTypography.heading.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: AppDimensions.paddingM),

        // Prix
        Center(
          child: CurrencyDisplayWidget(
            amount: transaction.amount,
            style: AppTypography.heading.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: transaction.isExpense ? AppColors.error : AppColors.success,
            ),
            decimals: 2,
          ),
        ),

        SizedBox(height: AppDimensions.paddingM),

        // Date
        Center(
          child: _buildDateDisplay(transaction.date, isDark),
        ),

        SizedBox(height: AppDimensions.paddingXL),

        // Section "Dépensé chez [nom]"
        if (occurrences.length > 1) ...[
          _buildSpentAtSection(
            transaction: transaction,
            occurrences: occurrences,
            totalAmount: totalAmount,
            isDark: isDark,
            l10n: l10n,
          ),
          SizedBox(height: AppDimensions.paddingXL),
        ],

        // Liste des occurrences
        _buildOccurrencesList(
          context: context,
          ref: ref,
          occurrences: occurrences,
          isDark: isDark,
          l10n: l10n,
        ),

        SizedBox(height: AppDimensions.paddingXL),
      ],
    );
  }

  Widget _buildTransactionIcon(
    BuildContext context,
    WidgetRef ref,
    TransactionEntity transaction,
    CategoryEntity? category,
    bool isDark,
  ) {
    final categoryColor = category != null
        ? Color(int.parse(category.color.replaceFirst('#', '0xFF')))
        : AppColors.primary;
    final categoryIcon = category != null
        ? AppIcons.getCategoryIcon(category.iconName)
        : (transaction.isExpense ? AppIcons.shopping : AppIcons.wallet);

    return Center(
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: categoryColor.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: transaction.imageUrl != null && transaction.imageUrl!.isNotEmpty
              ? Image.network(
                  transaction.imageUrl!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      categoryIcon,
                      color: categoryColor,
                      size: 40,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                )
              : Icon(
                  categoryIcon,
                  color: categoryColor,
                  size: 40,
                ),
        ),
      ),
    );
  }

  Widget _buildDateDisplay(DateTime date, bool isDark) {
    final formatted = DateFormat('d MMMM yyyy', 'fr_FR').format(date);
    final parts = formatted.split(' ');
    if (parts.length >= 3) {
      parts[1] = parts[1][0].toUpperCase() + parts[1].substring(1);
    }
    final dateString = parts.join(' ');

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingM,
        vertical: AppDimensions.paddingS,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusS),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
          SizedBox(width: AppDimensions.paddingS),
          Text(
            dateString,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpentAtSection({
    required TransactionEntity transaction,
    required List<TransactionEntity> occurrences,
    required double totalAmount,
    required bool isDark,
    required AppLocalizations l10n,
  }) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dépensé chez ${transaction.name}',
            style: AppTypography.heading.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: AppDimensions.paddingM),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  label: 'Nombre de fois',
                  value: occurrences.length.toString(),
                  icon: Icons.repeat,
                  color: AppColors.info,
                  isDark: isDark,
                ),
              ),
              SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: _buildSummaryItemWithAmount(
                  label: 'Total',
                  amount: totalAmount,
                  icon: Icons.attach_money,
                  color: AppColors.error,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: AppDimensions.paddingXS),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.small.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            value,
            style: AppTypography.heading.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItemWithAmount({
    required String label,
    required double amount,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: AppDimensions.paddingXS),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.small.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingS),
          CurrencyDisplayWidget(
            amount: amount,
            style: AppTypography.heading.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            decimals: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildOccurrencesList({
    required BuildContext context,
    required WidgetRef ref,
    required List<TransactionEntity> occurrences,
    required bool isDark,
    required AppLocalizations l10n,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
          child: Text(
            l10n.occurrenceHistory,
            style: AppTypography.heading.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(height: AppDimensions.paddingM),
        ...occurrences.map((occurrence) {
          return Padding(
            padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
            child: _buildOccurrenceItem(
              context: context,
              ref: ref,
              occurrence: occurrence,
              isDark: isDark,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildOccurrenceItem({
    required BuildContext context,
    required WidgetRef ref,
    required TransactionEntity occurrence,
    required bool isDark,
  }) {
    final category = ref.watch(categoryByIdProvider(occurrence.categoryId));
    final categoryColor = category != null
        ? Color(int.parse(category.color.replaceFirst('#', '0xFF')))
        : AppColors.primary;
    final categoryIcon = category != null
        ? AppIcons.getCategoryIcon(category.iconName)
        : (occurrence.isExpense ? AppIcons.shopping : AppIcons.wallet);

    final formatted = DateFormat('d MMMM', 'fr_FR').format(occurrence.date);
    final parts = formatted.split(' ');
    if (parts.length >= 2) {
      parts[1] = parts[1][0].toUpperCase() + parts[1].substring(1);
    }
    final dateString = parts.join(' ');

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Row(
        children: [
          // Icône de transaction (image ou icône de catégorie)
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            child: occurrence.imageUrl != null && occurrence.imageUrl!.isNotEmpty
                ? Image.network(
                    occurrence.imageUrl!,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: categoryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        child: Icon(
                          categoryIcon,
                          color: categoryColor,
                          size: 24,
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: categoryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: categoryColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    ),
                    child: Icon(
                      categoryIcon,
                      color: categoryColor,
                      size: 24,
                    ),
                  ),
          ),
          SizedBox(width: AppDimensions.paddingM),
          // Nom et date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  occurrence.name,
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppDimensions.paddingXS),
                Text(
                  dateString,
                  style: AppTypography.small.copyWith(
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Prix
          CurrencyDisplayWidget(
            amount: occurrence.amount,
            style: AppTypography.bodyBold.copyWith(
              fontSize: 16,
              color: occurrence.isExpense ? AppColors.error : AppColors.success,
            ),
            decimals: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(
    BuildContext context,
    TransactionEntity transaction,
    bool isDark,
    AppLocalizations l10n,
  ) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.information,
            style: AppTypography.heading.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),

          SizedBox(height: AppDimensions.paddingM),

          _buildInfoRow(
            icon: AppIcons.category,
            label: l10n.type,
            value: transaction.isExpense ? l10n.expense : l10n.income,
            color: transaction.isExpense ? AppColors.error : AppColors.success,
            isDark: isDark,
          ),

          if (transaction.pocketId != null) ...[
            SizedBox(height: AppDimensions.paddingM),
            _buildPocketInfoRow(
              context: context,
              transaction: transaction,
              l10n: l10n,
              isDark: isDark,
            ),
          ],

          if (transaction.isRecurring) ...[
            SizedBox(height: AppDimensions.paddingM),
            _buildInfoRow(
              icon: AppIcons.repeat,
              label: l10n.recurrence,
              value: transaction.recurrence.getName(l10n),
              color: AppColors.warning,
              isDark: isDark,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPocketInfoRow({
    required BuildContext context,
    required TransactionEntity transaction,
    required AppLocalizations l10n,
    required bool isDark,
  }) {
    if (transaction.pocketId == null) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, child) {
        final pocketAsync = ref.watch(
          pocketByIdProvider(transaction.pocketId!),
        );

        return pocketAsync.when(
          data: (pocket) {
            final pocketName = pocket != null
                ? pocket.getName(l10n)
                : l10n.assigned;
            return _buildInfoRow(
              icon: AppIcons.wallet,
              label: 'Pocket',
              value: pocketName,
              color: AppColors.info,
              isDark: isDark,
            );
          },
          loading: () => _buildInfoRow(
            icon: AppIcons.wallet,
            label: 'Pocket',
            value: l10n.assigned,
            color: AppColors.info,
            isDark: isDark,
          ),
          error: (error, stack) => _buildInfoRow(
            icon: AppIcons.wallet,
            label: 'Pocket',
            value: l10n.assigned,
            color: AppColors.info,
            isDark: isDark,
          ),
        );
      },
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.small.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryOnDark
                      : AppColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: AppTypography.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNotesCard(String notes, bool isDark, AppLocalizations l10n) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                AppIcons.notes,
                size: 18,
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
              SizedBox(width: AppDimensions.paddingS),
              Text(
                l10n.notes,
                style: AppTypography.heading.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: AppDimensions.paddingM),
          Text(
            notes,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Center(
      child: _isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );
  }

  Widget _buildErrorContent(AppLocalizations l10n, bool isDark, String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isIOS ? CupertinoIcons.exclamationmark_triangle : AppIcons.error,
              size: 64,
              color: AppColors.error,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.error,
              style: AppTypography.heading.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              error,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }

  void _handleEdit(BuildContext context, WidgetRef ref) {
    // Fermer la modal
    Navigator.of(context).pop();

    // Naviguer vers l'écran d'édition
    context.push('${AppRoutePaths.editTransaction}/$transactionId');
  }

  Future<void> _handleDelete(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirmed = await _showDeleteConfirmation(context, l10n);

    if (confirmed == true) {
      try {
        await ref
            .read(transactionProvider.notifier)
            .deleteTransaction(transactionId);

        if (context.mounted) {
          // Fermer la modal
          Navigator.of(context).pop();

          // Afficher notification de succès
          InAppNotificationService.showSuccess(
            context,
            title: l10n.success,
            message: l10n.transactionDeletedSuccess,
          );
        }
      } catch (e) {
        if (context.mounted) {
          InAppNotificationService.showError(
            context,
            title: l10n.error,
            message: l10n.transactionDeleteError,
          );
        }
      }
    }
  }

  Future<bool?> _showDeleteConfirmation(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(l10n.deleteTransactionTitle),
          content: Text(l10n.deleteTransactionMessage),
          actions: [
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.cancel),
            ),
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              isDestructiveAction: true,
              child: Text(l10n.delete),
            ),
          ],
        ),
      );
    }

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        title: Text(
          l10n.deleteTransactionTitle,
          style: AppTypography.heading.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        content: Text(
          l10n.deleteTransactionMessage,
          style: AppTypography.body.copyWith(
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              l10n.cancel,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.delete,
              style: AppTypography.body.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper function pour ouvrir la modal de détails de transaction
void showTransactionDetailModal(BuildContext context, String transactionId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    isDismissible: true,
    enableDrag: true,
    builder: (context) => TransactionDetailModal(transactionId: transactionId),
  );
}
