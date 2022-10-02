//
//  UserGender.swift
//  thinkapp-ios
//
//  Created by user1 on 23/09/22.
//

import UIKit

enum Gender {
    case male, female, none
    
    var title: String {
        switch self {
        case .male: return "Male"
        case .female: return "Female"
        case .none: return "None"
        }
    }
    
    var key: String? {
        switch self {
        case .male: return "male"
        case .female: return "female"
        case .none: return nil
        }
    }
}
