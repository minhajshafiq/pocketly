import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pocketly/core/core.dart';
import 'package:pocketly/core/services/logo_dev_service.dart';
import 'package:pocketly/generated/l10n/app_localizations.dart';

/// Widget pour sélectionner une image pour une transaction.
///
/// Permet de choisir une image depuis :
/// - La galerie photo
/// - Logo.dev (logos de marques)
///
/// Callback:
/// - [onImageSelected] - Appelé avec le fichier image sélectionné depuis la galerie
/// - [onLogoSelected] - Appelé avec les bytes du logo depuis logo.dev
/// - [onImageRemoved] - Appelé quand l'utilisateur supprime l'image
class TransactionImagePicker extends ConsumerWidget {
  final String? currentImageUrl;
  final Function(File imageFile)? onImageSelected;
  final Function(String logoUrl)? onLogoSelected;
  final VoidCallback? onImageRemoved;
  final double size;

  const TransactionImagePicker({
    super.key,
    this.currentImageUrl,
    this.onImageSelected,
    this.onLogoSelected,
    this.onImageRemoved,
    this.size = 80,
  });

  bool get _isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _showImageSourcePicker(context, ref),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.surfaceDark
              : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isDark
                ? AppColors.textSecondaryOnDark.withValues(alpha: 0.3)
                : AppColors.textSecondary.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: _buildContent(isDark),
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    if (currentImageUrl != null && currentImageUrl!.isNotEmpty) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.radiusM - 2),
            child: Image.network(
              currentImageUrl!,
              fit: BoxFit.cover,
              width: size,
              height: size,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder(isDark);
              },
            ),
          ),
          if (onImageRemoved != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onImageRemoved,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isIOS ? CupertinoIcons.xmark : Icons.close,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return _buildPlaceholder(isDark);
  }

  Widget _buildPlaceholder(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isIOS ? CupertinoIcons.photo : Icons.add_photo_alternate,
            size: size * 0.4,
            color: isDark
                ? AppColors.textSecondaryOnDark
                : AppColors.textSecondary,
          ),
          SizedBox(height: AppDimensions.paddingXS),
          Text(
            'Logo',
            style: AppTypography.caption.copyWith(
              fontSize: AppDimensions.fontSizeLabel,
              color: isDark
                  ? AppColors.textSecondaryOnDark
                  : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSourcePicker(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;

    if (_isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(l10n.addTransactionLogo),
          message: Text(l10n.chooseLogoSource),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _pickFromGallery(ref);
              },
              child: Text(l10n.photoLibrary),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                _showBrandPicker(context, ref);
              },
              child: Text(l10n.searchBrandLogo),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            isDestructiveAction: true,
            child: Text(l10n.cancel),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(l10n.photoLibrary),
                onTap: () {
                  Navigator.pop(context);
                  _pickFromGallery(ref);
                },
              ),
              ListTile(
                leading: const Icon(Icons.search),
                title: Text(l10n.searchBrandLogo),
                onTap: () {
                  Navigator.pop(context);
                  _showBrandPicker(context, ref);
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Future<void> _pickFromGallery(WidgetRef ref) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null && onImageSelected != null) {
        final imageFile = File(pickedFile.path);
        onImageSelected!(imageFile);
      }
    } catch (e) {
      // Erreur gérée par le parent
    }
  }

  void _showBrandPicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _LogoSearchModal(
        onLogoSelected: (logoUrl) {
          Navigator.pop(context);
          if (onLogoSelected != null) {
            onLogoSelected!(logoUrl);
          }
        },
      ),
    );
  }
}

/// Modal de recherche de logos avec API logo.dev
class _LogoSearchModal extends ConsumerStatefulWidget {
  final Function(String logoUrl) onLogoSelected;

  const _LogoSearchModal({
    required this.onLogoSelected,
  });

  @override
  ConsumerState<_LogoSearchModal> createState() => _LogoSearchModalState();
}

class _LogoSearchModalState extends ConsumerState<_LogoSearchModal> {
  final _searchController = TextEditingController();
  List<LogoSearchResult> _searchResults = [];
  bool _isSearching = false;
  String? _error;

  bool get _isIOS => Platform.isIOS;

  @override
  void initState() {
    super.initState();
    // Charger les marques populaires au démarrage
    _loadPopularBrands();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadPopularBrands() {
    // Convertir les marques populaires en LogoSearchResult
    _searchResults = LogoDevService.popularBrands.map((brand) {
      return LogoSearchResult(
        name: brand['name']!,
        domain: brand['domain']!,
      );
    }).toList();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _loadPopularBrands();
        _error = null;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
    });

    try {
      final logoDevService = ref.read(logoDevServiceProvider);
      final results = await logoDevService.searchLogos(query);

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Erreur de recherche: $e';
          _isSearching = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.backgroundDark : AppColors.background,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(AppDimensions.paddingM),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.selectBrand,
                        style: AppTypography.heading.copyWith(
                          color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        _isIOS ? CupertinoIcons.xmark : Icons.close,
                        color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),

              // Barre de recherche
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
                child: _isIOS
                    ? CupertinoSearchTextField(
                        controller: _searchController,
                        placeholder: 'Rechercher une marque...',
                        onChanged: (value) {
                          // Debounce la recherche
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (_searchController.text == value) {
                              _performSearch(value);
                            }
                          });
                        },
                        onSubmitted: _performSearch,
                      )
                    : TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher une marque...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    _loadPopularBrands();
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                          ),
                        ),
                        onChanged: (value) {
                          // Debounce la recherche
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (_searchController.text == value) {
                              _performSearch(value);
                            }
                          });
                        },
                        onSubmitted: _performSearch,
                      ),
              ),

              SizedBox(height: AppDimensions.paddingM),

              // Résultats
              Expanded(
                child: _buildResults(scrollController, isDark),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResults(ScrollController scrollController, bool isDark) {
    if (_isSearching) {
      return Center(
        child: _isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isIOS ? CupertinoIcons.exclamationmark_circle : Icons.error_outline,
                size: 48,
                color: AppColors.error,
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                _error!,
                style: AppTypography.body.copyWith(
                  color: AppColors.error,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isIOS ? CupertinoIcons.search : Icons.search_off,
                size: 48,
                color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
              ),
              SizedBox(height: AppDimensions.paddingM),
              Text(
                'Aucun logo trouvé',
                style: AppTypography.body.copyWith(
                  color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return ListTile(
          leading: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                result.getImageUrl(size: 100),
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: _isIOS
                          ? const CupertinoActivityIndicator()
                          : CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    _isIOS ? CupertinoIcons.building_2_fill : Icons.business,
                    size: 24,
                    color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
                  );
                },
              ),
            ),
          ),
          title: Text(
            result.name,
            style: AppTypography.body.copyWith(
              color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            result.domain,
            style: AppTypography.caption.copyWith(
              color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
            ),
          ),
          trailing: Icon(
            _isIOS ? CupertinoIcons.chevron_right : Icons.chevron_right,
            color: isDark ? AppColors.textSecondaryOnDark : AppColors.textSecondary,
          ),
          onTap: () {
            widget.onLogoSelected(result.getImageUrl());
          },
        );
      },
    );
  }
}
