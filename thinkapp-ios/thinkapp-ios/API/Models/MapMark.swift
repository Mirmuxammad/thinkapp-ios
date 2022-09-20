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
    var lat: Double
    var lon: Double
}

struct MapMarkResponce {
    var id: Int
    var user: User
    var location: Location
    var age: String
    var gender: String
    var text: String
}
