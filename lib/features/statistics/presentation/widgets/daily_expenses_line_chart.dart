import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/features/locale/locale.dart';
import 'package:pocketly/features/statistics/domain/entities/chart_data_entity.dart';
import 'package:pocketly/features/statistics/domain/entities/daily_expense_entity.dart';
import 'package:pocketly/features/statistics/presentation/providers/statistics_providers.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';
import 'package:pocketly/features/currency/currency.dart';

/// Widget affichant le graphique en ligne des dépenses quotidiennes
class DailyExpensesLineChart extends ConsumerWidget {
  const DailyExpensesLineChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Écouter le changement de locale pour rebuild automatique
    ref.watch(currentLocaleProvider);

    final chartDataAsync = ref.watch(chartDataControllerProvider);
    final selectedDay = ref.watch(selectedDayProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return chartDataAsync.when(
      data: (chartData) {
        // Déterminer le nombre d'éléments à afficher selon la période
        final itemCount = chartData.period == TimePeriod.week
            ? 7
            : chartData.period == TimePeriod.month
                ? 6
                : 7; // year
        final dailyExpenses = chartData.dailyExpenses.take(itemCount).toList();
        final maxExpense = chartData.maxExpense;

        return SizedBox(
          height: 220,
          child: Column(
            children: [
              // Montants au-dessus du graphique
              SizedBox(
                height: 24,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dailyExpenses.map((dayExpense) {
                    final isToday = dayExpense.isToday;
                    final hasExpense = dayExpense.expense > 0;
                    final isSelected =
                        selectedDay != null &&
                        dayExpense.date.year == selectedDay.year &&
                        dayExpense.date.month == selectedDay.month &&
                        dayExpense.date.day == selectedDay.day;

                    return Expanded(
                      child: hasExpense
                          ? Center(
                              child: CurrencyDisplayWidget(
                                amount: dayExpense.expense,
                                style: AppTypography.small.copyWith(
                                  fontSize: 11,
                                  fontWeight: isSelected || isToday
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  color: isSelected
                                      ? AppColors.getDayColor(
                                          dayExpense.dayOfWeek,
                                        )
                                      : isToday
                                      ? AppColors.getDayColor(
                                          dayExpense.dayOfWeek,
                                        )
                                      : (isDark
                                                ? AppColors.textSecondaryOnDark
                                                : AppColors.textSecondary)
                                            .withValues(alpha: 0.7),
                                ),
                                decimals: 0,
                              ),
                            )
                          : const SizedBox.shrink(),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: AppDimensions.paddingXS),

              // Graphique avec CustomPaint
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                  ),
                  child: _LineChartPainter(
                    dailyExpenses: dailyExpenses,
                    maxExpense: maxExpense,
                    selectedDay: selectedDay,
                    isDark: isDark,
                    onDayTap: (dayExpense) {
                      HapticFeedback.lightImpact();
                      // Si déjà sélectionné, désélectionner
                      final isSelected =
                          selectedDay != null &&
                          dayExpense.date.year == selectedDay.year &&
                          dayExpense.date.month == selectedDay.month &&
                          dayExpense.date.day == selectedDay.day;

                      if (isSelected) {
                        ref.read(selectedDayProvider.notifier).clearSelection();
                      } else {
                        ref
                            .read(selectedDayProvider.notifier)
                            .selectDay(dayExpense.date);
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.paddingS),

              // Labels des jours
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingS,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: dailyExpenses.map((dayExpense) {
                    final isToday = dayExpense.isToday;
                    final isSelected =
                        selectedDay != null &&
                        dayExpense.date.year == selectedDay.year &&
                        dayExpense.date.month == selectedDay.month &&
                        dayExpense.date.day == selectedDay.day;

                    return Expanded(
                      child: Center(
                        child: Text(
                          _getPeriodLabel(
                            chartData.period,
                            dayExpense.date,
                            dayExpense.dayOfWeek,
                            l10n,
                          ),
                          style: AppTypography.small.copyWith(
                            fontSize: chartData.period == TimePeriod.year ? 9 : 10,
                            fontWeight: isSelected || isToday
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? AppColors.getDayColor(dayExpense.dayOfWeek)
                                : isToday
                                ? AppColors.getDayColor(dayExpense.dayOfWeek)
                                : (isDark
                                          ? AppColors.textSecondaryOnDark
                                          : AppColors.textSecondary)
                                      .withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox(height: 200),
      error: (error, stack) => const SizedBox(height: 200),
    );
  }

  /// Retourne le label approprié selon la période
  String _getPeriodLabel(
    TimePeriod period,
    DateTime date,
    int dayOfWeek,
    AppLocalizations l10n,
  ) {
    return switch (period) {
      TimePeriod.week => _getDayName(dayOfWeek, l10n),
      TimePeriod.month => _getMonthName(date.month, l10n),
      TimePeriod.year => date.year.toString(),
    };
  }
  
  /// Retourne le nom court du jour traduit
  String _getDayName(int dayOfWeek, AppLocalizations l10n) {
    switch (dayOfWeek) {
      case 1:
        return l10n.monday;
      case 2:
        return l10n.tuesday;
      case 3:
        return l10n.wednesday;
      case 4:
        return l10n.thursday;
      case 5:
        return l10n.friday;
      case 6:
        return l10n.saturday;
      case 7:
        return l10n.sunday;
      default:
        return '';
    }
  }
  
  /// Retourne le nom court du mois (3 lettres)
  String _getMonthName(int month, AppLocalizations l10n) {
    const monthNames = [
      'Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin',
      'Juil', 'Août', 'Sep', 'Oct', 'Nov', 'Déc'
    ];
    return monthNames[month - 1];
  }
}

/// Widget personnalisé pour dessiner le graphique en ligne
class _LineChartPainter extends StatelessWidget {
  final List<DailyExpenseEntity> dailyExpenses;
  final double maxExpense;
  final DateTime? selectedDay;
  final bool isDark;
  final Function(DailyExpenseEntity) onDayTap;

  const _LineChartPainter({
    required this.dailyExpenses,
    required this.maxExpense,
    required this.selectedDay,
    required this.isDark,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final points = _calculatePoints(width, height);

        return Stack(
          children: [
            // Grille de fond
            CustomPaint(
              size: Size(width, height),
              painter: _GridPainter(isDark: isDark),
            ),

            // Ligne et points
            CustomPaint(
              size: Size(width, height),
              painter: _LinePainter(
                points: points,
                dailyExpenses: dailyExpenses,
                selectedDay: selectedDay,
                isDark: isDark,
              ),
            ),

            // Zones tactiles pour chaque point
            ...points.asMap().entries.map((entry) {
              final index = entry.key;
              final point = entry.value;
              final dayExpense = dailyExpenses[index];
              final isToday = dayExpense.isToday;
              final hasExpense = dayExpense.expense > 0;
              final isSelected =
                  selectedDay != null &&
                  dayExpense.date.year == selectedDay!.year &&
                  dayExpense.date.month == selectedDay!.month &&
                  dayExpense.date.day == selectedDay!.day;

              return Positioned(
                left: point.dx - 20,
                top: point.dy - 20,
                child: GestureDetector(
                  onTap: () => onDayTap(dayExpense),
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.transparent,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Point
                        Container(
                          width: isSelected || isToday ? 12 : 8,
                          height: isSelected || isToday ? 12 : 8,
                          decoration: BoxDecoration(
                            color: hasExpense
                                ? AppColors.getDayColor(dayExpense.dayOfWeek)
                                : (isDark
                                          ? AppColors.textSecondaryOnDark
                                          : AppColors.textSecondary)
                                      .withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected || isToday
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2,
                            ),
                            boxShadow: [
                              if (isSelected || isToday)
                                BoxShadow(
                                  color: AppColors.getDayColor(
                                    dayExpense.dayOfWeek,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  /// Calcule les coordonnées des points du graphique
  List<Offset> _calculatePoints(double width, double height) {
    if (dailyExpenses.isEmpty) return [];

    // Calculer la largeur de chaque colonne pour centrer les points
    final columnWidth = width / dailyExpenses.length;
    final paddingTop = 30.0; // Espace pour les montants au-dessus
    final availableHeight = height - paddingTop - 10;

    return dailyExpenses.asMap().entries.map((entry) {
      final index = entry.key;
      final expense = entry.value.expense;

      // Centrer le point dans chaque colonne
      final x = (index * columnWidth) + (columnWidth / 2);
      final y = maxExpense > 0
          ? paddingTop + (availableHeight * (1 - (expense / maxExpense)))
          : height - 10;

      return Offset(x, y);
    }).toList();
  }
}

/// Painter pour la grille de fond
class _GridPainter extends CustomPainter {
  final bool isDark;

  _GridPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary)
              .withValues(alpha: 0.1)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Lignes horizontales (3 lignes)
    for (int i = 1; i <= 3; i++) {
      final y = (size.height / 4) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}

/// Painter pour la ligne et le gradient
class _LinePainter extends CustomPainter {
  final List<Offset> points;
  final List<DailyExpenseEntity> dailyExpenses;
  final DateTime? selectedDay;
  final bool isDark;

  _LinePainter({
    required this.points,
    required this.dailyExpenses,
    required this.selectedDay,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty || points.length < 2) return;

    // Dessiner le gradient sous la ligne
    _drawGradient(canvas, size);

    // Dessiner la ligne principale
    _drawLine(canvas);
  }

  void _drawGradient(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(points.first.dx, size.height);
    path.lineTo(points.first.dx, points.first.dy);

    // Créer une courbe lisse entre les points
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint = Offset(
        (current.dx + next.dx) / 2,
        (current.dy + next.dy) / 2,
      );
      path.quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        next.dx,
        next.dy,
      );
    }

    path.lineTo(points.last.dx, size.height);
    path.close();

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primary.withValues(alpha: 0.2),
          AppColors.primary.withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, gradientPaint);
  }

  void _drawLine(Canvas canvas) {
    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    // Créer une courbe lisse entre les points
    for (int i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint = Offset(
        (current.dx + next.dx) / 2,
        (current.dy + next.dy) / 2,
      );
      path.quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        next.dx,
        next.dy,
      );
    }

    // Dessiner la ligne avec gradient de couleur
    final linePaint = Paint()
      ..shader = LinearGradient(
        colors: [AppColors.primary, AppColors.secondary],
      ).createShader(Rect.fromPoints(points.first, points.last))
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.selectedDay != selectedDay ||
        oldDelegate.isDark != isDark;
  }
}
