import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/category_entity.dart';
import '../providers/category_provider.dart';
import '../../../../core/constants/app_icons.dart';

/// Widget pour sélectionner une catégorie
class CategorySelector extends ConsumerWidget {
  final CategoryType type;
  final CategoryEntity? selectedCategory;
  final Function(CategoryEntity) onCategorySelected;
  final bool showCustomCategories;
  final bool showDefaultCategories;

  const CategorySelector({
    super.key,
    required this.type,
    required this.onCategorySelected,
    this.selectedCategory,
    this.showCustomCategories = true,
    this.showDefaultCategories = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryProvider);
    final categoriesByType = ref.watch(categoriesByTypeProvider(type));

    // Charger les catégories si elles ne sont pas encore chargées
    if (categoryAsync.value?.isEmpty == true && !categoryAsync.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(categoryProvider.notifier).loadCategories();
      });
    }

    if (categoryAsync.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (categoryAsync.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              AppIcons.errorOutline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur lors du chargement des catégories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              categoryAsync.error.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(categoryProvider.notifier).loadCategories();
              },
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    return _buildCategoryGrid(categoriesByType);
  }

  Widget _buildCategoryGrid(List<CategoryEntity> categories) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = selectedCategory?.id == category.id;

        return _buildCategoryItem(category, isSelected);
      },
    );
  }

  Widget _buildCategoryItem(CategoryEntity category, bool isSelected) {
    return GestureDetector(
      onTap: () => onCategorySelected(category),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? _getColorValue(category.color).withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? _getColorValue(category.color)
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getColorValue(category.color).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getIconData(category.iconName),
                color: _getColorValue(category.color),
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? _getColorValue(category.color) : null,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Conversion de la couleur hex en Color Flutter
  static Color _getColorValue(String color) {
    return Color(int.parse(color.replaceFirst('#', '0xFF')));
  }

  /// Obtient l'icône correspondante en utilisant AppIcons
  static IconData _getIconData(String iconName) {
    return AppIcons.getCategoryIcon(iconName);
  }
}

/// Widget pour afficher une catégorie sélectionnée
class SelectedCategoryDisplay extends StatelessWidget {
  final CategoryEntity? category;
  final VoidCallback? onTap;

  const SelectedCategoryDisplay({super.key, this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    if (category == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(AppIcons.category, color: Colors.grey, size: 20),
            const SizedBox(width: 12),
            Text(
              'Aucune catégorie sélectionnée',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _getColorValue(category!.color).withValues(alpha: 0.1),
          border: Border.all(
            color: _getColorValue(category!.color).withValues(alpha: 0.3),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getColorValue(category!.color).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                _getIconData(category!.iconName),
                color: _getColorValue(category!.color),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category!.name,
                style: TextStyle(
                  color: _getColorValue(category!.color),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onTap != null)
              Icon(
                AppIcons.arrowDropDown,
                color: _getColorValue(category!.color),
              ),
          ],
        ),
      ),
    );
  }

  /// Conversion de la couleur hex en Color Flutter
  static Color _getColorValue(String color) {
    return Color(int.parse(color.replaceFirst('#', '0xFF')));
  }

  /// Obtient l'icône correspondante en utilisant AppIcons
  static IconData _getIconData(String iconName) {
    return AppIcons.getCategoryIcon(iconName);
  }
}
