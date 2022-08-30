//
//  Constants.swift
//  thinkapp-ios
//
//  Created by Александр Гужавин on 30.08.2022.
//

import Foundation
import UIKit


enum BaseColor {
    case black
    case gray
    case yellow
    case pink
    case darckBlue
    
    var path: UIColor {
        switch self {
        case .black:
            return UIColor(hex: "#404756")
        case .gray:
            return UIColor(hex: "#E9EFFF")
        case .yellow:
            return UIColor(hex: "#FFCD93")
        case .pink:
            return UIColor(hex: "#FA9490")
        case .darckBlue:
            return UIColor(hex: "#56669D")
        }
    }
}

enum BaseFont {
    case syneBolt(CGFloat)
    case syneRegular(CGFloat)
    case interRegulat(CGFloat)
    case interMedium(CGFloat)
    
    var path: UIFont {
        switch self {
        case .syneBolt(let size):
            return UIFont(name: "Syne-Bold", size: size)!
        case .syneRegular(let size):
            return UIFont(name: "Syne-Regular", size: size)!
        case .interRegulat(let size):
            return UIFont(name: "Inter-Regular", size: size)!
        case .interMedium(let size):
            return UIFont(name: "Inter-Medium", size: size)!
        }
    }
    
}

