//
//  MapMarkResponce.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 16/09/22.
//

import Foundation

struct MapMark: Codable {
    var location: Location
    var gender: String
    var age: String
    var text: String
}

struct Location: Codable {
    var lat: String
    var lon: String
}
