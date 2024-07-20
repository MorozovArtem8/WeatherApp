import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: bundleForLocalizedTexts, value: "", comment: "\(self) could not be found in Localized.strings")
    }
}

