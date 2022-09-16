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
    static func getMapMarker(success: @escaping ([MapMark]) -> Void, failure: @escaping escapeNetworkError) {
        let params: Parameters = [:]
        
        BaseAPI.authorizedGetRequest(reqMethod: .mapMarker, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                var mapMarks = [MapMark]()
                for mark in jsonData["result"].arrayValue {
                    mapMarks.append(MapMark(locationLat: mark["location"]["lat"].stringValue,
                                            locationLon: mark["location"]["lot"].stringValue,
                                            gender: mark["gender"].stringValue,
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


