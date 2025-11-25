import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_icons.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/features/transaction_history/presentation/providers/transaction_history_providers.dart';
import 'package:pocketly/features/transaction_history/presentation/widgets/calendar_day_widget.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:pocketly/features/transactions/transactions.dart';

/// Widget pour afficher un calendrier interactif avec navigation mensuelle
class InteractiveCalendar extends ConsumerStatefulWidget {
  const InteractiveCalendar({super.key});

  @override
  ConsumerState<InteractiveCalendar> createState() =>
      _InteractiveCalendarState();
}

class _InteractiveCalendarState extends ConsumerState<InteractiveCalendar> {
  // Clé pour suivre la direction de l'animation
  int _previousMonthKey = 0;
  int _slideDirection = 0; // -1 = gauche, 1 = droite, 0 = initial

  @override
  void initState() {
    super.initState();
    // Charger les données du calendrier au démarrage
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final calendarState = ref.read(calendarControllerProvider);
      _previousMonthKey = calendarState.year * 12 + calendarState.month;
      ref.read(calendarControllerProvider.notifier).loadCalendarData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarState = ref.watch(calendarControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Détecter le changement de mois pour déterminer la direction de l'animation
    final currentMonthKey = calendarState.year * 12 + calendarState.month;
    if (currentMonthKey != _previousMonthKey && _previousMonthKey != 0) {
      // Si la direction n'a pas été définie manuellement, la calculer automatiquement
      // (utile pour goToToday ou autres changements de mois non gérés par les boutons)
      if (_slideDirection == 0) {
        // Mois suivant (futur) = slide gauche (-1), Mois précédent (passé) = slide droite (1)
        _slideDirection = currentMonthKey > _previousMonthKey ? -1 : 1;
      }
      _previousMonthKey = currentMonthKey;
      // Réinitialiser la direction après l'animation pour permettre la détection automatique
      // au prochain changement (si pas défini par les boutons)
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _slideDirection = 0;
          });
        }
      });
    }

    // Recharger le calendrier quand les transactions changent
    ref.listen(transactionProvider, (previous, next) {
      // Recharger uniquement si les transactions ont changé (pas en cas de loading)
      if (previous != null &&
          previous.allTransactions.length != next.allTransactions.length) {
        ref.read(calendarControllerProvider.notifier).loadCalendarData();
      }
    });

    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        children: [
          // Navigation mensuelle
          _buildMonthNavigation(context, calendarState, isDark),

          SizedBox(height: AppDimensions.paddingM),

          // En-têtes des jours de la semaine
          _buildWeekDayHeaders(context, isDark),

          SizedBox(height: AppDimensions.paddingS),

          // Grille du calendrier avec animation
          ClipRect(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return _SlideTransition(
                  animation: animation,
                  direction: _slideDirection,
                  child: child,
                );
              },
              child: _buildCalendarContent(calendarState, isDark),
            ),
          ),
        ],
      ),
    );
  }

  /// Construit le contenu du calendrier avec une clé unique pour l'animation
  Widget _buildCalendarContent(CalendarState calendarState, bool isDark) {
    final key = ValueKey('${calendarState.year}-${calendarState.month}');

    Widget content;
    if (calendarState.isLoading) {
      content = _buildLoading();
    } else if (calendarState.error != null) {
      content = _buildError(calendarState.error!, isDark);
    } else {
      content = _buildCalendarGrid(calendarState.days);
    }

    return KeyedSubtree(key: key, child: content);
  }

  /// Formate le label d'un jour
  String _formatDayLabel(BuildContext context, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return l10n.today;
    } else if (dateOnly == yesterday) {
      return l10n.yesterday;
    } else {
      final formatted = DateFormat(
        'EEEE dd MMMM',
        locale.toString(),
      ).format(date);
      return _capitalizeMonthInFrench(formatted, locale);
    }
  }

  /// Capitalise le mois dans une chaîne formatée si la locale est française
  String _capitalizeMonthInFrench(String formatted, Locale locale) {
    if (locale.languageCode != 'fr') return formatted;

    // Trouver le mois dans la chaîne et le capitaliser
    // Format attendu: "lundi 15 novembre" (EEEE dd MMMM)
    final parts = formatted.split(' ');
    if (parts.length >= 3) {
      // Le mois est le dernier élément pour "EEEE dd MMMM"
      final monthIndex = parts.length - 1;
      if (monthIndex >= 0 &&
          monthIndex < parts.length &&
          parts[monthIndex].isNotEmpty) {
        parts[monthIndex] =
            parts[monthIndex][0].toUpperCase() + parts[monthIndex].substring(1);
        return parts.join(' ');
      }
    }
    return formatted;
  }

  /// Construit la navigation mensuelle
  Widget _buildMonthNavigation(
    BuildContext context,
    CalendarState calendarState,
    bool isDark,
  ) {
    final locale = Localizations.localeOf(context);
    final monthNameRaw = DateFormat.yMMMM(
      locale.toString(),
    ).format(DateTime(calendarState.year, calendarState.month));
    // Capitaliser le premier caractère du mois en français
    final monthName = locale.languageCode == 'fr' && monthNameRaw.isNotEmpty
        ? monthNameRaw[0].toUpperCase() + monthNameRaw.substring(1)
        : monthNameRaw;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Bouton mois précédent
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            // Définir la direction avant le changement
            final currentKey = calendarState.year * 12 + calendarState.month;
            _previousMonthKey = currentKey;
            _slideDirection = 1; // Nouveau mois entre par la droite
            ref.read(calendarControllerProvider.notifier).previousMonth();
          },
          icon: Icon(
            AppIcons.chevronLeft,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ).animate().fadeIn(duration: 300.ms),

        // Nom du mois et année
        Expanded(
          child: GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              ref.read(calendarControllerProvider.notifier).goToToday();
            },
            child: Text(
              monthName,
              textAlign: TextAlign.center,
              style: AppTypography.heading.copyWith(
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ).animate().fadeIn(duration: 300.ms),

        // Bouton mois suivant
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            // Définir la direction avant le changement
            final currentKey = calendarState.year * 12 + calendarState.month;
            _previousMonthKey = currentKey;
            _slideDirection = -1; // Nouveau mois entre par la gauche
            ref.read(calendarControllerProvider.notifier).nextMonth();
          },
          icon: Icon(
            AppIcons.chevronRight,
            color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
          ),
        ).animate().fadeIn(duration: 300.ms),
      ],
    );
  }

  /// Construit les en-têtes des jours de la semaine
  Widget _buildWeekDayHeaders(BuildContext context, bool isDark) {
    final l10n = AppLocalizations.of(context)!;
    final weekDays = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: weekDays.map((day) {
        return Expanded(
          child: Center(
            child: Text(
              day,
              style: AppTypography.caption.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Construit la grille du calendrier
  Widget _buildCalendarGrid(List<dynamic> days) {
    if (days.isEmpty) {
      return const SizedBox.shrink();
    }

    // Récupérer le premier jour du mois pour calculer le décalage
    final calendarState = ref.read(calendarControllerProvider);
    final firstDayOfMonth = DateTime(
      calendarState.year,
      calendarState.month,
      1,
    );

    // Calculer le décalage (lundi = 1, dimanche = 7)
    int offset = firstDayOfMonth.weekday - 1; // Lundi = 0, Dimanche = 6

    // Créer une liste avec les espaces vides au début
    final totalCells = offset + days.length;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rows, (rowIndex) {
        return Padding(
          padding: EdgeInsets.only(bottom: AppDimensions.paddingXS),
          child: Row(
            children: List.generate(7, (colIndex) {
              final cellIndex = rowIndex * 7 + colIndex;
              final dayIndex = cellIndex - offset;

              // Cellule vide avant le début du mois
              if (cellIndex < offset || dayIndex >= days.length) {
                return Expanded(child: SizedBox(height: 52));
              }

              final day = days[dayIndex];

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  child: SizedBox(
                    height: 52,
                    child: CalendarDayWidget(
                      day: day,
                      onTap: () {
                        // Sélectionner le jour dans le calendrier
                        ref
                            .read(calendarControllerProvider.notifier)
                            .selectDay(day.date);

                        // Changer la période pour afficher ce jour spécifique
                        final startOfDay = DateTime(
                          day.date.year,
                          day.date.month,
                          day.date.day,
                        );
                        final endOfDay = DateTime(
                          day.date.year,
                          day.date.month,
                          day.date.day,
                          23,
                          59,
                          59,
                        );
                        ref
                            .read(periodFilterControllerProvider.notifier)
                            .selectCustomPeriod(
                              startDate: startOfDay,
                              endDate: endOfDay,
                              label: _formatDayLabel(context, day.date),
                            );
                      },
                    ),
                  ),
                ),
              );
            }),
          ).animate().fadeIn(delay: (rowIndex * 50).ms, duration: 300.ms),
        );
      }),
    );
  }

  /// Construit l'indicateur de chargement
  Widget _buildLoading() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: const CircularProgressIndicator(),
      ),
    );
  }

  /// Construit l'affichage d'erreur
  Widget _buildError(String error, bool isDark) {
    return AppCard(
      padding: EdgeInsets.all(AppDimensions.paddingL),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            AppIcons.error,
            size: AppDimensions.iconXXL,
            color: AppColors.error,
          ),
          SizedBox(height: AppDimensions.paddingM),
          Text(
            'Erreur de chargement',
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimensions.paddingS),
          Text(
            error,
            style: AppTypography.caption.copyWith(
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppDimensions.paddingM),
          TextButton(
            onPressed: () {
              ref.read(calendarControllerProvider.notifier).loadCalendarData();
            },
            child: Text(
              'Réessayer',
              style: AppTypography.body.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget personnalisé pour l'animation de slide
class _SlideTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final int direction; // -1 = slide gauche, 1 = slide droite

  const _SlideTransition({
    required this.child,
    required this.animation,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    // Créer une animation pour le slide horizontal
    // direction = 1 : nouveau mois entre par la gauche (commence à Offset(-1, 0))
    // direction = -1 : nouveau mois entre par la droite (commence à Offset(1, 0))
    final offsetAnimation = Tween<Offset>(
      begin: Offset(direction.toDouble(), 0.0), // Commence hors écran
      end: Offset.zero, // Se termine à la position normale
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

    // Animation de fade pour un effet plus fluide
    final fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: child),
    );
  }
}
