import 'package:flutter/material.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/widgets/animated_page_header.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Écran des mentions légales
class LegalNoticeScreen extends StatefulWidget {
  const LegalNoticeScreen({super.key});

  @override
  State<LegalNoticeScreen> createState() => _LegalNoticeScreenState();
}

class _LegalNoticeScreenState extends State<LegalNoticeScreen> {
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
                    'Éditeur de l\'application',
                    '''Pocketly est une application mobile de gestion financière personnelle.

Développeur : Indépendant
Contact : support@pocketly.app
Version : 1.0.0''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    'Hébergement',
                    '''Les données de l'application sont hébergées par :

Supabase Inc.
970 Toa Payoh North
#07-04 Braddell House
Singapore 318992

Les serveurs sont situés en Europe pour garantir la conformité RGPD.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    'Propriété intellectuelle',
                    '''L'ensemble du contenu de cette application (textes, images, graphismes, logo, icônes, code source) est la propriété exclusive de Pocketly.

Toute reproduction, représentation, modification, publication ou adaptation de tout ou partie des éléments de l'application est strictement interdite sans autorisation préalable écrite.''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    'Contact',
                    '''Pour toute question concernant l'application ou vos données personnelles :

Email : support@pocketly.app
Délai de réponse : 48 heures ouvrées''',
                  ),
                  SizedBox(height: AppDimensions.paddingL),
                  _buildSection(
                    isDark,
                    'Mise à jour',
                    '''Dernière mise à jour : ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}

Les présentes mentions légales peuvent être modifiées à tout moment. Les utilisateurs seront informés de toute modification substantielle.''',
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
                title: l10n.legalNotice,
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
