import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/widgets/app_text_field.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';
import 'package:pocketly/core/constants/app_typography.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Modèle représentant une icône avec son nom et son code
class IconItem {
  final IconData icon;
  final String name; // Nom en français
  final String nameEn; // Nom en anglais
  final String code;

  const IconItem({
    required this.icon,
    required this.name,
    required this.nameEn,
    required this.code,
  });

  /// Vérifie si l'icône correspond à la requête de recherche (français ou anglais)
  bool matchesSearch(String query) {
    final lowerQuery = query.toLowerCase();
    
    // Traductions spéciales pour les termes courants
    final translations = {
      'argent': ['money', 'wallet', 'coins', 'dollar', 'euro', 'savings', 'creditcard', 'portefeuille', 'pièces', 'carte'],
      'money': ['argent', 'portefeuille', 'pièces', 'dollar', 'euro', 'épargne', 'carte', 'wallet', 'coins', 'savings', 'creditcard'],
      'voiture': ['car'],
      'car': ['voiture'],
      'maison': ['house', 'home'],
      'house': ['maison'],
      'home': ['maison'],
    };
    
    // Vérifier les traductions spéciales
    if (translations.containsKey(lowerQuery)) {
      final synonyms = translations[lowerQuery]!;
      if (synonyms.any((syn) => 
          name.toLowerCase().contains(syn.toLowerCase()) ||
          nameEn.toLowerCase().contains(syn.toLowerCase()) ||
          code.toLowerCase().contains(syn.toLowerCase()))) {
        return true;
      }
    }
    
    // Recherche normale dans les deux langues
    return name.toLowerCase().contains(lowerQuery) ||
        nameEn.toLowerCase().contains(lowerQuery) ||
        code.toLowerCase().contains(lowerQuery);
  }
}

/// Widget pour sélectionner une icône pour un pocket
///
/// Affiche une grille d'icônes organisées par catégories avec recherche
class PocketIconPicker extends StatefulWidget {
  final String? selectedIcon;
  final ValueChanged<String> onIconSelected;

  const PocketIconPicker({
    super.key,
    this.selectedIcon,
    required this.onIconSelected,
  });

  @override
  State<PocketIconPicker> createState() => _PocketIconPickerState();
}

class _PocketIconPickerState extends State<PocketIconPicker> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Tous';

  // Catégories d'icônes
  static const Map<String, List<IconItem>> _iconCategories = {
    'Tous': [
      IconItem(icon: LucideIcons.wallet, name: 'Portefeuille', nameEn: 'Wallet', code: 'wallet'),
      IconItem(icon: LucideIcons.piggyBank, name: 'Épargne', nameEn: 'Savings', code: 'savings'),
      IconItem(icon: LucideIcons.creditCard, name: 'Carte bancaire', nameEn: 'Credit Card', code: 'creditCard'),
      IconItem(icon: LucideIcons.coins, name: 'Pièces', nameEn: 'Coins', code: 'coins'),
      IconItem(icon: LucideIcons.dollarSign, name: 'Dollar', nameEn: 'Dollar', code: 'dollar'),
      IconItem(icon: LucideIcons.dollarSign, name: 'Euro', nameEn: 'Euro', code: 'euro'),
      IconItem(icon: LucideIcons.utensils, name: 'Restaurant', nameEn: 'Restaurant', code: 'utensils'),
      IconItem(icon: LucideIcons.shoppingBag, name: 'Shopping', nameEn: 'Shopping', code: 'shoppingBag'),
      IconItem(icon: LucideIcons.car, name: 'Voiture', nameEn: 'Car', code: 'car'),
      IconItem(icon: LucideIcons.house, name: 'Maison', nameEn: 'House', code: 'house'),
      IconItem(icon: LucideIcons.plane, name: 'Voyage', nameEn: 'Travel', code: 'plane'),
      IconItem(icon: LucideIcons.heart, name: 'Santé', nameEn: 'Health', code: 'heart'),
      IconItem(icon: LucideIcons.graduationCap, name: 'Éducation', nameEn: 'Education', code: 'graduationCap'),
      IconItem(icon: LucideIcons.film, name: 'Cinéma', nameEn: 'Cinema', code: 'film'),
      IconItem(icon: LucideIcons.music, name: 'Musique', nameEn: 'Music', code: 'music'),
      IconItem(icon: LucideIcons.gamepad2, name: 'Jeux', nameEn: 'Games', code: 'gamepad'),
      IconItem(icon: LucideIcons.dumbbell, name: 'Sport', nameEn: 'Sport', code: 'dumbbell'),
      IconItem(icon: LucideIcons.gift, name: 'Cadeau', nameEn: 'Gift', code: 'gift'),
      IconItem(icon: LucideIcons.cake, name: 'Anniversaire', nameEn: 'Birthday', code: 'cake'),
      IconItem(icon: LucideIcons.coffee, name: 'Café', nameEn: 'Coffee', code: 'coffee'),
      IconItem(icon: LucideIcons.shoppingCart, name: 'Panier', nameEn: 'Cart', code: 'shoppingCart'),
      IconItem(icon: LucideIcons.receipt, name: 'Facture', nameEn: 'Bill', code: 'receipt'),
      IconItem(icon: LucideIcons.briefcase, name: 'Travail', nameEn: 'Work', code: 'briefcase'),
      IconItem(icon: LucideIcons.book, name: 'Livre', nameEn: 'Book', code: 'book'),
      IconItem(icon: LucideIcons.palette, name: 'Art', nameEn: 'Art', code: 'palette'),
      IconItem(icon: LucideIcons.camera, name: 'Photo', nameEn: 'Photo', code: 'camera'),
      IconItem(icon: LucideIcons.phone, name: 'Téléphone', nameEn: 'Phone', code: 'phone'),
      IconItem(icon: LucideIcons.wifi, name: 'Internet', nameEn: 'Internet', code: 'wifi'),
      IconItem(icon: LucideIcons.zap, name: 'Électricité', nameEn: 'Electricity', code: 'zap'),
      IconItem(icon: LucideIcons.droplet, name: 'Eau', nameEn: 'Water', code: 'droplet'),
      IconItem(icon: LucideIcons.flame, name: 'Gaz', nameEn: 'Gas', code: 'flame'),
      IconItem(icon: LucideIcons.bike, name: 'Vélo', nameEn: 'Bike', code: 'bike'),
      IconItem(icon: LucideIcons.tramFront, name: 'Train', nameEn: 'Train', code: 'train'),
      IconItem(icon: LucideIcons.bus, name: 'Bus', nameEn: 'Bus', code: 'bus'),
      IconItem(icon: LucideIcons.baby, name: 'Bébé', nameEn: 'Baby', code: 'baby'),
      IconItem(icon: LucideIcons.dog, name: 'Chien', nameEn: 'Dog', code: 'dog'),
      IconItem(icon: LucideIcons.cat, name: 'Chat', nameEn: 'Cat', code: 'cat'),
      IconItem(icon: LucideIcons.stethoscope, name: 'Médecin', nameEn: 'Doctor', code: 'stethoscope'),
      IconItem(icon: LucideIcons.pill, name: 'Médicament', nameEn: 'Medicine', code: 'pill'),
      IconItem(icon: LucideIcons.scissors, name: 'Coiffeur', nameEn: 'Hairdresser', code: 'scissors'),
      IconItem(icon: LucideIcons.shirt, name: 'Vêtement', nameEn: 'Clothing', code: 'shirt'),
      IconItem(icon: LucideIcons.footprints, name: 'Chaussures', nameEn: 'Shoes', code: 'footprints'),
      IconItem(icon: LucideIcons.watch, name: 'Montre', nameEn: 'Watch', code: 'watch'),
      IconItem(icon: LucideIcons.smartphone, name: 'Smartphone', nameEn: 'Smartphone', code: 'smartphone'),
      IconItem(icon: LucideIcons.laptop, name: 'Ordinateur', nameEn: 'Laptop', code: 'laptop'),
      IconItem(icon: LucideIcons.tv, name: 'TV', nameEn: 'TV', code: 'tv'),
      IconItem(icon: LucideIcons.headphones, name: 'Casque', nameEn: 'Headphones', code: 'headphones'),
      IconItem(icon: LucideIcons.leaf, name: 'Nature', nameEn: 'Nature', code: 'leaf'),
      IconItem(icon: LucideIcons.sun, name: 'Soleil', nameEn: 'Sun', code: 'sun'),
      IconItem(icon: LucideIcons.moon, name: 'Lune', nameEn: 'Moon', code: 'moon'),
      IconItem(icon: LucideIcons.star, name: 'Étoile', nameEn: 'Star', code: 'star'),
      IconItem(icon: LucideIcons.heartHandshake, name: 'Charité', nameEn: 'Charity', code: 'heartHandshake'),
      IconItem(icon: LucideIcons.trophy, name: 'Trophée', nameEn: 'Trophy', code: 'trophy'),
      IconItem(icon: LucideIcons.target, name: 'Cible', nameEn: 'Target', code: 'target'),
      IconItem(icon: LucideIcons.flag, name: 'Drapeau', nameEn: 'Flag', code: 'flag'),
      IconItem(icon: LucideIcons.crown, name: 'Premium', nameEn: 'Premium', code: 'crown'),
      IconItem(icon: LucideIcons.sparkles, name: 'Étincelles', nameEn: 'Sparkles', code: 'sparkles'),
      IconItem(icon: LucideIcons.rocket, name: 'Fusée', nameEn: 'Rocket', code: 'rocket'),
    ],
    'Finance': [
      IconItem(icon: LucideIcons.wallet, name: 'Portefeuille', nameEn: 'Wallet', code: 'wallet'),
      IconItem(icon: LucideIcons.piggyBank, name: 'Épargne', nameEn: 'Savings', code: 'savings'),
      IconItem(icon: LucideIcons.creditCard, name: 'Carte bancaire', nameEn: 'Credit Card', code: 'creditCard'),
      IconItem(icon: LucideIcons.coins, name: 'Pièces', nameEn: 'Coins', code: 'coins'),
      IconItem(icon: LucideIcons.dollarSign, name: 'Dollar', nameEn: 'Dollar', code: 'dollar'),
      IconItem(icon: LucideIcons.dollarSign, name: 'Euro', nameEn: 'Euro', code: 'euro'),
      IconItem(icon: LucideIcons.receipt, name: 'Facture', nameEn: 'Bill', code: 'receipt'),
      IconItem(icon: LucideIcons.chartPie, name: 'Graphique', nameEn: 'Chart', code: 'chartPie'),
      IconItem(icon: LucideIcons.trendingUp, name: 'Croissance', nameEn: 'Growth', code: 'trendingUp'),
      IconItem(icon: LucideIcons.trendingDown, name: 'Déclin', nameEn: 'Decline', code: 'trendingDown'),
    ],
    'Alimentation': [
      IconItem(icon: LucideIcons.utensils, name: 'Restaurant', nameEn: 'Restaurant', code: 'utensils'),
      IconItem(icon: LucideIcons.coffee, name: 'Café', nameEn: 'Coffee', code: 'coffee'),
      IconItem(icon: LucideIcons.cake, name: 'Gâteau', nameEn: 'Cake', code: 'cake'),
      IconItem(icon: LucideIcons.cookie, name: 'Biscuit', nameEn: 'Cookie', code: 'cookie'),
      IconItem(icon: LucideIcons.apple, name: 'Fruit', nameEn: 'Fruit', code: 'fruit'),
      IconItem(icon: LucideIcons.glassWater, name: 'Vin', nameEn: 'Wine', code: 'wine'),
      IconItem(icon: LucideIcons.glassWater, name: 'Bière', nameEn: 'Beer', code: 'beer'),
    ],
    'Transport': [
      IconItem(icon: LucideIcons.car, name: 'Voiture', nameEn: 'Car', code: 'car'),
      IconItem(icon: LucideIcons.bike, name: 'Vélo', nameEn: 'Bike', code: 'bike'),
      IconItem(icon: LucideIcons.tramFront, name: 'Train', nameEn: 'Train', code: 'train'),
      IconItem(icon: LucideIcons.bus, name: 'Bus', nameEn: 'Bus', code: 'bus'),
      IconItem(icon: LucideIcons.plane, name: 'Avion', nameEn: 'Plane', code: 'plane'),
      IconItem(icon: LucideIcons.ship, name: 'Bateau', nameEn: 'Ship', code: 'ship'),
      IconItem(icon: LucideIcons.droplet, name: 'Essence', nameEn: 'Fuel', code: 'fuel'),
    ],
    'Loisirs': [
      IconItem(icon: LucideIcons.film, name: 'Cinéma', nameEn: 'Cinema', code: 'film'),
      IconItem(icon: LucideIcons.music, name: 'Musique', nameEn: 'Music', code: 'music'),
      IconItem(icon: LucideIcons.gamepad2, name: 'Jeux', nameEn: 'Games', code: 'gamepad'),
      IconItem(icon: LucideIcons.dumbbell, name: 'Sport', nameEn: 'Sport', code: 'dumbbell'),
      IconItem(icon: LucideIcons.book, name: 'Livre', nameEn: 'Book', code: 'book'),
      IconItem(icon: LucideIcons.palette, name: 'Art', nameEn: 'Art', code: 'palette'),
      IconItem(icon: LucideIcons.camera, name: 'Photo', nameEn: 'Photo', code: 'camera'),
      IconItem(icon: LucideIcons.trophy, name: 'Trophée', nameEn: 'Trophy', code: 'trophy'),
    ],
    'Services': [
      IconItem(icon: LucideIcons.house, name: 'Maison', nameEn: 'House', code: 'house'),
      IconItem(icon: LucideIcons.wifi, name: 'Internet', nameEn: 'Internet', code: 'wifi'),
      IconItem(icon: LucideIcons.zap, name: 'Électricité', nameEn: 'Electricity', code: 'zap'),
      IconItem(icon: LucideIcons.droplet, name: 'Eau', nameEn: 'Water', code: 'droplet'),
      IconItem(icon: LucideIcons.flame, name: 'Gaz', nameEn: 'Gas', code: 'flame'),
      IconItem(icon: LucideIcons.phone, name: 'Téléphone', nameEn: 'Phone', code: 'phone'),
      IconItem(icon: LucideIcons.scissors, name: 'Coiffeur', nameEn: 'Hairdresser', code: 'scissors'),
    ],
    'Santé': [
      IconItem(icon: LucideIcons.heart, name: 'Santé', nameEn: 'Health', code: 'heart'),
      IconItem(icon: LucideIcons.stethoscope, name: 'Médecin', nameEn: 'Doctor', code: 'stethoscope'),
      IconItem(icon: LucideIcons.pill, name: 'Médicament', nameEn: 'Medicine', code: 'pill'),
      IconItem(icon: LucideIcons.activity, name: 'Activité', nameEn: 'Activity', code: 'activity'),
      IconItem(icon: LucideIcons.dumbbell, name: 'Sport', nameEn: 'Sport', code: 'dumbbell'),
    ],
    'Shopping': [
      IconItem(icon: LucideIcons.shoppingBag, name: 'Shopping', nameEn: 'Shopping', code: 'shoppingBag'),
      IconItem(icon: LucideIcons.shoppingCart, name: 'Panier', nameEn: 'Cart', code: 'shoppingCart'),
      IconItem(icon: LucideIcons.shirt, name: 'Vêtement', nameEn: 'Clothing', code: 'shirt'),
      IconItem(icon: LucideIcons.footprints, name: 'Chaussures', nameEn: 'Shoes', code: 'footprints'),
      IconItem(icon: LucideIcons.watch, name: 'Montre', nameEn: 'Watch', code: 'watch'),
      IconItem(icon: LucideIcons.smartphone, name: 'Smartphone', nameEn: 'Smartphone', code: 'smartphone'),
      IconItem(icon: LucideIcons.laptop, name: 'Ordinateur', nameEn: 'Laptop', code: 'laptop'),
      IconItem(icon: LucideIcons.tv, name: 'TV', nameEn: 'TV', code: 'tv'),
      IconItem(icon: LucideIcons.headphones, name: 'Casque', nameEn: 'Headphones', code: 'headphones'),
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<IconItem> get _filteredIcons {
    final categoryIcons = _selectedCategory == 'Tous'
        ? _iconCategories['Tous']!
        : _iconCategories[_selectedCategory] ?? [];

    if (_searchQuery.isEmpty) {
      return categoryIcons;
    }

    return categoryIcons
        .where((icon) => icon.matchesSearch(_searchQuery))
        .toList();
  }

  // Méthode pour obtenir les catégories traduites
  Map<String, String> _getCategoryTranslations(AppLocalizations l10n) {
    return {
      'Tous': l10n.all,
      'Finance': 'Finance', // TODO: Ajouter dans les localisations
      'Alimentation': l10n.food,
      'Transport': l10n.transport,
      'Loisirs': l10n.leisure,
      'Services': 'Services', // TODO: Ajouter dans les localisations
      'Santé': l10n.health,
      'Shopping': l10n.shopping,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barre de recherche
        _buildSearchBar(isDark, l10n),
        SizedBox(height: AppDimensions.paddingM),

        // Catégories
        _buildCategoryChips(isDark, l10n),
        SizedBox(height: AppDimensions.paddingM),

        // Grille d'icônes
        _buildIconGrid(isDark),
      ],
    );
  }

  Widget _buildSearchBar(bool isDark, AppLocalizations l10n) {
    return AppTextField(
      controller: _searchController,
      label: 'Rechercher une icône...',
      type: AppTextFieldType.search,
      icon: Icons.search,
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
      suffixIcon: _searchQuery.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchController.clear();
                  _searchQuery = '';
                });
              },
            )
          : null,
    );
  }

  Widget _buildCategoryChips(bool isDark, AppLocalizations l10n) {
    final categories = _iconCategories.keys.toList();
    final categoryTranslations = _getCategoryTranslations(l10n);

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: AppDimensions.paddingS),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          final translatedCategory = categoryTranslations[category] ?? category;

          return FilterChip(
            label: Text(translatedCategory),
            selected: isSelected,
            onSelected: (selected) {
              setState(() {
                _selectedCategory = category;
                _searchController.clear();
                _searchQuery = '';
              });
              HapticFeedback.selectionClick();
            },
            selectedColor: AppColors.primary.withOpacity(0.2),
            checkmarkColor: AppColors.primary,
            labelStyle: AppTypography.caption.copyWith(
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
            side: BorderSide(
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? AppColors.borderDark : AppColors.borderLight),
            ),
          ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: -0.2, end: 0);
        },
      ),
    );
  }

  Widget _buildIconGrid(bool isDark) {
    final icons = _filteredIcons;

    if (icons.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off,
                size: AppDimensions.iconXXL,
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textTertiary,
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                'Aucune icône trouvée',
                style: AppTypography.body.copyWith(
                  color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final iconItem = icons[index];
        final isSelected = widget.selectedIcon == iconItem.code;

        return _buildIconItem(
          iconItem: iconItem,
          isSelected: isSelected,
          isDark: isDark,
          index: index,
        );
      },
    );
  }

  Widget _buildIconItem({
    required IconItem iconItem,
    required bool isSelected,
    required bool isDark,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onIconSelected(iconItem.code);
      },
      child: AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingXS),
        backgroundColor: isSelected
            ? AppColors.primary.withOpacity(isDark ? 0.3 : 0.15)
            : (isDark ? AppColors.surfaceDark : AppColors.surface),
        borderColor: isSelected
            ? AppColors.primary
            : (isDark ? AppColors.borderDark : AppColors.borderLight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconItem.icon,
              size: AppDimensions.iconM,
              color: isSelected
                  ? AppColors.primary
                  : (isDark ? AppColors.textOnDark : AppColors.textPrimary),
            ),
            if (isSelected) ...[
              SizedBox(height: AppDimensions.paddingXS),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ).animate().fadeIn(delay: (index * 20).ms).scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
          ),
    );
  }
}
