//  Created by Artem Morozov on 20.07.2024.

import Foundation

#if DEBUG
var bundleForLocalizedTexts: Bundle = .main
#else
let bundleForLocalizedTexts: Bundle = .main
#endif
