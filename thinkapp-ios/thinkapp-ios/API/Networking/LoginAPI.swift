//
//  LoginAPI.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 16/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class LoginAPI {
    
    static func loginWithEmailCode(email: String, code: String, success: @escaping escapeJSON, failure: @escaping escapeNetworkError) {
        let params: Parameters = [
            "email": "\(email)",
            "code": "\(code)"
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .registerVeri, parameters: params, success: { data in
            guard let data = data else { return }
            let jsonData = JSON(data)
            let errors = jsonData["errors"]
            if errors.type == .null {
                let token = jsonData["api_token"]["plainTextToken"].stringValue
                UserDefaultsService.sharedInstance.authToken = token
                success(jsonData["result"])
            } else {
                failure(NetworkError(.other(errors.stringValue)))
            }
        }) { error in
            failure(error)
        }
    }
    
    static func sendCodeEmail(email: String, success: @escaping escapeJSON, failture: @escaping escapeNetworkError) {
        let params: Parameters = [
            "email": "\(email)"
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .registerGetCode, parameters: params, success: { data in
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
    
    static func fireLogin(token: String, success: @escaping escapeJSON, failture: @escaping escapeNetworkError) {
        
        let params: Parameters = [
            "token": token
        ]
        
        BaseAPI.unAuthorizedPostRequest(reqMethod: .fireLogin, parameters: params, success: { data in
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
}
