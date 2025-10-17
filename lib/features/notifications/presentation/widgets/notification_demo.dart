import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/features/notifications/domain/usecases/in_app_notification_service.dart';
import 'package:pocketly/features/notifications/presentation/widgets/notification_helper.dart';

/// Widget de démonstration pour tester les notifications adaptatives
class NotificationDemo extends StatelessWidget {
  const NotificationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démonstration des Notifications'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
            
                     // Test d'empilement visuel
                     _buildSection(
                       context,
                       'Test d\'empilement visuel',
                       [
                         _buildButton(
                           context,
                           'Empiler 3 notifications',
                           Icons.layers_rounded,
                           Colors.purple,
                           () {
                             InAppNotificationService.showSuccess(context, message: 'Notification 1');
                             InAppNotificationService.showError(context, message: 'Notification 2');
                             InAppNotificationService.showInfo(context, message: 'Notification 3');
                           },
                         ),
                         _buildButton(
                           context,
                           'Empiler 5 notifications',
                           Icons.queue_rounded,
                           Colors.indigo,
                           () {
                             for (int i = 1; i <= 5; i++) {
                               InAppNotificationService.showSuccess(
                                 context, 
                                 message: 'Notification empilée $i'
                               );
                             }
                           },
                         ),
                         _buildButton(
                           context,
                           'Empiler mixte',
                           Icons.auto_awesome_rounded,
                           Colors.teal,
                           () {
                             InAppNotificationService.showSuccess(context, message: 'Succès');
                             InAppNotificationService.showError(context, message: 'Erreur');
                             InAppNotificationService.showWarning(context, message: 'Attention');
                             InAppNotificationService.showInfo(context, message: 'Info');
                             InAppNotificationService.showLoading(context, message: 'Chargement...');
                           },
                         ),
                         _buildButton(
                           context,
                           'Réinitialiser empilement',
                           Icons.refresh_rounded,
                           Colors.grey,
                           () {
                             InAppNotificationService.resetStacking();
                             ScaffoldMessenger.of(context).showSnackBar(
                               const SnackBar(content: Text('Empilement réinitialisé')),
                             );
                           },
                         ),
                       ],
                     ),

                     const SizedBox(height: 24),

                     // Notifications de base
                     _buildSection(
                       context,
                       'Notifications de base',
                       [
                         _buildButton(
                           context,
                           'Succès',
                           Icons.check_circle_rounded,
                           Colors.green,
                           () => InAppNotificationService.showSuccess(context),
                         ),
                         _buildButton(
                           context,
                           'Erreur',
                           Icons.error_rounded,
                           Colors.red,
                           () => InAppNotificationService.showError(context),
                         ),
                         _buildButton(
                           context,
                           'Information',
                           Icons.info_rounded,
                           Colors.blue,
                           () => InAppNotificationService.showInfo(context),
                         ),
                         _buildButton(
                           context,
                           'Avertissement',
                           Icons.warning_rounded,
                           Colors.orange,
                           () => InAppNotificationService.showWarning(context),
                         ),
                       ],
                     ),
              
              const SizedBox(height: 24),
              
              // Notifications spécialisées
              _buildSection(
                context,
                'Notifications spécialisées',
                [
                  _buildButton(
                    context,
                    'Chargement',
                    Icons.hourglass_empty_rounded,
                    Colors.purple,
                    () => InAppNotificationService.showLoading(context),
                  ),
                  _buildButton(
                    context,
                    'Action requise',
                    Icons.touch_app_rounded,
                    Colors.indigo,
                    () => InAppNotificationService.showAction<bool>(
                      context,
                      onButtonPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Action effectuée !')),
                        );
                      },
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Notifications via helper
              _buildSection(
                context,
                'Notifications via Helper',
                [
                  _buildButton(
                    context,
                    'Permission accordée',
                    Icons.check_rounded,
                    Colors.green,
                    () => NotificationHelper.showPermissionSuccess(context),
                  ),
                  _buildButton(
                    context,
                    'Permission refusée',
                    Icons.close_rounded,
                    Colors.red,
                    () => NotificationHelper.showPermissionError(context),
                  ),
                  _buildButton(
                    context,
                    'Notification envoyée',
                    Icons.send_rounded,
                    Colors.blue,
                    () => NotificationHelper.showNotificationSent(context),
                  ),
                  _buildButton(
                    context,
                    'Notification programmée',
                    Icons.schedule_rounded,
                    Colors.orange,
                    () => NotificationHelper.showNotificationScheduled(context),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Information sur l'adaptation
              _buildInfoCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                Icons.notifications_active_rounded,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ).animate()
                .scale(duration: 600.ms, curve: Curves.elasticOut)
                .fadeIn(duration: 400.ms),
              const SizedBox(height: 16),
              Text(
                'Notifications Professionnelles',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ).animate()
                .slideY(begin: 0.3, end: 0, duration: 500.ms, curve: Curves.easeOut)
                .fadeIn(duration: 400.ms),
              const SizedBox(height: 8),
              Text(
                'Design moderne avec animations fluides',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ).animate()
                .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut)
                .fadeIn(duration: 500.ms),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ).animate()
          .slideX(begin: -0.2, end: 0, duration: 400.ms, curve: Curves.easeOut)
          .fadeIn(duration: 300.ms),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: children.map((child) => child.animate()
            .scale(duration: 300.ms, curve: Curves.easeOut)
            .fadeIn(duration: 200.ms)
          ).toList(),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.1),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate()
      .scale(duration: 200.ms, curve: Curves.easeOut)
      .fadeIn(duration: 300.ms);
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface,
            Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Adaptation automatique',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureItem(
            context,
            Icons.language_rounded,
            'Langue',
            'S\'adapte automatiquement à la langue de l\'appareil (FR/EN)',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            Icons.palette_rounded,
            'Thème',
            'Couleurs qui suivent le thème de l\'application (clair/sombre)',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            Icons.design_services_rounded,
            'Design',
            'Couleurs sémantiques Material Design 3 avec glassmorphism',
          ),
          const SizedBox(height: 12),
          _buildFeatureItem(
            context,
            Icons.animation_rounded,
            'Animations',
            'Transitions fluides avec flutter_animate',
          ),
        ],
      ),
    ).animate()
      .slideY(begin: 0.3, end: 0, duration: 600.ms, curve: Curves.easeOut)
      .fadeIn(duration: 500.ms);
  }

  Widget _buildFeatureItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
