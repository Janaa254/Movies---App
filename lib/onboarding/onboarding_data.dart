import '../l10n/app_localizations.dart';
import 'onboarding_model.dart';

List<OnboardingModel> getOnboardingData(
    AppLocalizations l10n,
    ) {
  return [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: l10n.onboardingTitle1,
      description: l10n.onboardingDescription1,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: l10n.onboardingTitle2,
      description: l10n.onboardingDescription2,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: l10n.onboardingTitle3,
      description: l10n.onboardingDescription3,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding4.png',
      title: l10n.onboardingTitle4,
      description: l10n.onboardingDescription4,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding5.png',
      title: l10n.onboardingTitle5,
      description: l10n.onboardingDescription5,
    ),

    OnboardingModel(
      image: 'assets/images/onboarding6.png',
      title: l10n.onboardingTitle6,
      description: '',
    ),
  ];
}