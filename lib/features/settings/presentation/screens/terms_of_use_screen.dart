import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Écran des conditions générales d'utilisation
class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({super.key});

  @override
  State<TermsOfUseScreen> createState() => _TermsOfUseScreenState();
}

class _TermsOfUseScreenState extends State<TermsOfUseScreen> {
  final ScrollController _scrollController = ScrollController();

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
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: PlatformSafeArea(
        top: true,
        bottom: false,
        padding: EdgeInsets.only(top: AppDimensions.paddingS),
        child: Stack(
          children: [
            // Contenu scrollable
            SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.only(
                top: 80,
                left: AppDimensions.paddingL,
                right: AppDimensions.paddingL,
                bottom: AppDimensions.paddingXL,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    isDark,
                    '1. Acceptation des Conditions',
                    '''En utilisant l'application Pocketly, vous acceptez d'être lié par les présentes Conditions Générales d'Utilisation (CGU).

Si vous n'acceptez pas ces conditions, veuillez ne pas utiliser l'application.

Ces CGU constituent un contrat légal entre vous et Pocketly.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '2. Description du Service',
                    '''Pocketly est une application mobile de gestion financière personnelle qui permet de :

• Suivre ses revenus et dépenses
• Catégoriser ses transactions
• Créer des enveloppes budgétaires (pockets)
• Visualiser des statistiques financières
• Gérer plusieurs devises
• Synchroniser ses données entre appareils

Pocketly est un outil de gestion personnelle et ne constitue pas un service de conseil financier.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '3. Création de Compte',
                    '''Pour utiliser Pocketly, vous devez :

• Avoir au moins 16 ans
• Fournir une adresse email valide
• Créer un mot de passe sécurisé
• Accepter les présentes CGU et la Politique de Confidentialité

Vous êtes responsable de :
• La confidentialité de vos identifiants
• Toutes les activités effectuées avec votre compte
• La notification immédiate en cas d'utilisation non autorisée''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '4. Utilisation Acceptable',
                    '''Vous vous engagez à :

✅ Utiliser l'application de manière légale et conforme
✅ Fournir des informations exactes et à jour
✅ Respecter les droits de propriété intellectuelle
✅ Maintenir la confidentialité de votre compte

Il est strictement interdit de :

❌ Utiliser l'application à des fins illégales
❌ Tenter de pirater ou compromettre le service
❌ Collecter des données d'autres utilisateurs
❌ Créer plusieurs comptes pour contourner les limitations
❌ Utiliser des robots ou scripts automatisés
❌ Revendre ou transférer votre compte''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '5. Abonnement Premium',
                    '''L'abonnement premium offre :

• Catégories personnalisées illimitées
• Statistiques avancées
• Synchronisation multi-appareils
• Support prioritaire
• Fonctionnalités exclusives futures

**Essai gratuit :**
• Durée : 14 jours
• Un seul essai par utilisateur
• Annulation possible à tout moment

**Paiements :**
• Traités par Apple App Store ou Google Play Store
• Renouvellement automatique sauf annulation
• Remboursement selon les politiques Apple/Google''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '6. Propriété Intellectuelle',
                    '''Tous les droits de propriété intellectuelle sur l'application appartiennent à Pocketly :

• Code source et architecture
• Design et interface utilisateur
• Logo, marques et graphismes
• Documentation et contenus

Vous conservez la propriété de vos données personnelles.

Licence d'utilisation :
• Non exclusive et non transférable
• Limitée à un usage personnel
• Révocable en cas de violation des CGU''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '7. Données et Confidentialité',
                    '''Vos données personnelles :

• Vous appartiennent exclusivement
• Sont traitées conformément à notre Politique de Confidentialité
• Peuvent être exportées à tout moment
• Sont supprimées définitivement à la suppression du compte

Sécurité :
• Chiffrement des données
• Sauvegardes automatiques
• Conformité RGPD

Consultez notre Politique de Confidentialité pour plus de détails.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '8. Disponibilité du Service',
                    '''Nous nous efforçons d'assurer :

• Une disponibilité maximale du service
• Des sauvegardes régulières
• Des mises à jour de sécurité

Toutefois, nous ne garantissons pas :
• Une disponibilité 24/7 sans interruption
• L'absence totale de bugs ou d'erreurs
• La compatibilité avec tous les appareils

Maintenances programmées :
• Notification préalable si possible
• Durée minimale''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '9. Limitation de Responsabilité',
                    '''Pocketly est fourni "en l'état" sans garantie.

Nous ne sommes pas responsables :

• Des pertes financières dues à vos décisions
• Des erreurs de saisie dans vos transactions
• Des interruptions de service
• De la perte de données due à un problème technique
• Des dommages indirects ou consécutifs

Limite maximale de responsabilité : montant payé au cours des 12 derniers mois.

Pocketly n'est pas un conseiller financier.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '10. Résiliation',
                    '''Vous pouvez résilier à tout moment en :

• Supprimant votre compte depuis les paramètres
• Envoyant une demande à support@pocketly.app

Nous pouvons suspendre ou résilier votre compte en cas de :

• Violation des présentes CGU
• Activité frauduleuse ou illégale
• Non-paiement (abonnement premium)
• Inactivité prolongée (> 2 ans)

Effets de la résiliation :
• Suppression définitive de toutes vos données
• Perte d'accès immédiat au service
• Pas de remboursement des abonnements en cours''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '11. Modifications des CGU',
                    '''Nous nous réservons le droit de modifier ces CGU à tout moment.

En cas de modification :
• Notification dans l'application
• Email de notification (modifications substantielles)
• Délai de 30 jours avant application

Continuer à utiliser l'application après modification vaut acceptation des nouvelles conditions.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '12. Droit Applicable et Juridiction',
                    '''Les présentes CGU sont régies par le droit français.

En cas de litige :
• Tentative de résolution amiable (30 jours)
• Médiation possible
• Juridiction compétente : Tribunaux de Paris, France

Pour les consommateurs européens : droit de recours auprès de votre autorité locale de protection des consommateurs.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '13. Contact',
                    '''Pour toute question concernant ces CGU :

Email : support@pocketly.app
Réponse sous 48h ouvrées

Pour les réclamations :
Email : complaints@pocketly.app

Version : 1.0
Dernière mise à jour : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}''',
                  ),
                ],
              ),
            ),
            // Header sticky animé
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedPageHeader(
                title: l10n.termsOfUse,
                scrollController: _scrollController,
                showBackButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(bool isDark, String title, String content) {
    return AppCard(
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTypography.title.copyWith(
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppDimensions.paddingM),
            Text(
              content,
              style: AppTypography.small.copyWith(
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
