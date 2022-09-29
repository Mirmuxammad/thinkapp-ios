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
    
    static func getMapMarker(success: @escaping ([MapMarkResponce]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .mapMarker, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var mapMarks = [MapMarkResponce]()
                for mark in jsonData["data"].arrayValue {
                    mapMarks.append(MapMarkResponce(id: mark["id"].intValue, user: User(id: mark["user"]["id"].intValue, name: mark["user"]["name"].stringValue, online: mark["user"]["online"].boolValue), location: Location(lat: mark["location"]["lat"].doubleValue, lon: mark["location"]["lon"].doubleValue), age: mark["age"].stringValue, gender: mark["gender"].stringValue, text: mark["text"].stringValue))
                }
                print("⚡️")
                print(mapMarks)
                success(mapMarks)
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func searchMarks(location: Location, gender: String?, ageFrom: Double?, ageMin: Double?, maxDisatance: Double, success: @escaping ([MapMarkResponce]) -> Void, failture: @escaping escapeNetworkError) {
        let params: Parameters = [
            "location": [
                "lat": location.lat,
                "lon": location.lon,
            ],
            "gender": gender,
            "age_from": ageFrom,
            "age_min": ageMin,
            "max_distance": maxDisatance
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .searchMark, parameters: params) { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var searchMarks = [MapMarkResponce]()
                for mark in jsonData["data"].arrayValue {
                    searchMarks.append(MapMarkResponce(id: mark["id"].intValue, user: User(id: mark["user"]["id"].intValue, name: mark["user"]["name"].stringValue, online: mark["user"]["online"].boolValue), location: Location(lat: mark["location"]["lat"].doubleValue, lon: mark["location"]["lon"].doubleValue), age: mark["age"].stringValue, gender: mark["gender"].stringValue, text: mark["text"].stringValue))
                }
                success(searchMarks)
            } else {
                failture(NetworkError(.other(errors.stringValue)))
            }
        } failure: { error in
            failture(error)

        }
    }
    
    
}


