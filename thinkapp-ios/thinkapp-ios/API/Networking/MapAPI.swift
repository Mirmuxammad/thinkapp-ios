//
//  MapAPI.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 16/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias escapeJSON = (JSON?) -> Void
typealias escapeNetworkError = (NetworkError?) -> Void

final class MapAPI {
    
    static func postMapMark(location: Location, gender: String, age: String, text: String, success: @escaping (JSON) -> Void, failture: @escaping escapeNetworkError) {
        let params: Parameters = [
            "location": [
                "lat": location.lat,
                "lon": location.lon,
            ],
            "gender": gender,
            "age": age,
            "text": text
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .mapMarker, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                success(jsonData["result"])
            } else {
                failture(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failture(error)
        }
    }
    
    static func getMapMarker(success: @escaping ([MapMark]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .mapMarker, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var mapMarks = [MapMark]()
                for mark in jsonData["result"].arrayValue {
                    mapMarks.append(MapMark(location: Location(lat: mark["location"]["lat"].stringValue, lon: mark["location"]["lot"].stringValue), gender: mark["gender"].stringValue,
                                            age: mark["age"].stringValue,
                                            text: mark["text"].stringValue))
                }
                success(mapMarks)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    
}


