import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocketly/core/errors/errors.dart';
import 'package:pocketly/features/notifications/domain/entities/notification_entity.dart';
import 'package:pocketly/features/notifications/presentation/providers/notification_providers.dart';
import 'package:pocketly/features/notifications/presentation/widgets/notification_helper.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Screen for notification settings
class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Utiliser ! pour s'assurer que AppLocalizations n'est pas null
    final s = AppLocalizations.of(context)!;
    final permissionState = ref.watch(notificationPermissionStateProvider);
    
    // Determine if we're on iOS
    final bool isIOS = Platform.isIOS;
    
    return isIOS
        ? _buildIOSScreen(context, ref, s, permissionState)
        : _buildAndroidScreen(context, ref, s, permissionState);
  }
  
  /// Build iOS screen with Cupertino widgets
  Widget _buildIOSScreen(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations s,
    AsyncValue<bool> permissionState,
  ) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(s.notificationSettings),
      ),
      child: SafeArea(
        child: _buildContent(context, ref, s, permissionState),
      ),
    );
  }
  
  /// Build Android screen with Material widgets
  Widget _buildAndroidScreen(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations s,
    AsyncValue<bool> permissionState,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(s.notificationSettings),
      ),
      body: _buildContent(context, ref, s, permissionState),
    );
  }
  
  /// Build the content of the screen
  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations s,
    AsyncValue<bool> permissionState,
  ) {
    return permissionState.when(
      data: (hasPermission) {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildPermissionSection(context, ref, s, hasPermission),
            const SizedBox(height: 24),
            _buildTestNotificationSection(context, ref, s, hasPermission),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) {
        final appError = ErrorHandler.handleError(error, stackTrace);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                ErrorLocalization.getErrorIcon(appError),
                size: 48,
                color: ErrorLocalization.getErrorColor(appError, context),
              ),
              const SizedBox(height: 16),
              Text(
                ErrorLocalization.getLocalizedErrorTitle(appError, context),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                ErrorLocalization.getLocalizedUserMessage(appError, context),
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
  
  /// Build the permission section
  Widget _buildPermissionSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations s,
    bool hasPermission,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              s.notificationPermissionTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(s.notificationPermissionMessage),
            const SizedBox(height: 16),
            if (hasPermission)
              _buildStatusIndicator(
                context,
                s.notificationPermissionTitle,
                true,
              )
            else
              _buildRequestPermissionButton(context, ref, s),
          ],
        ),
      ),
    );
  }
  
  /// Build the test notification section
  Widget _buildTestNotificationSection(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations s,
    bool hasPermission,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Notifications',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (!hasPermission) ...[
              const SizedBox(height: 8),
              Text(
                '⚠️ Permissions requises pour tester les notifications',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.orange,
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildTestButton(
              context,
              ref,
              'Send Immediate Notification',
              _sendImmediateNotification,
            ),
            const SizedBox(height: 8),
            _buildTestButton(
              context,
              ref,
              'Schedule Notification (5 seconds)',
              _scheduleNotification,
            ),
            const SizedBox(height: 8),
            _buildTestButton(
              context,
              ref,
              'Cancel All Notifications',
              _cancelAllNotifications,
            ),
          ],
        ),
      ),
    );
  }
  
  /// Build a status indicator
  Widget _buildStatusIndicator(
    BuildContext context,
    String label,
    bool isEnabled,
  ) {
    return Row(
      children: [
        Icon(
          isEnabled ? Icons.check_circle : Icons.cancel,
          color: isEnabled ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(
          isEnabled ? 'Enabled' : 'Disabled',
          style: TextStyle(
            color: isEnabled ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  /// Build a request permission button
  Widget _buildRequestPermissionButton(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations s,
  ) {
    return Platform.isIOS
        ? CupertinoButton.filled(
            onPressed: () => _requestPermission(context, ref),
            child: Text(s.enableNotifications),
          )
        : ElevatedButton(
            onPressed: () => _requestPermission(context, ref),
            child: Text(s.enableNotifications),
          );
  }
  
  /// Build a test button
  Widget _buildTestButton(
    BuildContext context,
    WidgetRef ref,
    String label,
    Future<void> Function(BuildContext, WidgetRef) onPressed,
  ) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => onPressed(context, ref),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(label),
            ),
          )
        : ElevatedButton(
            onPressed: () => onPressed(context, ref),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(label),
            ),
          );
  }
  
  /// Request notification permission
  Future<void> _requestPermission(BuildContext context, WidgetRef ref) async {
    try {
      final notificationService = ref.read(notificationServiceUseCaseProvider);
      final result = await notificationService.requestPermissions();
      
      if (context.mounted) {
        if (result) {
          ref.invalidate(notificationPermissionStateProvider);
          NotificationHelper.showPermissionSuccess(context);
        } else {
          NotificationHelper.showPermissionError(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showSnackBar(context, 'Erreur: ${e.toString()}', Colors.red);
      }
    }
  }
  
  /// Helper method to show snackbar safely
  void _showSnackBar(BuildContext context, String message, Color color) {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color,
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      debugPrint('Error showing snackbar: $e');
    }
  }
  
  /// Send an immediate notification
  Future<void> _sendImmediateNotification(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final s = AppLocalizations.of(context)!;
    final notificationService = ref.read(notificationServiceUseCaseProvider);
    
    final notification = NotificationEntity(
      id: 1,
      title: s.reminderNotification,
      body: 'This is a test notification',
      payload: 'test_notification',
    );
    
    await notificationService.showNotification(notification);
  }
  
  /// Schedule a notification
  Future<void> _scheduleNotification(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final s = AppLocalizations.of(context)!;
    final notificationService = ref.read(notificationServiceUseCaseProvider);
    
    final notification = NotificationEntity(
      id: 2,
      title: s.reminderNotification,
      body: 'This is a scheduled test notification',
      payload: 'scheduled_test_notification',
      scheduledDate: DateTime.now().add(const Duration(seconds: 5)),
    );
    
    final result = await notificationService.scheduleNotification(notification);
    
    if (context.mounted) {
      if (result) {
        NotificationHelper.showNotificationScheduled(context);
      } else {
        NotificationHelper.showGenericError(context, s.notificationScheduleError);
      }
    }
  }
  
  /// Cancel all notifications
  Future<void> _cancelAllNotifications(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final s = AppLocalizations.of(context)!;
    final notificationService = ref.read(notificationServiceUseCaseProvider);
    
    final result = await notificationService.cancelAllNotifications();
    
    if (context.mounted) {
      if (result) {
        NotificationHelper.showNotificationCancelled(context);
      } else {
        NotificationHelper.showGenericError(context, s.notificationCancelError);
      }
    }
  }
}