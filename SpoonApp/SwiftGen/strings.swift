// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Cheap
  internal static let cheap = L10n.tr("Localizable", "Cheap")
  /// Dairy Free
  internal static let dairyFree = L10n.tr("Localizable", "DairyFree")
  /// Details
  internal static let detailstitleVC = L10n.tr("Localizable", "DetailstitleVC")
  /// Error
  internal static let errorAlert = L10n.tr("Localizable", "ErrorAlert")
  /// Favourites
  internal static let favouritesTitleVC = L10n.tr("Localizable", "FavouritesTitleVC")
  /// Gluten Free
  internal static let glutenFree = L10n.tr("Localizable", "GlutenFree")
  /// Menu
  internal static let menuTitleVC = L10n.tr("Localizable", "MenuTitleVC")
  /// Detail
  internal static let moreButton = L10n.tr("Localizable", "MoreButton")
  /// Recipe
  internal static let recipeTitleVC = L10n.tr("Localizable", "RecipeTitleVC")
  /// Sustainable
  internal static let sustainable = L10n.tr("Localizable", "Sustainable")
  /// Vegan
  internal static let vegan = L10n.tr("Localizable", "Vegan")
  /// Vegetarian
  internal static let vegetarian = L10n.tr("Localizable", "Vegetarian")
  /// Very Healthy
  internal static let veryHealthy = L10n.tr("Localizable", "VeryHealthy")
  /// Very Popular
  internal static let veryPopular = L10n.tr("Localizable", "VeryPopular")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
