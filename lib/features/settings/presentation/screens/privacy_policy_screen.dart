import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Écran de la politique de confidentialité
class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
                    '1. Données Collectées',
                    '''Pocketly collecte les données suivantes :

**Données d'identification :**
• Adresse email (obligatoire)
• Nom d'utilisateur (optionnel)
• Photo de profil (optionnelle)

**Données financières :**
• Transactions financières (montant, date, catégorie, description)
• Catégories personnalisées
• Pockets (enveloppes budgétaires)
• Préférences de devise

**Données techniques :**
• Token de notification push (pour les notifications)
• Version de l'application
• Dates de création et modification

**Données d'abonnement :**
• Statut premium (gratuit/essai/premium)
• Dates d'abonnement
• Consentement marketing (optionnel)

Aucune donnée bancaire réelle (numéro de carte, IBAN, etc.) n'est collectée.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '2. Finalités du Traitement',
                    '''Vos données sont utilisées pour :

• Fournir les services de gestion financière personnelle
• Personnaliser votre expérience utilisateur
• Synchroniser vos données entre appareils
• Envoyer des notifications pertinentes (avec votre consentement)
• Gérer votre abonnement premium
• Améliorer l'application et corriger les bugs
• Assurer la sécurité et prévenir les fraudes

Nous ne vendons jamais vos données à des tiers.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '3. Base Légale (RGPD)',
                    '''Le traitement de vos données repose sur :

• Votre consentement (Art. 6.1.a RGPD)
• L'exécution du contrat de service (Art. 6.1.b RGPD)
• Nos intérêts légitimes (Art. 6.1.f RGPD) : amélioration du service, sécurité

Vous pouvez retirer votre consentement à tout moment dans les paramètres.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '4. Conservation des Données',
                    '''Durée de conservation :

• Compte actif : données conservées tant que le compte existe
• Après suppression du compte : suppression immédiate et définitive
• Données de facturation : 10 ans (obligation légale)
• Logs techniques : 12 mois maximum

Vous pouvez supprimer votre compte à tout moment depuis les paramètres.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '5. Vos Droits RGPD',
                    '''Conformément au RGPD, vous disposez des droits suivants :

• **Droit d'accès** : obtenir une copie de vos données
• **Droit de rectification** : corriger vos données inexactes
• **Droit à l'effacement** : supprimer votre compte et vos données
• **Droit à la portabilité** : exporter vos données
• **Droit d'opposition** : refuser certains traitements
• **Droit à la limitation** : limiter le traitement de vos données

Pour exercer vos droits : support@pocketly.app''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '6. Sécurité des Données',
                    '''Mesures de sécurité mises en œuvre :

• Chiffrement des données en transit (TLS/SSL)
• Authentification sécurisée (Supabase Auth)
• Hébergement sécurisé (Supabase - certifié ISO 27001)
• Sauvegardes automatiques quotidiennes
• Accès restreint aux données (RLS - Row Level Security)
• Surveillance des accès et des anomalies

Malgré ces mesures, aucune transmission de données sur Internet n'est totalement sécurisée.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '7. Partage des Données',
                    '''Vos données ne sont partagées qu'avec :

• **Supabase** (hébergement et base de données)
• **Apple/Google** (notifications push)

Aucun partage commercial ou marketing de vos données.
Aucun transfert hors Union Européenne sans garanties appropriées.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '8. Cookies et Technologies',
                    '''L'application utilise :

• Stockage local (cache) pour améliorer les performances
• Tokens d'authentification pour maintenir votre session
• Analytics anonymisés (optionnel, désactivable)

Aucun cookie de suivi tiers.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '9. Modifications',
                    '''Cette politique peut être modifiée pour refléter :

• Les évolutions réglementaires
• Les nouvelles fonctionnalités
• L'amélioration de la protection des données

Vous serez notifié de toute modification substantielle.

Dernière mise à jour : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    '10. Contact DPO',
                    '''Pour toute question concernant vos données personnelles :

Email : dpo@pocketly.app
Délai de réponse : 30 jours maximum (RGPD)

Vous avez également le droit de déposer une plainte auprès de la CNIL (France) ou de votre autorité de protection des données locale.''',
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
                title: l10n.privacyPolicy,
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
