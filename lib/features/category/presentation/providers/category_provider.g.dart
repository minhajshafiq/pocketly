// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SupabaseClient

@ProviderFor(supabaseClient)
const supabaseClientProvider = SupabaseClientProvider._();

/// Provider pour SupabaseClient

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// Provider pour SupabaseClient
  const SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'834a58d6ae4b94e36f4e04a10d8a7684b929310e';

/// Provider pour CategoryRepository

@ProviderFor(categoryRepository)
const categoryRepositoryProvider = CategoryRepositoryProvider._();

/// Provider pour CategoryRepository

final class CategoryRepositoryProvider
    extends
        $FunctionalProvider<
          CategoryRepository,
          CategoryRepository,
          CategoryRepository
        >
    with $Provider<CategoryRepository> {
  /// Provider pour CategoryRepository
  const CategoryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryRepositoryHash();

  @$internal
  @override
  $ProviderElement<CategoryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CategoryRepository create(Ref ref) {
    return categoryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryRepository>(value),
    );
  }
}

String _$categoryRepositoryHash() =>
    r'2ed0fbf29aeeddd7d6d39d1371947a3fd22024d4';

/// Provider pour les use cases

@ProviderFor(getAllCategoriesUseCase)
const getAllCategoriesUseCaseProvider = GetAllCategoriesUseCaseProvider._();

/// Provider pour les use cases

final class GetAllCategoriesUseCaseProvider
    extends
        $FunctionalProvider<
          GetAllCategoriesUseCase,
          GetAllCategoriesUseCase,
          GetAllCategoriesUseCase
        >
    with $Provider<GetAllCategoriesUseCase> {
  /// Provider pour les use cases
  const GetAllCategoriesUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllCategoriesUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllCategoriesUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAllCategoriesUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllCategoriesUseCase create(Ref ref) {
    return getAllCategoriesUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllCategoriesUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllCategoriesUseCase>(value),
    );
  }
}

String _$getAllCategoriesUseCaseHash() =>
    r'5153dce01e71df3140fc48b3533a00906f3e5ea3';

@ProviderFor(createCustomCategoryUseCase)
const createCustomCategoryUseCaseProvider =
    CreateCustomCategoryUseCaseProvider._();

final class CreateCustomCategoryUseCaseProvider
    extends
        $FunctionalProvider<
          CreateCustomCategoryUseCase,
          CreateCustomCategoryUseCase,
          CreateCustomCategoryUseCase
        >
    with $Provider<CreateCustomCategoryUseCase> {
  const CreateCustomCategoryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createCustomCategoryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createCustomCategoryUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateCustomCategoryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateCustomCategoryUseCase create(Ref ref) {
    return createCustomCategoryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateCustomCategoryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateCustomCategoryUseCase>(value),
    );
  }
}

String _$createCustomCategoryUseCaseHash() =>
    r'7e4f7ad809e4a827dea29f6a030edf51ada2e4f7';

@ProviderFor(deleteCustomCategoryUseCase)
const deleteCustomCategoryUseCaseProvider =
    DeleteCustomCategoryUseCaseProvider._();

final class DeleteCustomCategoryUseCaseProvider
    extends
        $FunctionalProvider<
          DeleteCustomCategoryUseCase,
          DeleteCustomCategoryUseCase,
          DeleteCustomCategoryUseCase
        >
    with $Provider<DeleteCustomCategoryUseCase> {
  const DeleteCustomCategoryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteCustomCategoryUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteCustomCategoryUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeleteCustomCategoryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteCustomCategoryUseCase create(Ref ref) {
    return deleteCustomCategoryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteCustomCategoryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteCustomCategoryUseCase>(value),
    );
  }
}

String _$deleteCustomCategoryUseCaseHash() =>
    r'2b858bcd8c6516c1eb35db0a6950e33fd866083b';

/// Notifier pour la gestion des catégories

@ProviderFor(CategoryNotifier)
const categoryProvider = CategoryNotifierProvider._();

/// Notifier pour la gestion des catégories
final class CategoryNotifierProvider
    extends $AsyncNotifierProvider<CategoryNotifier, List<CategoryEntity>> {
  /// Notifier pour la gestion des catégories
  const CategoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoryNotifierHash();

  @$internal
  @override
  CategoryNotifier create() => CategoryNotifier();
}

String _$categoryNotifierHash() => r'7dcc9a77151a8615447056188260f34ef11af3f0';

/// Notifier pour la gestion des catégories

abstract class _$CategoryNotifier extends $AsyncNotifier<List<CategoryEntity>> {
  FutureOr<List<CategoryEntity>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<CategoryEntity>>, List<CategoryEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<CategoryEntity>>,
                List<CategoryEntity>
              >,
              AsyncValue<List<CategoryEntity>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider pour les catégories filtrées par type

@ProviderFor(categoriesByType)
const categoriesByTypeProvider = CategoriesByTypeFamily._();

/// Provider pour les catégories filtrées par type

final class CategoriesByTypeProvider
    extends
        $FunctionalProvider<
          List<CategoryEntity>,
          List<CategoryEntity>,
          List<CategoryEntity>
        >
    with $Provider<List<CategoryEntity>> {
  /// Provider pour les catégories filtrées par type
  const CategoriesByTypeProvider._({
    required CategoriesByTypeFamily super.from,
    required CategoryType super.argument,
  }) : super(
         retry: null,
         name: r'categoriesByTypeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoriesByTypeHash();

  @override
  String toString() {
    return r'categoriesByTypeProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<List<CategoryEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CategoryEntity> create(Ref ref) {
    final argument = this.argument as CategoryType;
    return categoriesByType(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CategoryEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CategoryEntity>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CategoriesByTypeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoriesByTypeHash() => r'0e2584c44f2c85b30b7e0445d7262f0776aaa3ae';

/// Provider pour les catégories filtrées par type

final class CategoriesByTypeFamily extends $Family
    with $FunctionalFamilyOverride<List<CategoryEntity>, CategoryType> {
  const CategoriesByTypeFamily._()
    : super(
        retry: null,
        name: r'categoriesByTypeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour les catégories filtrées par type

  CategoriesByTypeProvider call(CategoryType type) =>
      CategoriesByTypeProvider._(argument: type, from: this);

  @override
  String toString() => r'categoriesByTypeProvider';
}

/// Provider AsyncValue pour les catégories filtrées par type
/// Préserve les états de loading et error

@ProviderFor(categoriesByTypeAsync)
const categoriesByTypeAsyncProvider = CategoriesByTypeAsyncFamily._();

/// Provider AsyncValue pour les catégories filtrées par type
/// Préserve les états de loading et error

final class CategoriesByTypeAsyncProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CategoryEntity>>,
          AsyncValue<List<CategoryEntity>>,
          AsyncValue<List<CategoryEntity>>
        >
    with $Provider<AsyncValue<List<CategoryEntity>>> {
  /// Provider AsyncValue pour les catégories filtrées par type
  /// Préserve les états de loading et error
  const CategoriesByTypeAsyncProvider._({
    required CategoriesByTypeAsyncFamily super.from,
    required CategoryType super.argument,
  }) : super(
         retry: null,
         name: r'categoriesByTypeAsyncProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoriesByTypeAsyncHash();

  @override
  String toString() {
    return r'categoriesByTypeAsyncProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<AsyncValue<List<CategoryEntity>>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AsyncValue<List<CategoryEntity>> create(Ref ref) {
    final argument = this.argument as CategoryType;
    return categoriesByTypeAsync(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<CategoryEntity>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<CategoryEntity>>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CategoriesByTypeAsyncProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoriesByTypeAsyncHash() =>
    r'efd05ad012d171a04c2d0d53a3599da01dc4908c';

/// Provider AsyncValue pour les catégories filtrées par type
/// Préserve les états de loading et error

final class CategoriesByTypeAsyncFamily extends $Family
    with
        $FunctionalFamilyOverride<
          AsyncValue<List<CategoryEntity>>,
          CategoryType
        > {
  const CategoriesByTypeAsyncFamily._()
    : super(
        retry: null,
        name: r'categoriesByTypeAsyncProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider AsyncValue pour les catégories filtrées par type
  /// Préserve les états de loading et error

  CategoriesByTypeAsyncProvider call(CategoryType type) =>
      CategoriesByTypeAsyncProvider._(argument: type, from: this);

  @override
  String toString() => r'categoriesByTypeAsyncProvider';
}

/// Provider pour les catégories custom

@ProviderFor(customCategories)
const customCategoriesProvider = CustomCategoriesProvider._();

/// Provider pour les catégories custom

final class CustomCategoriesProvider
    extends
        $FunctionalProvider<
          List<CategoryEntity>,
          List<CategoryEntity>,
          List<CategoryEntity>
        >
    with $Provider<List<CategoryEntity>> {
  /// Provider pour les catégories custom
  const CustomCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'customCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$customCategoriesHash();

  @$internal
  @override
  $ProviderElement<List<CategoryEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CategoryEntity> create(Ref ref) {
    return customCategories(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CategoryEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CategoryEntity>>(value),
    );
  }
}

String _$customCategoriesHash() => r'69057bc8f1835b55ae5b1667b883de9339e453fa';

/// Provider pour les catégories par défaut

@ProviderFor(defaultCategories)
const defaultCategoriesProvider = DefaultCategoriesProvider._();

/// Provider pour les catégories par défaut

final class DefaultCategoriesProvider
    extends
        $FunctionalProvider<
          List<CategoryEntity>,
          List<CategoryEntity>,
          List<CategoryEntity>
        >
    with $Provider<List<CategoryEntity>> {
  /// Provider pour les catégories par défaut
  const DefaultCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'defaultCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$defaultCategoriesHash();

  @$internal
  @override
  $ProviderElement<List<CategoryEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<CategoryEntity> create(Ref ref) {
    return defaultCategories(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CategoryEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CategoryEntity>>(value),
    );
  }
}

String _$defaultCategoriesHash() => r'fa64efef591dbdf7c814423bff503427a8c432f3';

/// Provider pour récupérer une catégorie par son ID

@ProviderFor(categoryById)
const categoryByIdProvider = CategoryByIdFamily._();

/// Provider pour récupérer une catégorie par son ID

final class CategoryByIdProvider
    extends
        $FunctionalProvider<CategoryEntity?, CategoryEntity?, CategoryEntity?>
    with $Provider<CategoryEntity?> {
  /// Provider pour récupérer une catégorie par son ID
  const CategoryByIdProvider._({
    required CategoryByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'categoryByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$categoryByIdHash();

  @override
  String toString() {
    return r'categoryByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<CategoryEntity?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CategoryEntity? create(Ref ref) {
    final argument = this.argument as String;
    return categoryById(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CategoryEntity? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CategoryEntity?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$categoryByIdHash() => r'4c98e6ab9074ddb891974eec88011f104f399f6b';

/// Provider pour récupérer une catégorie par son ID

final class CategoryByIdFamily extends $Family
    with $FunctionalFamilyOverride<CategoryEntity?, String> {
  const CategoryByIdFamily._()
    : super(
        retry: null,
        name: r'categoryByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour récupérer une catégorie par son ID

  CategoryByIdProvider call(String categoryId) =>
      CategoryByIdProvider._(argument: categoryId, from: this);

  @override
  String toString() => r'categoryByIdProvider';
}
