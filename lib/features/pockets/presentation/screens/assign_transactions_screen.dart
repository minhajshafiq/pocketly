import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/pockets/presentation/providers/pocket_providers.dart';
import 'package:pocketly/features/pockets/domain/entities/pocket_entity.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/notifications/notifications.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Écran pour assigner des transactions existantes à un pocket
///
/// Permet de sélectionner plusieurs transactions et de les assigner au pocket actuel
class AssignTransactionsScreen extends ConsumerStatefulWidget {
  final String pocketId;
  final String pocketName;

  const AssignTransactionsScreen({
    super.key,
    required this.pocketId,
    required this.pocketName,
  });

  @override
  ConsumerState<AssignTransactionsScreen> createState() =>
      _AssignTransactionsScreenState();
}

class _AssignTransactionsScreenState
    extends ConsumerState<AssignTransactionsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _selectedTransactionIds = {};
  final Set<int> _initiallyAssignedIds = {};
  bool _isAssigning = false;
  bool _isInitialized = false;
  String _searchQuery = '';

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Charger les transactions au montage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(transactionProvider.notifier).loadTransactions();
    });
  }

  /// Initialise les sélections avec les transactions déjà assignées au pocket
  void _initializeSelections(List transactions) {
    if (_isInitialized) return;
    _isInitialized = true;

    final assignedIds = transactions
        .where((t) => t.pocketId == widget.pocketId)
        .map((t) => t.id as int)
        .toSet();

    setState(() {
      _selectedTransactionIds.addAll(assignedIds);
      _initiallyAssignedIds.addAll(assignedIds);
    });
  }

  /// Vérifie s'il y a des changements par rapport à l'état initial
  bool _hasChanges() {
    if (!_isInitialized) return false;

    // Vérifier si les sélections sont différentes de l'état initial
    return _selectedTransactionIds.length != _initiallyAssignedIds.length ||
        !_selectedTransactionIds.containsAll(_initiallyAssignedIds) ||
        !_initiallyAssignedIds.containsAll(_selectedTransactionIds);
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer toutes les transactions de l'utilisateur
    final l10n = AppLocalizations.of(context)!;
    final notifier = ref.watch(transactionProvider.notifier);
    final state = ref.watch(transactionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            state.isLoadingState
                ? SingleChildScrollView(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      top: AppDimensions.appBarHeight + AppDimensions.paddingL + AppDimensions.paddingM,
                      left: AppDimensions.paddingM,
                      right: AppDimensions.paddingM,
                      bottom: AppDimensions.paddingM,
                    ),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : state.hasError
                    ? SingleChildScrollView(
                        controller: _scrollController,
                        padding: EdgeInsets.only(
                          top: AppDimensions.appBarHeight + AppDimensions.paddingL + AppDimensions.paddingM,
                          left: AppDimensions.paddingM,
                          right: AppDimensions.paddingM,
                          bottom: AppDimensions.paddingM,
                        ),
                        child: ErrorDisplay(
                          error: UnknownError(
                            technicalMessage: state.errorMessage ?? 'Unknown error',
                          ),
                          onRetry: () {
                            notifier.loadTransactions();
                          },
                        ),
                      )
                    : _buildTransactionsList(state.allTransactions, isDark),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.assignTransactionsTo(widget.pocketName),
                scrollController: _scrollController,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _hasChanges() ? _buildBottomBar(context) : null,
    );
  }

  Widget _buildTransactionsList(List transactions, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    // Filtrer uniquement les dépenses
    final expenses = transactions.where((t) => t.isExpense).toList();
    
    // Filtrer par recherche
    final filteredTransactions = _searchQuery.isEmpty
        ? expenses
        : expenses.where((transaction) {
            final query = _searchQuery.toLowerCase();
            return transaction.name.toLowerCase().contains(query) ||
                (transaction.notes?.toLowerCase().contains(query) ?? false);
          }).toList();
    
    // Initialiser les sélections avec les transactions déjà assignées
    _initializeSelections(expenses);

    if (filteredTransactions.isEmpty) {
      return SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: AppDimensions.appBarHeight + AppDimensions.paddingL + AppDimensions.paddingM,
          left: AppDimensions.paddingM,
          right: AppDimensions.paddingM,
          bottom: AppDimensions.paddingM,
        ),
        child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Icon(
                AppIcons.bills,
                size: AppDimensions.iconXXL,
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                _searchQuery.isEmpty
                    ? l10n.noExpensesAvailable
                    : l10n.noExpensesFound,
                style: AppTypography.title,
              ),
              SizedBox(height: AppDimensions.paddingS),
            Text(
              _searchQuery.isEmpty
                  ? l10n.createExpenseTransactionsFirst
                  : l10n.tryOtherKeywords,
                style: AppTypography.body.copyWith(
                  color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                ),
            ),
          ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(transactionProvider.notifier).loadTransactions();
        // Attendre un peu pour que les transactions se chargent
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: ListView(
        controller: _scrollController,
        padding: EdgeInsets.only(
          top: AppDimensions.appBarHeight + AppDimensions.paddingL + AppDimensions.paddingM,
          left: AppDimensions.paddingM,
          right: AppDimensions.paddingM,
          bottom: AppDimensions.paddingM + (_hasChanges() ? 100 : 0), // Espace pour la bottom bar
        ),
        children: [
          // Barre de recherche
          AppTextField(
            controller: _searchController,
            label: l10n.searchTransaction,
            hint: l10n.searchTransaction,
            type: AppTextFieldType.search,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(AppIcons.close),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _searchQuery = '';
                      });
                    },
                  )
                : null,
          ),
          SizedBox(height: AppDimensions.paddingL),
          
          // Liste des transactions
          ...filteredTransactions.map((transaction) {
        final isSelected = _selectedTransactionIds.contains(transaction.id);
        final isAssignedToOtherPocket =
            transaction.pocketId != null &&
            transaction.pocketId != widget.pocketId;

        return Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
          child: AppCard(
            padding: EdgeInsets.zero,
            child: CheckboxListTile(
              value: isSelected,
              onChanged: isAssignedToOtherPocket
                  ? null // Désactivé si déjà assigné à un autre pocket
                  : (value) {
                      setState(() {
                        if (value == true) {
                          _selectedTransactionIds.add(transaction.id!);
                        } else {
                          _selectedTransactionIds.remove(transaction.id);
                        }
                      });
                    },
              title: Text(
                transaction.name,
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                    style: AppTypography.small.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.textSecondaryOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (isAssignedToOtherPocket)
                    Padding(
                      padding: EdgeInsets.only(top: AppDimensions.paddingXS),
                      child: Text(
                        l10n.alreadyAssignedToOtherPocket,
                        style: AppTypography.small.copyWith(
                          color: AppColors.warningDark,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  if (transaction.pocketId == widget.pocketId)
                    Padding(
                      padding: EdgeInsets.only(top: AppDimensions.paddingXS),
                      child: Text(
                        l10n.assignedToThisPocket,
                        style: AppTypography.small.copyWith(
                          color: AppColors.infoDark,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
              secondary: CircleAvatar(
                radius: 20,
                backgroundColor: transaction.isExpense
                    ? AppColors.errorLight.withValues(alpha: 0.1)
                    : AppColors.successLight.withValues(alpha: 0.1),
                child: ClipOval(
                  child:
                      transaction.imageUrl != null &&
                          transaction.imageUrl!.isNotEmpty
                      ? Image.network(
                          transaction.imageUrl!,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              transaction.isExpense
                                  ? AppIcons.expense
                                  : AppIcons.income,
                              color: transaction.isExpense
                                  ? AppColors.error
                                  : AppColors.success,
                              size: 20,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                width: AppDimensions.iconS,
                                height: AppDimensions.iconS,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        )
                      : Icon(
                          transaction.isExpense
                              ? AppIcons.expense
                              : AppIcons.income,
                          color: transaction.isExpense
                              ? AppColors.error
                              : AppColors.success,
                          size: 20,
                        ),
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ),
        );
      }),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Calculer les changements
    final toAssign = _selectedTransactionIds
        .where((id) => !_initiallyAssignedIds.contains(id))
        .length;

    final toUnassign = _initiallyAssignedIds
        .where((id) => !_selectedTransactionIds.contains(id))
        .length;

    String changeText = '';
    if (toAssign > 0 && toUnassign > 0) {
      changeText = l10n.transactionsToAssignAndRemove(toAssign, toUnassign);
    } else if (toAssign > 0) {
      changeText = l10n.transactionsToAssign(toAssign);
    } else if (toUnassign > 0) {
      changeText = l10n.transactionsToRemove(toUnassign);
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              changeText,
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.w500,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            AppButton(
              text: _isAssigning
                  ? l10n.modifyingInProgress
                  : l10n.validateModifications,
              onPressed: _isAssigning ? null : _assignTransactions,
              style: AppButtonStyle.primary,
              size: AppButtonSize.large,
              isFullWidth: true,
              icon: AppIcons.save,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _assignTransactions() async {
    // Identifier les transactions à assigner et à retirer
    final toAssign = _selectedTransactionIds
        .where((id) => !_initiallyAssignedIds.contains(id))
        .toSet();

    final toUnassign = _initiallyAssignedIds
        .where((id) => !_selectedTransactionIds.contains(id))
        .toSet();

    // Si aucun changement, fermer simplement l'écran
    if (toAssign.isEmpty && toUnassign.isEmpty) {
      if (mounted) {
        Navigator.of(context).pop(false);
      }
      return;
    }

    setState(() {
      _isAssigning = true;
    });

    try {
      final transactionRepository = ref.read(transactionRepositoryProvider);
      final pocketRepository = ref.read(pocketRepositoryProvider);
      final state = ref.read(transactionProvider);

      // Récupérer le pocket actuel
      final l10n = AppLocalizations.of(context)!;
      final pocket = await pocketRepository.getPocketById(widget.pocketId);
      if (pocket == null) {
        throw Exception(l10n.pocketNotFound);
      }

      double totalToAdd = 0.0;
      double totalToRemove = 0.0;

      // Assigner les nouvelles transactions
      for (final transactionId in toAssign) {
        final transaction = state.allTransactions.firstWhere(
          (t) => t.id == transactionId,
          orElse: () => throw Exception(l10n.transactionNotFound),
        );

        await transactionRepository.assignTransactionToPocket(
          transactionId: transactionId,
          pocketId: widget.pocketId,
        );

        // Calculer le montant à ajouter
        if (pocket.category == PocketCategory.savings) {
          if (transaction.isIncome) {
            totalToAdd += transaction.amount;
          }
        } else {
          if (transaction.isExpense) {
            totalToAdd += transaction.amount;
          }
        }
      }

      // Retirer les transactions désélectionnées
      for (final transactionId in toUnassign) {
        final transaction = state.allTransactions.firstWhere(
          (t) => t.id == transactionId,
          orElse: () => throw Exception(l10n.transactionNotFound),
        );

        await transactionRepository.unassignTransactionFromPocket(
          transactionId: transactionId,
        );

        // Calculer le montant à retirer
        if (pocket.category == PocketCategory.savings) {
          if (transaction.isIncome) {
            totalToRemove += transaction.amount;
          }
        } else {
          if (transaction.isExpense) {
            totalToRemove += transaction.amount;
          }
        }
      }

      // Calculer le changement net
      final netChange = totalToAdd - totalToRemove;

      // Mettre à jour le montant du pocket si nécessaire
      if (netChange != 0) {
        if (pocket.category == PocketCategory.savings) {
          if (netChange > 0) {
            await pocketRepository.addToSavings(
              pocketId: widget.pocketId,
              amount: netChange,
            );
          } else {
            await pocketRepository.withdrawFromSavings(
              pocketId: widget.pocketId,
              amount: -netChange,
            );
          }
        } else {
          final newSpent = pocket.spent + netChange;
          await pocketRepository.updateSpentAmount(
            pocketId: widget.pocketId,
            amount: newSpent,
          );
        }
      }

      if (mounted) {
        // Rafraîchir les transactions et les pockets
        ref.read(transactionProvider.notifier).loadTransactions();
        ref.invalidate(pocketByIdProvider(widget.pocketId));
        ref.invalidate(userPocketsProvider);

        // Construire le message de succès
        String successMessage = '';
        if (toAssign.isNotEmpty && toUnassign.isNotEmpty) {
          successMessage = l10n.transactionsAssignedAndRemoved(
            toAssign.length,
            toUnassign.length,
          );
        } else if (toAssign.isNotEmpty) {
          successMessage = l10n.transactionsAssigned(toAssign.length);
        } else if (toUnassign.isNotEmpty) {
          successMessage = l10n.transactionsRemoved(toUnassign.length);
        }

        // Afficher un message de succès
        InAppNotificationService.showSuccess(
          context,
          message: successMessage.isNotEmpty
              ? successMessage
              : l10n.notificationSuccessMessage,
        );

        // Retourner à l'écran précédent
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        InAppNotificationService.showError(
          context,
          message: '${l10n.notificationErrorMessage}: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAssigning = false;
        });
      }
    }
  }
}
