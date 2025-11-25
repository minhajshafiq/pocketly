import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pocketly/core/widgets/app_card.dart';
import 'package:pocketly/core/constants/app_dimensions.dart';
import 'package:pocketly/core/constants/app_colors.dart';

/// Modèle représentant une couleur avec son code hexadécimal
class ColorItem {
  final Color color;
  final String hexCode;
  final String name;

  const ColorItem({
    required this.color,
    required this.hexCode,
    required this.name,
  });
}

/// Widget pour sélectionner une couleur pour un pocket
///
/// Affiche une grille de couleurs pastel avec sélection visuelle
class PocketColorPicker extends StatelessWidget {
  final String? selectedColor;
  final ValueChanged<String> onColorSelected;

  const PocketColorPicker({
    super.key,
    this.selectedColor,
    required this.onColorSelected,
  });

  // Palette de couleurs pastel
  static const List<ColorItem> _pastelColors = [
    // Roses et Corals
    ColorItem(color: Color(0xFFFFB3BA), hexCode: '#FFB3BA', name: 'Rose pâle'),
    ColorItem(color: Color(0xFFFFDFBA), hexCode: '#FFDFBA', name: 'Pêche'),
    ColorItem(color: Color(0xFFFFF2BA), hexCode: '#FFF2BA', name: 'Jaune pâle'),
    ColorItem(color: Color(0xFFBAFFC9), hexCode: '#BAFFC9', name: 'Vert menthe'),
    ColorItem(color: Color(0xFFBAE1FF), hexCode: '#BAE1FF', name: 'Bleu ciel'),
    ColorItem(color: Color(0xFFE0BBE4), hexCode: '#E0BBE4', name: 'Lavande'),
    ColorItem(color: Color(0xFFFFCCCB), hexCode: '#FFCCCB', name: 'Rose'),
    ColorItem(color: Color(0xFFFFD6CC), hexCode: '#FFD6CC', name: 'Corail'),
    
    // Verts et Bleus
    ColorItem(color: Color(0xFFB4E4D4), hexCode: '#B4E4D4', name: 'Vert eau'),
    ColorItem(color: Color(0xFFC7E9B0), hexCode: '#C7E9B0', name: 'Vert lime'),
    ColorItem(color: Color(0xFFD4F1F4), hexCode: '#D4F1F4', name: 'Bleu turquoise'),
    ColorItem(color: Color(0xFFB8D4E3), hexCode: '#B8D4E3', name: 'Bleu poudre'),
    ColorItem(color: Color(0xFFC4C1E0), hexCode: '#C4C1E0', name: 'Bleu pervenche'),
    ColorItem(color: Color(0xFFD1C4E9), hexCode: '#D1C4E9', name: 'Violet pâle'),
    
    // Jaunes et Oranges
    ColorItem(color: Color(0xFFFFF4E6), hexCode: '#FFF4E6', name: 'Crème'),
    ColorItem(color: Color(0xFFFFE5B4), hexCode: '#FFE5B4', name: 'Jaune doux'),
    ColorItem(color: Color(0xFFFFD9B3), hexCode: '#FFD9B3', name: 'Abricot'),
    ColorItem(color: Color(0xFFFFCCB6), hexCode: '#FFCCB6', name: 'Pêche foncé'),
    
    // Violets et Mauves
    ColorItem(color: Color(0xFFE8D5E3), hexCode: '#E8D5E3', name: 'Mauve'),
    ColorItem(color: Color(0xFFF0D6F7), hexCode: '#F0D6F7', name: 'Lavande clair'),
    ColorItem(color: Color(0xFFD6C2E0), hexCode: '#D6C2E0', name: 'Violet doux'),
    
    // Gris et Neutres
    ColorItem(color: Color(0xFFE8E8E8), hexCode: '#E8E8E8', name: 'Gris clair'),
    ColorItem(color: Color(0xFFF5F5DC), hexCode: '#F5F5DC', name: 'Beige'),
    ColorItem(color: Color(0xFFFFF8DC), hexCode: '#FFF8DC', name: 'Cornsilk'),
    
    // Autres pastels
    ColorItem(color: Color(0xFFB8E6B8), hexCode: '#B8E6B8', name: 'Vert pomme'),
    ColorItem(color: Color(0xFFB3D9FF), hexCode: '#B3D9FF', name: 'Bleu bébé'),
    ColorItem(color: Color(0xFFFFB6C1), hexCode: '#FFB6C1', name: 'Rose clair'),
    ColorItem(color: Color(0xFFFFC0CB), hexCode: '#FFC0CB', name: 'Pink'),
    ColorItem(color: Color(0xFFFFE4E1), hexCode: '#FFE4E1', name: 'Rose coquille'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: _pastelColors.length,
      itemBuilder: (context, index) {
        final colorItem = _pastelColors[index];
        final isSelected = selectedColor?.toUpperCase() == colorItem.hexCode.toUpperCase();

        return _buildColorItem(
          colorItem: colorItem,
          isSelected: isSelected,
          isDark: isDark,
          index: index,
        );
      },
    );
  }

  Widget _buildColorItem({
    required ColorItem colorItem,
    required bool isSelected,
    required bool isDark,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onColorSelected(colorItem.hexCode);
      },
      child: AppCard(
        padding: EdgeInsets.all(AppDimensions.paddingXS),
        backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surface,
        borderColor: isSelected
            ? AppColors.primary
            : (isDark ? AppColors.borderDark : AppColors.borderLight),
        isSelected: isSelected,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Cercle de couleur
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: colorItem.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: colorItem.color.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            // Indicateur de sélection
            if (isSelected)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary,
                    width: 3,
                  ),
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: AppDimensions.iconM,
                ),
              ),
          ],
        ),
      ).animate().fadeIn(delay: (index * 15).ms).scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
          ),
    );
  }
}
