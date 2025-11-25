// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocket_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider pour SharedPreferences

@ProviderFor(sharedPreferences)
const sharedPreferencesProvider = SharedPreferencesProvider._();

/// Provider pour SharedPreferences

final class SharedPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferences>,
          SharedPreferences,
          FutureOr<SharedPreferences>
        >
    with
        $FutureModifier<SharedPreferences>,
        $FutureProvider<SharedPreferences> {
  /// Provider pour SharedPreferences
  const SharedPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferences> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferences> create(Ref ref) {
    return sharedPreferences(ref);
  }
}

String _$sharedPreferencesHash() => r'd22b545aefe95500327f9dce52c645d746349271';

/// Provider pour PocketRemoteDataSource

@ProviderFor(pocketRemoteDataSource)
const pocketRemoteDataSourceProvider = PocketRemoteDataSourceProvider._();

/// Provider pour PocketRemoteDataSource

final class PocketRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          PocketRemoteDataSource,
          PocketRemoteDataSource,
          PocketRemoteDataSource
        >
    with $Provider<PocketRemoteDataSource> {
  /// Provider pour PocketRemoteDataSource
  const PocketRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pocketRemoteDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pocketRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<PocketRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PocketRemoteDataSource create(Ref ref) {
    return pocketRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PocketRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PocketRemoteDataSource>(value),
    );
  }
}

String _$pocketRemoteDataSourceHash() =>
    r'1df69b01ed52f196e8e0a4620d2989f9c5918073';

/// Provider pour PocketLocalDataSource

@ProviderFor(pocketLocalDataSource)
const pocketLocalDataSourceProvider = PocketLocalDataSourceProvider._();

/// Provider pour PocketLocalDataSource

final class PocketLocalDataSourceProvider
    extends
        $FunctionalProvider<
          PocketLocalDataSource,
          PocketLocalDataSource,
          PocketLocalDataSource
        >
    with $Provider<PocketLocalDataSource> {
  /// Provider pour PocketLocalDataSource
  const PocketLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pocketLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pocketLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<PocketLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PocketLocalDataSource create(Ref ref) {
    return pocketLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PocketLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PocketLocalDataSource>(value),
    );
  }
}

String _$pocketLocalDataSourceHash() =>
    r'69ebd8c8f9920281c9e6d9d635811aa6deb0399b';

/// Provider pour PocketRepository

@ProviderFor(pocketRepository)
const pocketRepositoryProvider = PocketRepositoryProvider._();

/// Provider pour PocketRepository

final class PocketRepositoryProvider
    extends
        $FunctionalProvider<
          PocketRepository,
          PocketRepository,
          PocketRepository
        >
    with $Provider<PocketRepository> {
  /// Provider pour PocketRepository
  const PocketRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pocketRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pocketRepositoryHash();

  @$internal
  @override
  $ProviderElement<PocketRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PocketRepository create(Ref ref) {
    return pocketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PocketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PocketRepository>(value),
    );
  }
}

String _$pocketRepositoryHash() => r'91d2cf0b0f99eae5b8b720bf8d7ec2ce247a9e4a';

@ProviderFor(getAllPocketsUseCase)
const getAllPocketsUseCaseProvider = GetAllPocketsUseCaseProvider._();

final class GetAllPocketsUseCaseProvider
    extends
        $FunctionalProvider<
          GetAllPocketsUseCase,
          GetAllPocketsUseCase,
          GetAllPocketsUseCase
        >
    with $Provider<GetAllPocketsUseCase> {
  const GetAllPocketsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllPocketsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllPocketsUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetAllPocketsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetAllPocketsUseCase create(Ref ref) {
    return getAllPocketsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetAllPocketsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetAllPocketsUseCase>(value),
    );
  }
}

String _$getAllPocketsUseCaseHash() =>
    r'a3c08024dfa7c81c00f951e7010d6fdbc02584cd';

@ProviderFor(getPocketsByCategoryUseCase)
const getPocketsByCategoryUseCaseProvider =
    GetPocketsByCategoryUseCaseProvider._();

final class GetPocketsByCategoryUseCaseProvider
    extends
        $FunctionalProvider<
          GetPocketsByCategoryUseCase,
          GetPocketsByCategoryUseCase,
          GetPocketsByCategoryUseCase
        >
    with $Provider<GetPocketsByCategoryUseCase> {
  const GetPocketsByCategoryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPocketsByCategoryUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPocketsByCategoryUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPocketsByCategoryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPocketsByCategoryUseCase create(Ref ref) {
    return getPocketsByCategoryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPocketsByCategoryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPocketsByCategoryUseCase>(value),
    );
  }
}

String _$getPocketsByCategoryUseCaseHash() =>
    r'4f6a1bb952642ef2f0454c9ed082ec84142f3972';

@ProviderFor(getPocketByIdUseCase)
const getPocketByIdUseCaseProvider = GetPocketByIdUseCaseProvider._();

final class GetPocketByIdUseCaseProvider
    extends
        $FunctionalProvider<
          GetPocketByIdUseCase,
          GetPocketByIdUseCase,
          GetPocketByIdUseCase
        >
    with $Provider<GetPocketByIdUseCase> {
  const GetPocketByIdUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPocketByIdUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPocketByIdUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPocketByIdUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPocketByIdUseCase create(Ref ref) {
    return getPocketByIdUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPocketByIdUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPocketByIdUseCase>(value),
    );
  }
}

String _$getPocketByIdUseCaseHash() =>
    r'23777d961938ec0c152ddf9c47af340648597c68';

@ProviderFor(createPocketUseCase)
const createPocketUseCaseProvider = CreatePocketUseCaseProvider._();

final class CreatePocketUseCaseProvider
    extends
        $FunctionalProvider<
          CreatePocketUseCase,
          CreatePocketUseCase,
          CreatePocketUseCase
        >
    with $Provider<CreatePocketUseCase> {
  const CreatePocketUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPocketUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPocketUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreatePocketUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreatePocketUseCase create(Ref ref) {
    return createPocketUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreatePocketUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreatePocketUseCase>(value),
    );
  }
}

String _$createPocketUseCaseHash() =>
    r'5bf2d950c37d05366525cd5969ced7776a87b00c';

@ProviderFor(updatePocketUseCase)
const updatePocketUseCaseProvider = UpdatePocketUseCaseProvider._();

final class UpdatePocketUseCaseProvider
    extends
        $FunctionalProvider<
          UpdatePocketUseCase,
          UpdatePocketUseCase,
          UpdatePocketUseCase
        >
    with $Provider<UpdatePocketUseCase> {
  const UpdatePocketUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updatePocketUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updatePocketUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdatePocketUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdatePocketUseCase create(Ref ref) {
    return updatePocketUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdatePocketUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdatePocketUseCase>(value),
    );
  }
}

String _$updatePocketUseCaseHash() =>
    r'9ce0ddeccec78207ec4be33a3c9d0641b1afc451';

@ProviderFor(deletePocketUseCase)
const deletePocketUseCaseProvider = DeletePocketUseCaseProvider._();

final class DeletePocketUseCaseProvider
    extends
        $FunctionalProvider<
          DeletePocketUseCase,
          DeletePocketUseCase,
          DeletePocketUseCase
        >
    with $Provider<DeletePocketUseCase> {
  const DeletePocketUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletePocketUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletePocketUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeletePocketUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeletePocketUseCase create(Ref ref) {
    return deletePocketUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeletePocketUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeletePocketUseCase>(value),
    );
  }
}

String _$deletePocketUseCaseHash() =>
    r'e24fceff3e32797554b37249df3a2feb2547c6a2';

@ProviderFor(activatePocketUseCase)
const activatePocketUseCaseProvider = ActivatePocketUseCaseProvider._();

final class ActivatePocketUseCaseProvider
    extends
        $FunctionalProvider<
          ActivatePocketUseCase,
          ActivatePocketUseCase,
          ActivatePocketUseCase
        >
    with $Provider<ActivatePocketUseCase> {
  const ActivatePocketUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activatePocketUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activatePocketUseCaseHash();

  @$internal
  @override
  $ProviderElement<ActivatePocketUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ActivatePocketUseCase create(Ref ref) {
    return activatePocketUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActivatePocketUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActivatePocketUseCase>(value),
    );
  }
}

String _$activatePocketUseCaseHash() =>
    r'b2d99240f575cbb6d394bc83184349bafaf39546';

@ProviderFor(deactivatePocketUseCase)
const deactivatePocketUseCaseProvider = DeactivatePocketUseCaseProvider._();

final class DeactivatePocketUseCaseProvider
    extends
        $FunctionalProvider<
          DeactivatePocketUseCase,
          DeactivatePocketUseCase,
          DeactivatePocketUseCase
        >
    with $Provider<DeactivatePocketUseCase> {
  const DeactivatePocketUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deactivatePocketUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deactivatePocketUseCaseHash();

  @$internal
  @override
  $ProviderElement<DeactivatePocketUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeactivatePocketUseCase create(Ref ref) {
    return deactivatePocketUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeactivatePocketUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeactivatePocketUseCase>(value),
    );
  }
}

String _$deactivatePocketUseCaseHash() =>
    r'9b4ce904ba4f60d88a17d58b2ad36233aee01901';

@ProviderFor(updateSpentAmountUseCase)
const updateSpentAmountUseCaseProvider = UpdateSpentAmountUseCaseProvider._();

final class UpdateSpentAmountUseCaseProvider
    extends
        $FunctionalProvider<
          UpdateSpentAmountUseCase,
          UpdateSpentAmountUseCase,
          UpdateSpentAmountUseCase
        >
    with $Provider<UpdateSpentAmountUseCase> {
  const UpdateSpentAmountUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateSpentAmountUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateSpentAmountUseCaseHash();

  @$internal
  @override
  $ProviderElement<UpdateSpentAmountUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UpdateSpentAmountUseCase create(Ref ref) {
    return updateSpentAmountUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateSpentAmountUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateSpentAmountUseCase>(value),
    );
  }
}

String _$updateSpentAmountUseCaseHash() =>
    r'dc9eeaa7c0e32c5958095a8d4a9f14d2350454a0';

@ProviderFor(addToSavingsUseCase)
const addToSavingsUseCaseProvider = AddToSavingsUseCaseProvider._();

final class AddToSavingsUseCaseProvider
    extends
        $FunctionalProvider<
          AddToSavingsUseCase,
          AddToSavingsUseCase,
          AddToSavingsUseCase
        >
    with $Provider<AddToSavingsUseCase> {
  const AddToSavingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addToSavingsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addToSavingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<AddToSavingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AddToSavingsUseCase create(Ref ref) {
    return addToSavingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddToSavingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddToSavingsUseCase>(value),
    );
  }
}

String _$addToSavingsUseCaseHash() =>
    r'4e9efcffbb58d62af39e499b41041d56557d4773';

@ProviderFor(withdrawFromSavingsUseCase)
const withdrawFromSavingsUseCaseProvider =
    WithdrawFromSavingsUseCaseProvider._();

final class WithdrawFromSavingsUseCaseProvider
    extends
        $FunctionalProvider<
          WithdrawFromSavingsUseCase,
          WithdrawFromSavingsUseCase,
          WithdrawFromSavingsUseCase
        >
    with $Provider<WithdrawFromSavingsUseCase> {
  const WithdrawFromSavingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'withdrawFromSavingsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$withdrawFromSavingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<WithdrawFromSavingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WithdrawFromSavingsUseCase create(Ref ref) {
    return withdrawFromSavingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WithdrawFromSavingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WithdrawFromSavingsUseCase>(value),
    );
  }
}

String _$withdrawFromSavingsUseCaseHash() =>
    r'b79b9264a2cd76fa89d9822abb199dc07100d800';

@ProviderFor(setMonthlySavingsUseCase)
const setMonthlySavingsUseCaseProvider = SetMonthlySavingsUseCaseProvider._();

final class SetMonthlySavingsUseCaseProvider
    extends
        $FunctionalProvider<
          SetMonthlySavingsUseCase,
          SetMonthlySavingsUseCase,
          SetMonthlySavingsUseCase
        >
    with $Provider<SetMonthlySavingsUseCase> {
  const SetMonthlySavingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setMonthlySavingsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setMonthlySavingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SetMonthlySavingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetMonthlySavingsUseCase create(Ref ref) {
    return setMonthlySavingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetMonthlySavingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetMonthlySavingsUseCase>(value),
    );
  }
}

String _$setMonthlySavingsUseCaseHash() =>
    r'f318da16e6f8c4df18db657de866faa6062f666b';

@ProviderFor(applyMonthlySavingsUseCase)
const applyMonthlySavingsUseCaseProvider =
    ApplyMonthlySavingsUseCaseProvider._();

final class ApplyMonthlySavingsUseCaseProvider
    extends
        $FunctionalProvider<
          ApplyMonthlySavingsUseCase,
          ApplyMonthlySavingsUseCase,
          ApplyMonthlySavingsUseCase
        >
    with $Provider<ApplyMonthlySavingsUseCase> {
  const ApplyMonthlySavingsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applyMonthlySavingsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applyMonthlySavingsUseCaseHash();

  @$internal
  @override
  $ProviderElement<ApplyMonthlySavingsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ApplyMonthlySavingsUseCase create(Ref ref) {
    return applyMonthlySavingsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApplyMonthlySavingsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApplyMonthlySavingsUseCase>(value),
    );
  }
}

String _$applyMonthlySavingsUseCaseHash() =>
    r'5f238df78cf44f64e898feabe1889e2aedf1e03c';

@ProviderFor(createDefaultPocketsUseCase)
const createDefaultPocketsUseCaseProvider =
    CreateDefaultPocketsUseCaseProvider._();

final class CreateDefaultPocketsUseCaseProvider
    extends
        $FunctionalProvider<
          CreateDefaultPocketsUseCase,
          CreateDefaultPocketsUseCase,
          CreateDefaultPocketsUseCase
        >
    with $Provider<CreateDefaultPocketsUseCase> {
  const CreateDefaultPocketsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createDefaultPocketsUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createDefaultPocketsUseCaseHash();

  @$internal
  @override
  $ProviderElement<CreateDefaultPocketsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CreateDefaultPocketsUseCase create(Ref ref) {
    return createDefaultPocketsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CreateDefaultPocketsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CreateDefaultPocketsUseCase>(value),
    );
  }
}

String _$createDefaultPocketsUseCaseHash() =>
    r'538087ff2cf8261a96382104d3cf72e8d1b8c84f';

@ProviderFor(getPocketSummaryUseCase)
const getPocketSummaryUseCaseProvider = GetPocketSummaryUseCaseProvider._();

final class GetPocketSummaryUseCaseProvider
    extends
        $FunctionalProvider<
          GetPocketSummaryUseCase,
          GetPocketSummaryUseCase,
          GetPocketSummaryUseCase
        >
    with $Provider<GetPocketSummaryUseCase> {
  const GetPocketSummaryUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPocketSummaryUseCaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPocketSummaryUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetPocketSummaryUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetPocketSummaryUseCase create(Ref ref) {
    return getPocketSummaryUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetPocketSummaryUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetPocketSummaryUseCase>(value),
    );
  }
}

String _$getPocketSummaryUseCaseHash() =>
    r'eb3dc2982b23c2e801724b9de0f12b4ba4521ec1';

/// Provider pour tous les pockets de l'utilisateur actuel

@ProviderFor(userPockets)
const userPocketsProvider = UserPocketsProvider._();

/// Provider pour tous les pockets de l'utilisateur actuel

final class UserPocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour tous les pockets de l'utilisateur actuel
  const UserPocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userPocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userPocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return userPockets(ref);
  }
}

String _$userPocketsHash() => r'607ebb7c6cf48198dca72b23e2dfcb5640129d02';

/// Provider pour les pockets par catégorie

@ProviderFor(pocketsByCategory)
const pocketsByCategoryProvider = PocketsByCategoryFamily._();

/// Provider pour les pockets par catégorie

final class PocketsByCategoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets par catégorie
  const PocketsByCategoryProvider._({
    required PocketsByCategoryFamily super.from,
    required PocketCategory super.argument,
  }) : super(
         retry: null,
         name: r'pocketsByCategoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pocketsByCategoryHash();

  @override
  String toString() {
    return r'pocketsByCategoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    final argument = this.argument as PocketCategory;
    return pocketsByCategory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PocketsByCategoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pocketsByCategoryHash() => r'b3db101eae5ee3c1b93dca0b9fbadad9e801c2e3';

/// Provider pour les pockets par catégorie

final class PocketsByCategoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<PocketEntity>>,
          PocketCategory
        > {
  const PocketsByCategoryFamily._()
    : super(
        retry: null,
        name: r'pocketsByCategoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour les pockets par catégorie

  PocketsByCategoryProvider call(PocketCategory category) =>
      PocketsByCategoryProvider._(argument: category, from: this);

  @override
  String toString() => r'pocketsByCategoryProvider';
}

/// Provider pour un pocket spécifique par ID

@ProviderFor(pocketById)
const pocketByIdProvider = PocketByIdFamily._();

/// Provider pour un pocket spécifique par ID

final class PocketByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<PocketEntity?>,
          PocketEntity?,
          FutureOr<PocketEntity?>
        >
    with $FutureModifier<PocketEntity?>, $FutureProvider<PocketEntity?> {
  /// Provider pour un pocket spécifique par ID
  const PocketByIdProvider._({
    required PocketByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pocketByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pocketByIdHash();

  @override
  String toString() {
    return r'pocketByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PocketEntity?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PocketEntity?> create(Ref ref) {
    final argument = this.argument as String;
    return pocketById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PocketByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pocketByIdHash() => r'd1e23d1e416db65186a5592fdf2479287406ce37';

/// Provider pour un pocket spécifique par ID

final class PocketByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PocketEntity?>, String> {
  const PocketByIdFamily._()
    : super(
        retry: null,
        name: r'pocketByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour un pocket spécifique par ID

  PocketByIdProvider call(String pocketId) =>
      PocketByIdProvider._(argument: pocketId, from: this);

  @override
  String toString() => r'pocketByIdProvider';
}

/// Provider pour le résumé des pockets

@ProviderFor(pocketSummary)
const pocketSummaryProvider = PocketSummaryProvider._();

/// Provider pour le résumé des pockets

final class PocketSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<PocketCategory, PocketSummary>>,
          Map<PocketCategory, PocketSummary>,
          FutureOr<Map<PocketCategory, PocketSummary>>
        >
    with
        $FutureModifier<Map<PocketCategory, PocketSummary>>,
        $FutureProvider<Map<PocketCategory, PocketSummary>> {
  /// Provider pour le résumé des pockets
  const PocketSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pocketSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pocketSummaryHash();

  @$internal
  @override
  $FutureProviderElement<Map<PocketCategory, PocketSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<PocketCategory, PocketSummary>> create(Ref ref) {
    return pocketSummary(ref);
  }
}

String _$pocketSummaryHash() => r'3caaa254f8a40052bf5a4f58b81bfd84fb5696f6';

/// Provider pour le total des revenus de l'utilisateur

@ProviderFor(totalIncome)
const totalIncomeProvider = TotalIncomeProvider._();

/// Provider pour le total des revenus de l'utilisateur

final class TotalIncomeProvider
    extends $FunctionalProvider<double, double, double>
    with $Provider<double> {
  /// Provider pour le total des revenus de l'utilisateur
  const TotalIncomeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'totalIncomeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$totalIncomeHash();

  @$internal
  @override
  $ProviderElement<double> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  double create(Ref ref) {
    return totalIncome(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$totalIncomeHash() => r'3b86b7f02c40840c24d69c331c069625fa4597b2';

/// Contrôleur pour la gestion des pockets

@ProviderFor(PocketController)
const pocketControllerProvider = PocketControllerProvider._();

/// Contrôleur pour la gestion des pockets
final class PocketControllerProvider
    extends $AsyncNotifierProvider<PocketController, void> {
  /// Contrôleur pour la gestion des pockets
  const PocketControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pocketControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pocketControllerHash();

  @$internal
  @override
  PocketController create() => PocketController();
}

String _$pocketControllerHash() => r'60c5dd678b01eadc60c704194ce610abef681611';

/// Contrôleur pour la gestion des pockets

abstract class _$PocketController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}

/// Provider pour les pockets actifs uniquement

@ProviderFor(activePockets)
const activePocketsProvider = ActivePocketsProvider._();

/// Provider pour les pockets actifs uniquement

final class ActivePocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets actifs uniquement
  const ActivePocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activePocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activePocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return activePockets(ref);
  }
}

String _$activePocketsHash() => r'62d59199fdd1187b01b1447569875b1f2ffd795d';

/// Provider pour les pockets de type Needs

@ProviderFor(needsPockets)
const needsPocketsProvider = NeedsPocketsProvider._();

/// Provider pour les pockets de type Needs

final class NeedsPocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets de type Needs
  const NeedsPocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'needsPocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$needsPocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return needsPockets(ref);
  }
}

String _$needsPocketsHash() => r'393b4a1a97f8d37a10d6123e53e50be7f2c71a0c';

/// Provider pour les pockets de type Wants

@ProviderFor(wantsPockets)
const wantsPocketsProvider = WantsPocketsProvider._();

/// Provider pour les pockets de type Wants

final class WantsPocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets de type Wants
  const WantsPocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'wantsPocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$wantsPocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return wantsPockets(ref);
  }
}

String _$wantsPocketsHash() => r'3ce62438eb4c2d0fb9de96ae29842518d9de626b';

/// Provider pour les pockets de type Savings

@ProviderFor(savingsPockets)
const savingsPocketsProvider = SavingsPocketsProvider._();

/// Provider pour les pockets de type Savings

final class SavingsPocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets de type Savings
  const SavingsPocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'savingsPocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$savingsPocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return savingsPockets(ref);
  }
}

String _$savingsPocketsHash() => r'98e6c90685ad6f22cc014eba61f866015c72bbc9';

/// Provider pour les pockets avec budget dépassé

@ProviderFor(overBudgetPockets)
const overBudgetPocketsProvider = OverBudgetPocketsProvider._();

/// Provider pour les pockets avec budget dépassé

final class OverBudgetPocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets avec budget dépassé
  const OverBudgetPocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'overBudgetPocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$overBudgetPocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return overBudgetPockets(ref);
  }
}

String _$overBudgetPocketsHash() => r'85c34102aed2bcba5b4af025275ef96469fdea28';

/// Provider pour les pockets avec objectif atteint

@ProviderFor(goalsReachedPockets)
const goalsReachedPocketsProvider = GoalsReachedPocketsProvider._();

/// Provider pour les pockets avec objectif atteint

final class GoalsReachedPocketsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<PocketEntity>>,
          List<PocketEntity>,
          FutureOr<List<PocketEntity>>
        >
    with
        $FutureModifier<List<PocketEntity>>,
        $FutureProvider<List<PocketEntity>> {
  /// Provider pour les pockets avec objectif atteint
  const GoalsReachedPocketsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goalsReachedPocketsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goalsReachedPocketsHash();

  @$internal
  @override
  $FutureProviderElement<List<PocketEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<PocketEntity>> create(Ref ref) {
    return goalsReachedPockets(ref);
  }
}

String _$goalsReachedPocketsHash() =>
    r'd429d882b789bff9de335bb9001517428e59a6df';

/// Provider pour compter les transactions d'un pocket

@ProviderFor(transactionCountByPocket)
const transactionCountByPocketProvider = TransactionCountByPocketFamily._();

/// Provider pour compter les transactions d'un pocket

final class TransactionCountByPocketProvider
    extends $FunctionalProvider<int, int, int>
    with $Provider<int> {
  /// Provider pour compter les transactions d'un pocket
  const TransactionCountByPocketProvider._({
    required TransactionCountByPocketFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'transactionCountByPocketProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$transactionCountByPocketHash();

  @override
  String toString() {
    return r'transactionCountByPocketProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<int> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  int create(Ref ref) {
    final argument = this.argument as String?;
    return transactionCountByPocket(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TransactionCountByPocketProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$transactionCountByPocketHash() =>
    r'2b77a1bd6f4f716659037ff58ebac68d97a74e33';

/// Provider pour compter les transactions d'un pocket

final class TransactionCountByPocketFamily extends $Family
    with $FunctionalFamilyOverride<int, String?> {
  const TransactionCountByPocketFamily._()
    : super(
        retry: null,
        name: r'transactionCountByPocketProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider pour compter les transactions d'un pocket

  TransactionCountByPocketProvider call(String? pocketId) =>
      TransactionCountByPocketProvider._(argument: pocketId, from: this);

  @override
  String toString() => r'transactionCountByPocketProvider';
}
