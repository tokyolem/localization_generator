import 'app_localization.public_pages_localization.dart';
import 'app_localization.client_pages_localization.dart';

final class $InnovorgClientLocalizationConfig {
  final Map<String, Map<String, String>> localizationPages;

  const $InnovorgClientLocalizationConfig({required this.localizationPages});

  $CommonLocalization get commonLocalization =>
      $CommonLocalization(localizationPages['common'] ?? <String, String>{});

  $MainMenuLocalization get mainMenuLocalization => $MainMenuLocalization(
      localizationPages['main_menu'] ?? <String, String>{});

  $DashboardLocalization get dashboardLocalization => $DashboardLocalization(
      localizationPages['dashboard'] ?? <String, String>{});

  $EditProfileLocalization get editProfileLocalization =>
      $EditProfileLocalization(
          localizationPages['edit_profile'] ?? <String, String>{});

  $LearningMenuLocalization get learningMenuLocalization =>
      $LearningMenuLocalization(
          localizationPages['learning_menu'] ?? <String, String>{});

  $LearningResourceDetailsLocalization
      get learningResourceDetailsLocalization =>
          $LearningResourceDetailsLocalization(
              localizationPages['learning_resource_details'] ??
                  <String, String>{});

  $LearningPathDetailsLocalization get learningPathDetailsLocalization =>
      $LearningPathDetailsLocalization(
          localizationPages['learning_path_details'] ?? <String, String>{});

  $LearningCampaignDetailsLocalization
      get learningCampaignDetailsLocalization =>
          $LearningCampaignDetailsLocalization(
              localizationPages['learning_campaign_details'] ??
                  <String, String>{});

  $BrowseResourcesLocalization get browseResourcesLocalization =>
      $BrowseResourcesLocalization(
          localizationPages['browse_resources'] ?? <String, String>{});

  $BrowseResourcesSortingLocalization get browseResourcesSortingLocalization =>
      $BrowseResourcesSortingLocalization(
          localizationPages['browse_resources_sorting'] ?? <String, String>{});

  $BrowseResourcesFiltersLocalization get browseResourcesFiltersLocalization =>
      $BrowseResourcesFiltersLocalization(
          localizationPages['browse_resources_filters'] ?? <String, String>{});

  $BrowsePathsFiltersLocalization get browsePathsFiltersLocalization =>
      $BrowsePathsFiltersLocalization(
          localizationPages['browse_paths_filters'] ?? <String, String>{});

  $SettingsLocalization get settingsLocalization => $SettingsLocalization(
      localizationPages['settings'] ?? <String, String>{});

  $SupportLocalization get supportLocalization =>
      $SupportLocalization(localizationPages['support'] ?? <String, String>{});
}

final class $InnovorgPublicLocalizationConfig {
  final Map<String, Map<String, String>> localizationPages;

  const $InnovorgPublicLocalizationConfig({required this.localizationPages});

  $ResetPasswordLocalization get resetPasswordLocalization =>
      $ResetPasswordLocalization(
          localizationPages['reset_password'] ?? <String, String>{});

  $LoginLocalization get loginLocalization =>
      $LoginLocalization(localizationPages['login'] ?? <String, String>{});
}
