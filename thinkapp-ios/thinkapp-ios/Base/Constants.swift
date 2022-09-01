//
//  Constants.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 30.08.2022.
//

import Foundation
import UIKit


enum BaseColor {
    static let black = UIColor(hex: "#404756")
    static let gray = UIColor(hex: "#E9EFFF")
    static let yellow = UIColor(hex: "#FFCD93")
    static let pink = UIColor(hex: "#FA9490")
    static let darckBlue = UIColor(hex: "#56669D")
}

enum BaseFont {
    static func syneBolt(with size: CGFloat) -> UIFont { UIFont(name: "Syne-Bold", size: size)! }
    static func syneRegular(with size: CGFloat) -> UIFont { UIFont(name: "Syne-Regular", size: size)! }
    static func interRegulat(with size: CGFloat) -> UIFont { UIFont(name: "Inter-Regular", size: size)! }
    static func interMedium(with size: CGFloat) -> UIFont { UIFont(name: "Inter-Medium", size: size)! }
}

