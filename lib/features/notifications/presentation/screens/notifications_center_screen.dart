import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:pocketly/features/notifications/presentation/providers/app_notifications_provider.dart';
import 'package:pocketly/features/notifications/domain/usecases/in_app_notification_service.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Filtres pour les notifications
enum NotificationFilter {
  all,
  unread,
  read;

  String getName(AppLocalizations l10n) {
    return switch (this) {
      NotificationFilter.all => l10n.allNotifications,
      NotificationFilter.unread => l10n.unreadNotifications,
      NotificationFilter.read => l10n.readNotifications,
    };
  }
}

/// Centre de notifications moderne
class NotificationsCenterScreen extends ConsumerStatefulWidget {
  const NotificationsCenterScreen({super.key});

  @override
  ConsumerState<NotificationsCenterScreen> createState() =>
      _NotificationsCenterScreenState();
}

class _NotificationsCenterScreenState
    extends ConsumerState<NotificationsCenterScreen> {
  final ScrollController _scrollController = ScrollController();
  NotificationFilter _selectedFilter = NotificationFilter.all;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(appNotificationsProvider);
                await ref.read(appNotificationsProvider.future);
              },
              child: _buildBody(l10n, isDark),
            ),

            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.notificationsCenter,
                scrollController: _scrollController,
                showBackButton: true,
                actionButton: _buildMarkAllReadButton(l10n, isDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMarkAllReadButton(AppLocalizations l10n, bool isDark) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surface,
        shape: BoxShape.circle,
        border: Border.all(
          color: isDark
              ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
              : AppColors.textSecondary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: () async {
          await ref.read(appNotificationsProvider.notifier).markAllAsRead();
          if (context.mounted) {
            InAppNotificationService.showSuccess(
              context,
              message: l10n.markAllAsRead,
            );
          }
        },
        icon: Icon(
          Platform.isIOS ? CupertinoIcons.checkmark_alt : Icons.done_all,
          color: AppColors.primary,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildBody(AppLocalizations l10n, bool isDark) {
    final notificationsAsync = ref.watch(appNotificationsProvider);

    return notificationsAsync.when(
      data: (notifications) {
        if (notifications.isEmpty) {
          return SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.only(top: 80),
            child: _buildEmptyState(l10n, isDark),
          );
        }

        return _buildNotificationsList(l10n, isDark, notifications);
      },
      loading: () => SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 80),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stack) => SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(top: 80),
        child: ErrorDisplay(
          error: error is AppError
              ? error
              : UnknownError(
                  technicalMessage: error.toString(),
                  stackTrace: stack,
                ),
          onRetry: () {
            ref.invalidate(appNotificationsProvider);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationsList(
    AppLocalizations l10n,
    bool isDark,
    List<AppNotificationEntity> allNotifications,
  ) {
    // Filtrer les notifications selon le filtre sélectionné
    final filteredNotifications = _filterNotifications(allNotifications);

    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.only(
        top: 80 + AppDimensions.paddingM,
        left: AppDimensions.paddingM,
        right: AppDimensions.paddingM,
        bottom: AppDimensions.paddingM,
      ),
      children: [
        // Filtres
        _buildFilters(l10n, isDark, allNotifications),

        SizedBox(height: AppDimensions.paddingM),

        // Liste des notifications
        if (filteredNotifications.isEmpty)
          _buildEmptyFilterState(l10n, isDark)
        else
          ...filteredNotifications.map((notification) {
            return Padding(
              padding: EdgeInsets.only(bottom: AppDimensions.paddingM),
              child: _buildNotificationCard(l10n, isDark, notification),
            );
          }),
      ],
    );
  }

  List<AppNotificationEntity> _filterNotifications(
    List<AppNotificationEntity> notifications,
  ) {
    return switch (_selectedFilter) {
      NotificationFilter.all => notifications,
      NotificationFilter.unread => notifications.where((n) => !n.isRead).toList(),
      NotificationFilter.read => notifications.where((n) => n.isRead).toList(),
    };
  }

  Widget _buildFilters(
    AppLocalizations l10n,
    bool isDark,
    List<AppNotificationEntity> allNotifications,
  ) {
    final unreadCount = allNotifications.where((n) => !n.isRead).length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: NotificationFilter.values.map((filter) {
          final isSelected = _selectedFilter == filter;
          final count = switch (filter) {
            NotificationFilter.all => allNotifications.length,
            NotificationFilter.unread => unreadCount,
            NotificationFilter.read => allNotifications.length - unreadCount,
          };

          return Padding(
            padding: EdgeInsets.only(right: AppDimensions.paddingS),
            child: FilterChip(
              selected: isSelected,
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(filter.getName(l10n)),
                  if (count > 0) ...[
                    SizedBox(width: AppDimensions.paddingXS),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingXS,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.3)
                            : (isDark
                                    ? AppColors.surfaceDark
                                    : AppColors.surface)
                                .withValues(alpha: 0.5),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusS),
                      ),
                      child: Text(
                        '$count',
                        style: AppTypography.small.copyWith(
                          color: isSelected
                              ? Colors.white
                              : (isDark
                                  ? AppColors.textOnDark
                                  : AppColors.textPrimary),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                }
              },
              selectedColor: AppColors.primary,
              backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
              labelStyle: AppTypography.body.copyWith(
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildNotificationCard(
    AppLocalizations l10n,
    bool isDark,
    AppNotificationEntity notification,
  ) {
    return Slidable(
      key: ValueKey(notification.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => _handleToggleReadStatus(notification),
            backgroundColor: AppColors.info,
            foregroundColor: Colors.white,
            icon: notification.isRead
                ? (Platform.isIOS
                    ? CupertinoIcons.envelope_badge
                    : Icons.mark_email_unread)
                : (Platform.isIOS
                    ? CupertinoIcons.envelope_open
                    : Icons.mark_email_read),
            label: notification.isRead ? l10n.markAsUnread : l10n.markAsRead,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppDimensions.radiusM),
              bottomLeft: Radius.circular(AppDimensions.radiusM),
            ),
          ),
          SlidableAction(
            onPressed: (context) => _handleDelete(notification, l10n),
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            icon: Platform.isIOS ? CupertinoIcons.delete : Icons.delete,
            label: l10n.delete,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppDimensions.radiusM),
              bottomRight: Radius.circular(AppDimensions.radiusM),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => _handleTap(notification),
        child: AppCard(
          padding: EdgeInsets.all(AppDimensions.paddingM),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icône avec badge non lu
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppDimensions.paddingM),
                    decoration: BoxDecoration(
                      color: _getNotificationColor(notification.type)
                          .withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getNotificationIcon(notification.type),
                      color: _getNotificationColor(notification.type),
                      size: 24,
                    ),
                  ),
                  if (!notification.isRead)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                isDark ? AppColors.surfaceDark : AppColors.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),

              SizedBox(width: AppDimensions.paddingM),

              // Contenu
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: AppTypography.body.copyWith(
                              fontWeight: notification.isRead
                                  ? FontWeight.normal
                                  : FontWeight.bold,
                              color: isDark
                                  ? AppColors.textOnDark
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingS,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getNotificationColor(notification.type)
                                .withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppDimensions.radiusS),
                          ),
                          child: Text(
                            notification.type.getName(l10n),
                            style: AppTypography.small.copyWith(
                              color: _getNotificationColor(notification.type),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      notification.message,
                      style: AppTypography.small.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark
                            : AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: AppDimensions.paddingXS),
                    Text(
                      _formatDate(notification.createdAt, l10n),
                      style: AppTypography.small.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryOnDark.withValues(alpha: 0.6)
                            : AppColors.textSecondary.withValues(alpha: 0.6),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getNotificationColor(AppNotificationType type) {
    return switch (type) {
      AppNotificationType.budgetExceeded => AppColors.error,
      AppNotificationType.goalReached => AppColors.success,
      AppNotificationType.monthEndReminder => AppColors.warning,
      AppNotificationType.weeklySummary => AppColors.info,
      AppNotificationType.monthlyReport => AppColors.primary,
      AppNotificationType.general => AppColors.info,
    };
  }

  IconData _getNotificationIcon(AppNotificationType type) {
    if (Platform.isIOS) {
      return switch (type) {
        AppNotificationType.budgetExceeded => CupertinoIcons.exclamationmark_triangle,
        AppNotificationType.goalReached => CupertinoIcons.checkmark_seal,
        AppNotificationType.monthEndReminder => CupertinoIcons.calendar,
        AppNotificationType.weeklySummary => CupertinoIcons.chart_bar,
        AppNotificationType.monthlyReport => CupertinoIcons.doc_text,
        AppNotificationType.general => CupertinoIcons.bell,
      };
    }
    return switch (type) {
      AppNotificationType.budgetExceeded => Icons.trending_up,
      AppNotificationType.goalReached => Icons.emoji_events_outlined,
      AppNotificationType.monthEndReminder => Icons.calendar_today_outlined,
      AppNotificationType.weeklySummary => Icons.bar_chart_outlined,
      AppNotificationType.monthlyReport => Icons.assessment_outlined,
      AppNotificationType.general => Icons.notifications_outlined,
    };
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'À l\'instant';
    } else if (difference.inHours < 1) {
      return 'Il y a ${difference.inMinutes}min';
    } else if (difference.inDays < 1) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inDays == 1) {
      return l10n.yesterday;
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays}j';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  Future<void> _handleToggleReadStatus(AppNotificationEntity notification) async {
    if (notification.isRead) {
      await ref.read(appNotificationsProvider.notifier).markAsUnread(notification.id);
    } else {
      await ref.read(appNotificationsProvider.notifier).markAsRead(notification.id);
    }
  }

  Future<void> _handleDelete(
    AppNotificationEntity notification,
    AppLocalizations l10n,
  ) async {
    await ref.read(appNotificationsProvider.notifier).deleteNotification(notification.id);
    if (context.mounted) {
      InAppNotificationService.showSuccess(
        context,
        message: l10n.notificationDeletedSuccess,
      );
    }
  }

  Future<void> _handleTap(AppNotificationEntity notification) async {
    // Marquer comme lu si non lu
    if (!notification.isRead) {
      await ref.read(appNotificationsProvider.notifier).markAsRead(notification.id);
    }
    // TODO: Navigation vers l'entité liée si relatedEntityId existe
  }

  Widget _buildEmptyState(AppLocalizations l10n, bool isDark) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Platform.isIOS ? CupertinoIcons.bell_slash : Icons.notifications_off_outlined,
              size: 80,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              l10n.noNotifications,
              style: AppTypography.title.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppDimensions.paddingS),
            Text(
              l10n.noNotificationsMessage,
              style: AppTypography.body.copyWith(
                color: isDark
                    ? AppColors.textSecondaryOnDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyFilterState(AppLocalizations l10n, bool isDark) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingXL),
      child: Center(
        child: Text(
          l10n.noNotificationsMessage,
          style: AppTypography.body.copyWith(
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
