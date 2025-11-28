// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Pocketly';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get login => 'Connexion';

  @override
  String get logout => 'Déconnexion';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mot de passe';

  @override
  String get transactions => 'Transactions';

  @override
  String get transactionHistory => 'Historique';

  @override
  String get back => 'Retour';

  @override
  String get balance => 'Solde';

  @override
  String get amount => 'Montant';

  @override
  String get date => 'Date';

  @override
  String get description => 'Description';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get skip => 'Passer';

  @override
  String onboardingStepProgress(int current, int total) {
    return 'Étape $current sur $total';
  }

  @override
  String get onboardingStep1Title => 'Prenez le contrôle de votre argent';

  @override
  String get onboardingStep1Description =>
      'Pocketly vous guide simplement pour appliquer la règle 50/30/20, suivre vos dépenses et faire grandir votre épargne.';

  @override
  String get onboardingHighlightBudgetTitle => 'Budgeter comme un pro';

  @override
  String get onboardingHighlightBudgetDescription =>
      'Rassemblez vos besoins, envies et épargne au même endroit avec des limites intelligentes.';

  @override
  String get onboardingHighlightInsightsTitle => 'Insights instantanés';

  @override
  String get onboardingHighlightInsightsDescription =>
      'Comprenez où va chaque euro avec des graphiques en direct et des résumés hebdomadaires.';

  @override
  String get onboardingHighlightAutomationTitle => 'Accompagnement automatique';

  @override
  String get onboardingHighlightAutomationDescription =>
      'Pocketly vous rappelle de rester sur la bonne trajectoire et célèbre chaque palier.';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get add => 'Ajouter';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get loading => 'Chargement...';

  @override
  String get noData => 'Aucune donnée';

  @override
  String get retry => 'Réessayer';

  @override
  String get welcomeTitle => 'Bienvenue sur Pocketly';

  @override
  String get welcomeDescription =>
      'Votre compagnon financier personnel qui vous aide à suivre vos dépenses, gérer vos budgets et atteindre vos objectifs financiers.';

  @override
  String get trackSpendingTitle => 'Suivez Vos Dépenses';

  @override
  String get trackSpendingDescription =>
      'Obtenez des insights sur vos habitudes de dépenses avec de beaux graphiques et des analyses détaillées pour prendre des décisions financières éclairées.';

  @override
  String get saveSmartTitle => 'Économisez Intelligemment';

  @override
  String get saveSmartDescription =>
      'Définissez des objectifs d\'épargne, suivez vos progrès et obtenez des conseils personnalisés pour vous aider à économiser plus d\'argent chaque mois.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get onboardingSalaryTitle => 'Définissez votre salaire mensuel';

  @override
  String get onboardingSalarySubtitle =>
      'Nous appliquons automatiquement la méthode 50/30/20 pour savoir exactement combien allouer.';

  @override
  String get onboardingSalaryFieldLabel => 'Revenu net mensuel';

  @override
  String get onboardingSalaryFieldHint => 'ex: 2500';

  @override
  String get onboardingSalaryHelper =>
      'Vous pourrez modifier ce montant plus tard dans vos paramètres.';

  @override
  String get onboardingSalaryBreakdownTitle => 'Pocketly répartit pour vous';

  @override
  String get onboardingSalaryInputError => 'Veuillez saisir un salaire valide';

  @override
  String get onboardingContinue => 'Continuer';

  @override
  String get onboardingNotificationsTitle =>
      'Activez les notifications intelligentes';

  @override
  String get onboardingNotificationsSubtitle =>
      'Choisissez les alertes qui vous gardent sur la bonne voie et ne manquez rien d\'important.';

  @override
  String get onboardingNotificationsDescription =>
      'Pocketly envoie uniquement les notifications utiles : alertes budget, célébrations d\'objectifs et résumés hebdomadaires.';

  @override
  String get onboardingFinish => 'Aller au dashboard';

  @override
  String get onboardingCongratsTitle => 'Vous êtes prêt·e !';

  @override
  String get onboardingCongratsSubtitle =>
      'Vos finances ont un plan. Continuons sur Pocketly.';

  @override
  String get notificationPermissionTitle => 'Autorisation de notification';

  @override
  String get notificationPermissionMessage =>
      'Nous avons besoin de votre autorisation pour vous envoyer des notifications';

  @override
  String get notificationPermissionDenied =>
      'Autorisation de notification refusée';

  @override
  String get notificationScheduled => 'Notification programmée';

  @override
  String get notificationCancelled => 'Notification annulée';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get notificationSettings => 'Paramètres de notification';

  @override
  String get reminderNotification => 'Rappel';

  @override
  String get transactionNotification => 'Transaction';

  @override
  String get notificationErrorTitle => 'Erreur de notification';

  @override
  String get notificationPermissionError =>
      'Autorisation de notification refusée. Veuillez activer les notifications dans les paramètres de votre appareil.';

  @override
  String get notificationScheduleError =>
      'Échec de la planification de la notification. Veuillez réessayer.';

  @override
  String get notificationShowError =>
      'Échec de l\'affichage de la notification. Veuillez réessayer.';

  @override
  String get notificationCancelError =>
      'Échec de l\'annulation de la notification. Veuillez réessayer.';

  @override
  String get notificationInitializeError =>
      'Échec de l\'initialisation des notifications. Veuillez redémarrer l\'application.';

  @override
  String get notificationSuccess => 'Succès';

  @override
  String get notificationSuccessMessage => 'Opération terminée avec succès';

  @override
  String get notificationError => 'Erreur';

  @override
  String get notificationErrorMessage => 'Une erreur est survenue';

  @override
  String get notificationInfo => 'Information';

  @override
  String get notificationInfoMessage => 'Information importante';

  @override
  String get notificationWarning => 'Avertissement';

  @override
  String get notificationWarningMessage => 'Attention requise';

  @override
  String get notificationAction => 'Action requise';

  @override
  String get notificationActionMessage => 'Une action est nécessaire';

  @override
  String get notificationActionButton => 'Action';

  @override
  String get notificationLoading => 'Chargement';

  @override
  String get notificationLoadingMessage => 'Veuillez patienter...';

  @override
  String get food => 'Nourriture';

  @override
  String get housing => 'Logement';

  @override
  String get transport => 'Transport';

  @override
  String get health => 'Santé';

  @override
  String get leisure => 'Loisirs';

  @override
  String get shopping => 'Shopping';

  @override
  String get salary => 'Salaire';

  @override
  String get bonus => 'Prime';

  @override
  String get investment => 'Investissement';

  @override
  String get settings => 'Paramètres';

  @override
  String get profile => 'Profil';

  @override
  String get editProfile => 'Modifier le profil';

  @override
  String get fullName => 'Nom complet';

  @override
  String get enterFullName => 'Entrez votre nom complet';

  @override
  String get uploadingAvatar => 'Envoi de l\'avatar...';

  @override
  String get profileUpdated => 'Profil mis à jour avec succès';

  @override
  String get errorUpdatingProfile => 'Erreur lors de la mise à jour du profil';

  @override
  String get appearance => 'Apparence';

  @override
  String get preferences => 'Préférences';

  @override
  String get subscription => 'Abonnement';

  @override
  String get account => 'Compte';

  @override
  String get theme => 'Thème';

  @override
  String get language => 'Langue';

  @override
  String get currency => 'Devise';

  @override
  String get notAvailable => 'Non disponible';

  @override
  String get errorLoadingProfile => 'Erreur de chargement du profil';

  @override
  String get selectLanguage => 'Sélectionner la langue';

  @override
  String get selectCurrency => 'Sélectionner la devise';

  @override
  String get logoutError => 'Échec de la déconnexion. Veuillez réessayer.';

  @override
  String get logoutConfirmation =>
      'Êtes-vous sûr de vouloir vous déconnecter ?';

  @override
  String get currentBalance => 'Solde actuel';

  @override
  String get availableBalance => 'Solde disponible';

  @override
  String get last24Hours => 'Dernière 24h';

  @override
  String get weeklyExpenses => 'Dépensé cette semaine';

  @override
  String get recentTransactions => 'Transactions récentes';

  @override
  String get incomeLabel => 'Revenu';

  @override
  String get expensesLabel => 'Dépenses';

  @override
  String get seeAll => 'Voir tout';

  @override
  String get noTransactionsYet => 'Aucune transaction pour le moment';

  @override
  String get addTransaction => 'Ajouter une transaction';

  @override
  String get statistics => 'Statistiques';

  @override
  String get yourStatistics => 'Vos Statistiques';

  @override
  String get loadingError => 'Erreur de chargement';

  @override
  String get noTransaction => 'Aucune transaction';

  @override
  String get forThisDay => 'pour ce jour';

  @override
  String get available => 'disponible';

  @override
  String get failedToLoadBalance => 'Échec du chargement du solde';

  @override
  String get failedToLoadExpenses => 'Échec du chargement des dépenses';

  @override
  String get failedToLoadTransactions => 'Échec du chargement des transactions';

  @override
  String get signinWelcomeTitle => 'Bon retour\nparmi nous !';

  @override
  String get signinWelcomeDescription => 'Connectez-vous à votre compte';

  @override
  String get emailAddress => 'Adresse email';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get signIn => 'Se connecter';

  @override
  String get noAccountYet => 'Pas encore de compte ? ';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get or => 'ou';

  @override
  String get google => 'Google';

  @override
  String get apple => 'Apple';

  @override
  String get signInSuccess => 'Connexion réussie !';

  @override
  String get resetPassword => 'Réinitialiser le mot de passe';

  @override
  String get resetPasswordTitle => 'Créer un nouveau mot de passe';

  @override
  String get resetPasswordSubtitle =>
      'Entrez votre nouveau mot de passe pour sécuriser votre compte';

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit contenir au moins 12 caractères';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get updatePassword => 'Mettre à jour le mot de passe';

  @override
  String get passwordUpdatedSuccess => 'Mot de passe mis à jour avec succès !';

  @override
  String get redirectingToSignIn => 'Redirection vers la connexion...';

  @override
  String get passwordResetLinkExpired =>
      'Le lien de réinitialisation a expiré. Veuillez en demander un nouveau.';

  @override
  String get forgotPasswordTitle => 'Mot de passe oublié ?';

  @override
  String get forgotPasswordSubtitle =>
      'Entrez votre adresse email et nous vous enverrons un lien pour réinitialiser votre mot de passe';

  @override
  String get sendResetLink => 'Envoyer le lien';

  @override
  String get resetPasswordEmailSent => 'Lien envoyé !';

  @override
  String get resetPasswordEmailSentDescription =>
      'Nous avons envoyé un lien de réinitialisation à votre email. Veuillez vérifier votre boîte de réception et suivre les instructions.';

  @override
  String get checkYourEmail => 'Vérifiez vos emails';

  @override
  String get backToSignIn => 'Retour à la connexion';

  @override
  String get resetPasswordEmailInfo =>
      'Si vous ne recevez pas l\'email dans quelques minutes, veuillez vérifier votre dossier spam.';

  @override
  String get errorTitle => 'Erreur';

  @override
  String get unexpectedError => 'Une erreur inattendue s\'est produite';

  @override
  String get googleSignInCancelled => 'Connexion Google annulée ou échouée';

  @override
  String get appleSignInCancelled => 'Connexion Apple annulée ou échouée';

  @override
  String get emailValidationRequired => 'Veuillez saisir votre email';

  @override
  String get emailValidationInvalid => 'Veuillez saisir un email valide';

  @override
  String get emailAlreadyTaken =>
      'Cet email est déjà utilisé. Connectez-vous ou utilisez un autre email.';

  @override
  String get emailAlreadyRegistered =>
      'Un compte existe déjà avec cet email. Essayez de vous connecter.';

  @override
  String get passwordValidationRequired => 'Veuillez saisir votre mot de passe';

  @override
  String get passwordValidationMinLength =>
      'Le mot de passe doit contenir au moins 12 caractères';

  @override
  String get passwordTooWeak =>
      'Le mot de passe est trop faible. Utilisez au moins 12 caractères avec des lettres, chiffres et symboles.';

  @override
  String get signupFailed =>
      'Impossible de créer le compte. Veuillez réessayer.';

  @override
  String get signupNetworkError =>
      'Erreur de connexion. Vérifiez votre connexion internet et réessayez.';

  @override
  String get tooManyAttempts => 'Trop de tentatives de connexion';

  @override
  String rateLimitMessage(int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
    );
    return 'Veuillez réessayer dans $minutes $_temp0';
  }

  @override
  String get backButton => 'Retour';

  @override
  String get signupWelcomeTitle => 'Créer un\ncompte';

  @override
  String get signupWelcomeDescription =>
      'Rejoignez-nous et commencez votre aventure';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ? ';

  @override
  String get welcomeModalTitle => 'Bienvenue !';

  @override
  String get welcomeModalMessage => 'Ton essai Premium de 14 jours est activé';

  @override
  String get getStartedButton => 'Commencer >';

  @override
  String get confirmPasswordRequired => 'Veuillez confirmer votre mot de passe';

  @override
  String get errorLoadingUser => 'Erreur de chargement de l\'utilisateur';

  @override
  String get okButton => 'OK';

  @override
  String get monday => 'Lun';

  @override
  String get tuesday => 'Mar';

  @override
  String get wednesday => 'Mer';

  @override
  String get thursday => 'Jeu';

  @override
  String get friday => 'Ven';

  @override
  String get saturday => 'Sam';

  @override
  String get sunday => 'Dim';

  @override
  String get activeAccount => 'Compte actif';

  @override
  String get statusPremium => 'Premium';

  @override
  String get statusTrial => 'Essai';

  @override
  String get statusFree => 'Gratuit';

  @override
  String get subscriptionPlan => 'Formule';

  @override
  String get trialEnd => 'Fin de l\'essai';

  @override
  String get renewal => 'Renouvellement';

  @override
  String get unknown => 'Inconnu';

  @override
  String get daysRemaining => 'Jours restants';

  @override
  String daysRemainingCount(int count) {
    return '$count jours';
  }

  @override
  String get manageSubscription => 'Gérer l\'abonnement';

  @override
  String get trialActive => 'Essai gratuit actif';

  @override
  String get subscriptionActive => 'Abonnement actif';

  @override
  String get freeAccount => 'Compte gratuit';

  @override
  String get cannotOpenManagementPage =>
      'Impossible d\'ouvrir la page de gestion';

  @override
  String get errorOpeningSubscriptionManagement =>
      'Erreur lors de l\'ouverture de la gestion d\'abonnement';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get yesterday => 'Hier';

  @override
  String get week => 'Semaine';

  @override
  String get month => 'Mois';

  @override
  String get year => 'Année';

  @override
  String get thisWeek => 'Cette semaine';

  @override
  String get thisMonth => 'Ce mois';

  @override
  String get thisYear => 'Cette année';

  @override
  String get transactionDetails => 'Détails de la transaction';

  @override
  String get totalSpent => 'Total dépensé';

  @override
  String get budgetTotal => 'Budget total';

  @override
  String get remaining => 'Restant';

  @override
  String get totalReceived => 'Total reçu';

  @override
  String get occurrences => 'Occurrences';

  @override
  String get occurrenceHistory => 'Historique des occurrences';

  @override
  String get sinceCreation => 'Depuis la création';

  @override
  String get recurringTransaction => 'Transaction récurrente';

  @override
  String get oneTimeTransaction => 'Transaction unique';

  @override
  String get premiumFeature => 'Fonctionnalité Premium';

  @override
  String get premiumFeatureDescription =>
      'Cette fonctionnalité est disponible pour les utilisateurs Premium et Essai';

  @override
  String get premiumFeatureOnlyMembers =>
      'Disponible uniquement pour les membres Premium';

  @override
  String get premiumUnlockDescription => '';

  @override
  String get premiumBenefits => 'Avantages Premium';

  @override
  String get detailedStatistics => 'Statistiques détaillées';

  @override
  String get advancedCharts => 'Graphiques avancés';

  @override
  String get financialInsights => 'Analyses financières';

  @override
  String get unlimitedHistory => 'Historique illimité';

  @override
  String get startFreeTrial => 'Démarrer l\'essai gratuit de 14 jours';

  @override
  String get upgradeToPremium => 'Passer à Premium';

  @override
  String get trialActivated =>
      'Essai activé avec succès ! Profitez de 14 jours de fonctionnalités Premium.';

  @override
  String get errorActivatingTrial =>
      'Erreur lors de l\'activation de l\'essai. Veuillez réessayer.';

  @override
  String get comingSoon =>
      'Bientôt disponible ! Les achats in-app seront disponibles prochainement.';

  @override
  String get featureComingSoon =>
      'Cette fonctionnalité sera bientôt disponible !';

  @override
  String get onboardingStep3Title => 'Ajoutez votre première dépense';

  @override
  String get onboardingStep3Subtitle =>
      'Pour mieux comprendre comment Pocketly fonctionne.';

  @override
  String get onboardingExpenseNameLabel => 'Nom de la dépense';

  @override
  String get onboardingExpenseNameHint => 'Ex : Courses';

  @override
  String get onboardingExpenseAmountLabel => 'Montant';

  @override
  String get onboardingCategoryLabel => 'Catégorie';

  @override
  String get onboardingCategoryNeedsDescription =>
      'Loyer, courses, factures...';

  @override
  String get onboardingCategoryWantsDescription =>
      'Loisirs, sorties, shopping...';

  @override
  String get onboardingCategorySavingsDescription =>
      'Économies, investissements...';

  @override
  String get onboardingQuickSuggestions => 'Suggestions rapides';

  @override
  String get onboardingSuggestionGroceries => 'Courses';

  @override
  String get onboardingSuggestionTransport => 'Transport';

  @override
  String get onboardingSuggestionSnacks => 'Snacks';

  @override
  String get onboardingExpenseHelper =>
      'Cette dépense sera ajoutée à votre budget.';

  @override
  String get onboardingExpenseValidationError =>
      'Veuillez saisir un nom et un montant valides';

  @override
  String get onboardingCreating => 'Création en cours...';

  @override
  String get onboardingStep1IncomeTitle => 'Quel est votre revenu mensuel ?';

  @override
  String get onboardingStep1IncomeSubtitle =>
      'Cela nous permet de personnaliser automatiquement votre budget.';

  @override
  String get onboardingStep1IncomeAmountLabel => 'Montant';

  @override
  String get onboardingStep1FrequencyLabel => 'Fréquence';

  @override
  String get onboardingStep1FrequencyMonthly => 'Mensuel';

  @override
  String get onboardingStep1FrequencyWeekly => 'Hebdo';

  @override
  String get onboardingStep1FrequencyOther => 'Autre';

  @override
  String get onboardingStep1IncomeHelper =>
      'Vous pourrez modifier ce montant à tout moment.';

  @override
  String get onboardingStep1IncomeError => 'Veuillez saisir un montant valide';

  @override
  String get onboardingStep1Personalizing =>
      'Personnalisation de votre budget...';

  @override
  String get onboardingStep2Title => 'Votre budget réparti automatiquement';

  @override
  String get onboardingStep2Subtitle =>
      'Nous utilisons la règle 50/30/20 pour optimiser votre budget.';

  @override
  String get onboardingStep2Total => 'Total';

  @override
  String get onboardingStep4Title => 'Félicitations ! 🎉';

  @override
  String get onboardingStep4Subtitle =>
      'Vous êtes prêt à maîtriser votre budget !\nProfitez de 14 jours d\'essai gratuit.';

  @override
  String get onboardingStep4PremiumActivated => 'Premium activé';

  @override
  String get onboardingStep4TrialDays => '14 jours d\'essai gratuit';

  @override
  String get onboardingStep4FeatureUnlimitedBudgets => 'Budgets illimités';

  @override
  String get onboardingStep4FeatureUnlimitedBudgetsDesc =>
      'Créez autant de pockets que vous voulez';

  @override
  String get onboardingStep4FeatureDetailedAnalytics => 'Analyses détaillées';

  @override
  String get onboardingStep4FeatureDetailedAnalyticsDesc =>
      'Suivez vos dépenses en temps réel';

  @override
  String get onboardingStep4FeatureSmartNotifications =>
      'Notifications intelligentes';

  @override
  String get onboardingStep4FeatureSmartNotificationsDesc =>
      'Restez informé de vos finances';

  @override
  String get onboardingStep4Activating => 'Activation en cours...';

  @override
  String get onboardingStep4Start => 'Commencer';

  @override
  String get pockets => 'Pockets';

  @override
  String get pocketCategoryNeeds => 'Besoins';

  @override
  String get pocketCategoryWants => 'Envies';

  @override
  String get pocketCategorySavings => 'Épargne';

  @override
  String get pocketHousing => 'Logement';

  @override
  String get pocketFood => 'Alimentation';

  @override
  String get pocketTransport => 'Transport';

  @override
  String get pocketEntertainment => 'Loisirs';

  @override
  String get pocketShopping => 'Shopping';

  @override
  String get pocketEmergencyFund => 'Fonds d\'urgence';

  @override
  String get pocketVacation => 'Vacances';

  @override
  String get pocketProjects => 'Projets';

  @override
  String get savingsGoalNone => 'Aucun objectif';

  @override
  String get savingsGoalFixedAmount => 'Montant fixe';

  @override
  String get savingsGoalTargetDate => 'Objectif avec échéance';

  @override
  String get badgeBudgetExceeded => 'Budget dépassé';

  @override
  String get badgeGoalReached => 'Objectif atteint';

  @override
  String get errorPocketNameRequired => 'Le nom est requis';

  @override
  String get errorPocketNameTooLong =>
      'Le nom est trop long (max 100 caractères)';

  @override
  String get errorPocketIconRequired => 'L\'icône est requise';

  @override
  String get errorPocketInvalidColor => 'Format de couleur invalide';

  @override
  String get errorPocketBudgetNegative => 'Le budget ne peut pas être négatif';

  @override
  String get errorPocketSpentNegative =>
      'Le montant dépensé ne peut pas être négatif';

  @override
  String get errorExpensePocketCannotHaveSavings =>
      'Les pockets de dépense ne peuvent pas avoir d\'épargne';

  @override
  String get errorSavingsPocketCannotHaveBudget =>
      'Les pockets d\'épargne ne peuvent pas avoir de budget';

  @override
  String get errorPocketSavedAmountNegative =>
      'Le montant épargné ne peut pas être négatif';

  @override
  String get errorPocketMonthlySavingsNegative =>
      'L\'épargne mensuelle ne peut pas être négative';

  @override
  String get errorSavingsGoalAmountRequired => 'Le montant cible est requis';

  @override
  String get errorSavingsGoalDateRequired => 'La date cible est requise';

  @override
  String get errorSavingsGoalDatePast =>
      'La date cible doit être dans le futur';

  @override
  String get recurrenceNone => 'Aucune';

  @override
  String get recurrenceDaily => 'Quotidienne';

  @override
  String get recurrenceWeekly => 'Hebdomadaire';

  @override
  String get recurrenceBiweekly => 'Bihebdomadaire';

  @override
  String get recurrenceMonthly => 'Mensuelle';

  @override
  String get recurrenceQuarterly => 'Trimestrielle';

  @override
  String get recurrenceYearly => 'Annuelle';

  @override
  String get subscriptionPremiumTitle => 'Premium';

  @override
  String get subscriptionUnlockFeatures =>
      'Débloquez toutes les\nfonctionnalités Premium';

  @override
  String get subscriptionMonthly => 'Mensuel';

  @override
  String get subscriptionYearly => 'Annuel';

  @override
  String get subscriptionPerMonth => '/ mois';

  @override
  String get subscriptionPerYear => '/ an';

  @override
  String subscriptionEquivalent(String price) {
    return 'Soit $price / mois';
  }

  @override
  String subscriptionSavePercent(int percent) {
    return 'Économisez $percent%';
  }

  @override
  String get subscriptionBestValue => 'Meilleure valeur';

  @override
  String get subscriptionStartNow => 'Commencer maintenant';

  @override
  String get subscriptionRestore => 'Restaurer mes achats';

  @override
  String get subscriptionFeaturesTitle => 'Tout ce que vous obtenez :';

  @override
  String get subscriptionFeatureAdvancedStats => 'Statistiques avancées';

  @override
  String get subscriptionFeatureAdvancedStatsDesc =>
      'Analysez vos dépenses en profondeur';

  @override
  String get subscriptionFeatureUnlimitedPockets => 'Pockets illimités';

  @override
  String get subscriptionFeatureUnlimitedPocketsDesc =>
      'Créez autant de pockets que vous voulez';

  @override
  String get subscriptionFeatureDataExport => 'Export de données';

  @override
  String get subscriptionFeatureDataExportDesc =>
      'Exportez vos données en CSV ou PDF';

  @override
  String get subscriptionFeaturePrioritySupport => 'Support prioritaire';

  @override
  String get subscriptionFeaturePrioritySupportDesc =>
      'Assistance rapide et personnalisée';

  @override
  String get subscriptionFeatureCloudSync => 'Synchronisation cloud';

  @override
  String get subscriptionFeatureCloudSyncDesc =>
      'Accédez à vos données partout';

  @override
  String get subscriptionFeatureSmartReminders => 'Rappels intelligents';

  @override
  String get subscriptionFeatureSmartRemindersDesc =>
      'Ne dépassez plus jamais votre budget';

  @override
  String get subscriptionTermsAndConditions =>
      'En continuant, vous acceptez nos Conditions d\'utilisation\net notre Politique de confidentialité';

  @override
  String get subscriptionPurchasing => 'Traitement de votre achat...';

  @override
  String get subscriptionRestoring => 'Restauration des achats...';

  @override
  String get subscriptionPurchaseSuccess =>
      'Abonnement activé avec succès ! 🎉';

  @override
  String get subscriptionRestoreSuccess => 'Achats restaurés avec succès !';

  @override
  String subscriptionPurchaseError(String error) {
    return 'Erreur lors de l\'achat : $error';
  }

  @override
  String subscriptionRestoreError(String error) {
    return 'Erreur lors de la restauration : $error';
  }

  @override
  String get freeTrialTitle => 'Commencez votre essai gratuit';

  @override
  String get freeTrialDuration => '14 jours gratuits';

  @override
  String get freeTrialStartButton => 'Commencer l\'essai gratuit de 14 jours';

  @override
  String get freeTrialDescription =>
      'Essayez toutes les fonctionnalités Premium\npendant 14 jours, sans paiement';

  @override
  String get freeTrialActive => 'Essai actif';

  @override
  String freeTrialDaysLeft(int days) {
    return '$days jours restants';
  }

  @override
  String get freeTrialExpired => 'Essai expiré';

  @override
  String get freeTrialActivating => 'Activation de votre essai gratuit...';

  @override
  String get freeTrialActivationSuccess =>
      'Essai gratuit activé ! Profitez de 14 jours Premium 🎉';

  @override
  String freeTrialActivationError(String error) {
    return 'Erreur lors de l\'activation : $error';
  }

  @override
  String get freeTrialAlreadyUsed =>
      'Vous avez déjà utilisé votre essai gratuit';

  @override
  String get subscriptionAfterTrial => 'Après l\'essai';

  @override
  String get subscriptionContinueWithPremium => 'Continuer avec Premium';

  @override
  String get all => 'Tous';

  @override
  String get noPocketsYet => 'Aucun pocket pour le moment';

  @override
  String get createFirstPocket => 'Créez votre premier pocket pour commencer';

  @override
  String get noPocketsInCategory => 'Aucun pocket dans cette catégorie';

  @override
  String get createDefaultPockets => 'Créer les pockets par défaut';

  @override
  String get addTransactionLogo => 'Ajouter un logo';

  @override
  String get chooseLogoSource =>
      'Choisissez une source de logo pour votre transaction';

  @override
  String get photoLibrary => 'Galerie photo';

  @override
  String get searchBrandLogo => 'Rechercher un logo de marque';

  @override
  String get selectBrand => 'Sélectionner une marque';

  @override
  String get information => 'Informations';

  @override
  String get type => 'Type';

  @override
  String get notes => 'Notes';

  @override
  String get image => 'Image';

  @override
  String get expense => 'Dépense';

  @override
  String get income => 'Revenu';

  @override
  String get assigned => 'Assigné';

  @override
  String get deleteTransactionTitle => 'Supprimer la transaction';

  @override
  String get deleteTransactionMessage =>
      'Êtes-vous sûr de vouloir supprimer cette transaction ? Cette action est irréversible.';

  @override
  String get transactionDeletedSuccess => 'Transaction supprimée avec succès';

  @override
  String get transactionDeleteError => 'Impossible de supprimer la transaction';

  @override
  String get recurrence => 'Récurrence';

  @override
  String get deletePocketTitle => 'Supprimer le pocket';

  @override
  String get deletePocketMessage =>
      'Êtes-vous sûr de vouloir supprimer ce pocket ? Cette action est irréversible.';

  @override
  String get pocketDeletedSuccess => 'Pocket supprimé avec succès';

  @override
  String get pocketDeleteError => 'Impossible de supprimer le pocket';

  @override
  String get notifications => 'Notifications';

  @override
  String get notificationsCenter => 'Centre de notifications';

  @override
  String get notificationsSettings => 'Paramètres des notifications';

  @override
  String get notificationType => 'Type de notification';

  @override
  String get notificationTypes => 'Types de notifications';

  @override
  String get budgetExceededNotif => 'Dépassement de budget';

  @override
  String get budgetExceededNotifDesc =>
      'Être alerté quand un budget de pocket est dépassé';

  @override
  String get goalReachedNotif => 'Objectif atteint';

  @override
  String get goalReachedNotifDesc =>
      'Recevoir une notification quand un objectif d\'épargne est atteint';

  @override
  String get monthEndReminderNotif => 'Rappel fin de mois';

  @override
  String get monthEndReminderNotifDesc => 'Recevoir un rappel à la fin du mois';

  @override
  String get weeklySummaryNotif => 'Résumé hebdomadaire';

  @override
  String get weeklySummaryNotifDesc =>
      'Recevoir un résumé de vos finances chaque semaine';

  @override
  String get monthlyReportNotif => 'Rapport mensuel';

  @override
  String get monthlyReportNotifDesc =>
      'Recevoir un rapport détaillé chaque mois';

  @override
  String get markAsRead => 'Marquer comme lu';

  @override
  String get markAsUnread => 'Marquer comme non lu';

  @override
  String get markAllAsRead => 'Tout marquer comme lu';

  @override
  String get deleteNotification => 'Supprimer la notification';

  @override
  String get deleteAllNotifications => 'Tout supprimer';

  @override
  String get noNotifications => 'Aucune notification';

  @override
  String get noNotificationsMessage =>
      'Vous n\'avez aucune notification pour le moment';

  @override
  String get unreadNotifications => 'Non lues';

  @override
  String get readNotifications => 'Lues';

  @override
  String get allNotifications => 'Toutes';

  @override
  String get notificationRead => 'Lu';

  @override
  String get notificationUnread => 'Non lu';

  @override
  String get notificationDeletedSuccess => 'Notification supprimée';

  @override
  String get notificationDeleteError =>
      'Impossible de supprimer la notification';

  @override
  String get notificationsPreferences => 'Préférences de notifications';

  @override
  String get enableNotificationsPrompt =>
      'Activer les notifications pour ne rien manquer';

  @override
  String get createPocket => 'Créer un Pocket';

  @override
  String get addNeedsPocket => 'Ajouter un Pocket Besoins';

  @override
  String get addWantsPocket => 'Ajouter un Pocket Envies';

  @override
  String get addSavingsPocket => 'Ajouter un Pocket Épargne';

  @override
  String get selectPocketCategory => 'Sélectionner une Catégorie';

  @override
  String get selectPocketCategoryDescription =>
      'Choisissez le type de pocket que vous souhaitez créer selon la règle 50/30/20';

  @override
  String get needsDescription =>
      'Dépenses essentielles comme le logement, la nourriture et le transport';

  @override
  String get wantsDescription =>
      'Dépenses discrétionnaires comme les loisirs, hobbies et achats plaisir';

  @override
  String get savingsDescription =>
      'Argent mis de côté pour les objectifs futurs, urgences et investissements';

  @override
  String get pocketName => 'Nom du Pocket';

  @override
  String get pocketNameHint => 'ex: Courses, Loyer, Vacances';

  @override
  String get savingsPocketNameHint =>
      'ex: Fonds d\'urgence, Vacances, Nouvelle voiture';

  @override
  String get monthlyBudget => 'Budget Mensuel';

  @override
  String get monthlySavingsAmount => 'Montant d\'Épargne Mensuel';

  @override
  String get monthlySavingsHint => 'Épargne mensuelle automatique optionnelle';

  @override
  String get targetAmount => 'Montant Cible';

  @override
  String get targetDate => 'Date Cible';

  @override
  String get selectTargetDate => 'Sélectionner une date cible';

  @override
  String get savingsGoalType => 'Type d\'Objectif d\'Épargne';

  @override
  String get savingsGoalNoneDescription =>
      'Épargne simple sans objectif spécifique';

  @override
  String get savingsGoalFixedAmountDescription =>
      'Épargner jusqu\'à atteindre un montant spécifique';

  @override
  String get savingsGoalTargetDateDescription =>
      'Atteindre un objectif à une date spécifique';

  @override
  String get selectIcon => 'Sélectionner une Icône';

  @override
  String get selectColor => 'Sélectionner une Couleur';

  @override
  String get errorBudgetRequired => 'Le budget est requis';

  @override
  String get errorCreatingPocket => 'Erreur lors de la création du pocket';

  @override
  String get pocketDetails => 'Détails du Pocket';

  @override
  String get editPocket => 'Modifier le Pocket';

  @override
  String get pocketNotFound => 'Pocket introuvable';

  @override
  String get pocketNotFoundMessage =>
      'Ce pocket n\'existe pas ou a été supprimé';

  @override
  String get defaultPocketNameCannotBeModified =>
      'Le nom des pockets par défaut ne peut pas être modifié';

  @override
  String get savingsGoal => 'Objectif d\'épargne';

  @override
  String get targetAmountLabel => 'Montant de l\'objectif';

  @override
  String get invalidAmount => 'Montant invalide';

  @override
  String get category => 'Catégorie';

  @override
  String get nonEditable => '(Non modifiable)';

  @override
  String get saving => 'Enregistrement...';

  @override
  String get assignTransactions => 'Assigner des transactions';

  @override
  String assignTransactionsTo(String pocketName) {
    return 'Assigner à $pocketName';
  }

  @override
  String get searchTransaction => 'Rechercher une transaction...';

  @override
  String get noExpensesAvailable => 'Aucune dépense disponible';

  @override
  String get noExpensesFound => 'Aucune dépense trouvée';

  @override
  String get createExpenseTransactionsFirst =>
      'Créez d\'abord des transactions de dépenses';

  @override
  String get tryOtherKeywords => 'Essayez avec d\'autres mots-clés';

  @override
  String get alreadyAssignedToOtherPocket => 'Déjà assignée à un autre pocket';

  @override
  String get assignedToThisPocket =>
      'Assignée à ce pocket (décochez pour retirer)';

  @override
  String transactionsToAssignAndRemove(int toAssign, int toRemove) {
    return '$toAssign à assigner, $toRemove à retirer';
  }

  @override
  String transactionsToAssign(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count transaction$_temp0 à assigner';
  }

  @override
  String transactionsToRemove(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count transaction$_temp0 à retirer';
  }

  @override
  String get modifyingInProgress => 'Modification en cours...';

  @override
  String get validateModifications => 'Valider les modifications';

  @override
  String get transactionNotFound => 'Transaction introuvable';

  @override
  String transactionsAssignedAndRemoved(int assigned, int removed) {
    String _temp0 = intl.Intl.pluralLogic(
      assigned,
      locale: localeName,
      other: 's assignées',
      one: ' assignée',
    );
    String _temp1 = intl.Intl.pluralLogic(
      removed,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$assigned transaction$_temp0, $removed retirée$_temp1';
  }

  @override
  String transactionsAssigned(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's assignées',
      one: ' assignée',
    );
    return '$count transaction$_temp0';
  }

  @override
  String transactionsRemoved(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's retirées',
      one: ' retirée',
    );
    return '$count transaction$_temp0';
  }

  @override
  String get active => 'Actif';

  @override
  String get inactive => 'Inactif';

  @override
  String get defaultLabel => 'Par défaut';

  @override
  String get budget => 'Budget';

  @override
  String get spent => 'Dépensé';

  @override
  String get progress => 'Progression';

  @override
  String get savings => 'Épargne';

  @override
  String get savedAmount => 'Montant épargné';

  @override
  String get goal => 'Objectif';

  @override
  String get progression => 'Progression';

  @override
  String get addCategory => 'Ajouter une catégorie';

  @override
  String get more => 'Plus';

  @override
  String get categories => 'Catégories';

  @override
  String get defaultCategories => 'Catégories par Défaut';

  @override
  String get customCategories => 'Catégories Personnalisées';

  @override
  String get custom => 'Personnalisée';

  @override
  String get defaultCategory => 'Par défaut';

  @override
  String get createCategory => 'Créer une Catégorie';

  @override
  String get editCategory => 'Modifier la Catégorie';

  @override
  String get updateCategory => 'Mettre à Jour la Catégorie';

  @override
  String get deleteCategory => 'Supprimer la Catégorie';

  @override
  String get categoryName => 'Nom de la Catégorie';

  @override
  String get categoryNameHint => 'ex: Épicerie, Loyer, Factures';

  @override
  String get categoryType => 'Type de Catégorie';

  @override
  String get expenses => 'Dépenses';

  @override
  String get incomes => 'Revenus';

  @override
  String get expenseCategory => 'Catégorie de Dépense';

  @override
  String get incomeCategory => 'Catégorie de Revenu';

  @override
  String get expenseCategoryDescription =>
      'Suivez vos dépenses et gérez votre budget';

  @override
  String get incomeCategoryDescription =>
      'Suivez vos revenus et sources de revenus';

  @override
  String get noCategoriesFound => 'Aucune Catégorie Trouvée';

  @override
  String get noCategoriesFoundDescription =>
      'Créez votre première catégorie personnalisée pour commencer';

  @override
  String get premiumRequired => 'Premium Requis';

  @override
  String get premiumRequiredForCustomCategories =>
      'Abonnement Premium requis pour créer des catégories personnalisées';

  @override
  String get errorCategoryNameRequired => 'Le nom de la catégorie est requis';

  @override
  String get errorCategoryNameTooLong =>
      'Le nom de la catégorie doit faire moins de 50 caractères';

  @override
  String get errorCreatingCategory => 'Échec de la création de la catégorie';

  @override
  String get errorUpdatingCategory =>
      'Échec de la modification de la catégorie';

  @override
  String get errorDeletingCategory => 'Échec de la suppression de la catégorie';

  @override
  String get categoryCreatedSuccess => 'Catégorie créée avec succès';

  @override
  String get categoryUpdatedSuccess => 'Catégorie mise à jour avec succès';

  @override
  String get categoryDeletedSuccess => 'Catégorie supprimée avec succès';

  @override
  String get deleteCategoryConfirmation =>
      'Êtes-vous sûr de vouloir supprimer cette catégorie ? Cette action est irréversible.';

  @override
  String get noCustomCategoriesYet => 'Aucune Catégorie Personnalisée';

  @override
  String get noCustomCategoriesYetDescription =>
      'Créez votre première catégorie personnalisée pour mieux organiser vos finances';

  @override
  String get noCustomCategoriesPremium =>
      'Débloquez les Catégories Personnalisées';

  @override
  String get noCustomCategoriesPremiumDescription =>
      'Passez à Premium pour créer des catégories personnalisées illimitées';

  @override
  String get createFirstCategory => 'Créer la Première Catégorie';

  @override
  String get deleteAccount => 'Supprimer le Compte et les Données';

  @override
  String get deleteAccountConfirmTitle => 'Supprimer le Compte ?';

  @override
  String get deleteAccountConfirmMessage =>
      'Vous allez supprimer votre compte. Êtes-vous sûr ?';

  @override
  String get deleteAccountConfirmButton => 'Oui, supprimer';

  @override
  String get deleteAccountCancel => 'Non, garder';

  @override
  String get deleteAccountDataTransactions => 'Toutes les transactions';

  @override
  String get deleteAccountDataCategories =>
      'Toutes les catégories personnalisées';

  @override
  String get deleteAccountDataPockets => 'Tous les pockets';

  @override
  String get deleteAccountDataSettings => 'Tous les paramètres';

  @override
  String get deleteAccountIrreversible => 'Cette action est IRRÉVERSIBLE.';

  @override
  String get accountDeleted => 'Compte supprimé avec succès';

  @override
  String get errorDeletingAccount => 'Échec de la suppression du compte';

  @override
  String get legalNotice => 'Mentions Légales';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get termsOfUse => 'Conditions Générales d\'Utilisation';

  @override
  String get legal => 'Légal';

  @override
  String get about => 'À propos';

  @override
  String get aboutApp => 'À propos de l\'app';

  @override
  String get aboutAppTitle => 'Pocketly';

  @override
  String get aboutAppDescription =>
      'Une application simple et intuitive pour visualiser vos dépenses par semaine et par mois, et économiser intelligemment avec la méthode 50/30/20.';

  @override
  String get aboutFeatureWeeklyView =>
      'Visualisation rapide des dépenses hebdomadaires';

  @override
  String get aboutFeatureMonthlyTracking => 'Suivi mensuel détaillé';

  @override
  String get aboutFeature503020 => 'Économiser avec la méthode 50/30/20';

  @override
  String get aboutCreator => 'Créé avec ❤️ par Minhaj';

  @override
  String get visitWebsite => 'Visiter le site web';

  @override
  String get close => 'Fermer';

  @override
  String get errorEmailRequired => 'L\'email est requis';

  @override
  String get errorPasswordRequired => 'Le mot de passe est requis';

  @override
  String get errorPasswordMinLength =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get errorInvalidAmount => 'Montant invalide';

  @override
  String get errorAmountNegative => 'Le montant ne peut pas être négatif';

  @override
  String get errorAmountPositive => 'Le montant doit être positif';

  @override
  String get errorTransactionNameRequired =>
      'Le nom de la transaction est requis';

  @override
  String get errorUserNotAuthenticated => 'Utilisateur non authentifié';

  @override
  String get errorNetworkConnection => 'Erreur de connexion réseau';

  @override
  String get errorServerError => 'Erreur serveur';

  @override
  String get errorCacheOperation => 'Erreur de cache';

  @override
  String get errorCategoryNotFound => 'Catégorie non trouvée';

  @override
  String get errorInvalidData => 'Données invalides';

  @override
  String get errorSaveFailed => 'Échec de la sauvegarde';

  @override
  String get errorLoadFailed => 'Échec du chargement';

  @override
  String get errorDeleteFailed => 'Échec de la suppression';

  @override
  String get errorInitializationFailed => 'Échec de l\'initialisation';

  @override
  String get onboardingErrorTitle => 'Attention';

  @override
  String get onboardingErrorIncomeSave =>
      'Une erreur est survenue lors de la sauvegarde de votre revenu. Vous pourrez le modifier plus tard.';

  @override
  String get onboardingErrorPocketsCreate =>
      'Une erreur est survenue lors de la création de vos pockets. Vous pourrez les créer plus tard.';

  @override
  String get onboardingErrorFinalization =>
      'Une erreur est survenue lors de la finalisation de l\'onboarding.';

  @override
  String get onboardingErrorGeneric => 'Une erreur est survenue';
}
