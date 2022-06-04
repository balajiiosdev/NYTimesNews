//
//  UIFont+DynamicSize.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/3/22.
//

import Foundation
import UIKit

let customFonts: [UIFont.TextStyle: UIFont] = [
    .largeTitle: UIFont(name: "Lato-Bold", size: 34) ?? UIFont.preferredFont(forTextStyle: .largeTitle),
    .title1: UIFont(name: "Lato-Bold", size: 28) ?? UIFont.preferredFont(forTextStyle: .title1),
    .title2: UIFont(name: "Lato-Bold", size: 22) ?? UIFont.preferredFont(forTextStyle: .title2),
    .title3: UIFont(name: "Lato-Bold", size: 20) ?? UIFont.preferredFont(forTextStyle: .title3),
    .headline: UIFont(name: "Lato-Bold", size: 17) ?? UIFont.preferredFont(forTextStyle: .headline),
    .body: UIFont(name: "Lato-Regular", size: 17) ?? UIFont.preferredFont(forTextStyle: .body),
    .callout: UIFont(name: "Lato-Regular", size: 16) ?? UIFont.preferredFont(forTextStyle: .callout),
    .subheadline: UIFont(name: "Lato-Regular", size: 15) ?? UIFont.preferredFont(forTextStyle: .subheadline),
    .footnote: UIFont(name: "Lato-Regular", size: 13) ?? UIFont.preferredFont(forTextStyle: .footnote),
    .caption1: UIFont(name: "Lato-SemiboldItalic", size: 12) ?? UIFont.preferredFont(forTextStyle: .caption1),
    .caption2: UIFont(name: "Lato-SemiboldItalic", size: 11) ?? UIFont.preferredFont(forTextStyle: .caption2)
]

extension UIFont {
    class func customFont(forTextStyle style: UIFont.TextStyle) -> UIFont {
        let customFont = customFonts[style]!
        let metrics = UIFontMetrics(forTextStyle: style)
        let scaledFont = metrics.scaledFont(for: customFont)
        return scaledFont
    }
}
