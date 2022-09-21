//
//  BaseAPI.swift
//  thinkapp-ios
//
//  Created by MIrmuxammad on 16/09/22.
//

import Foundation
import Alamofire
import SwiftyJSON

enum RequestMethod {
    case mapMarker
    case registerGetCode
    case registerVeri
    case fireLogin
    
    var path: String {
        switch self {
        case .mapMarker:
            return "point"
        case .registerGetCode:
            return "auth/register/code"
        case .registerVeri:
            return "auth/register"
        case .fireLogin:
            return "firebase/login"
        }
    }
}

final class BaseAPI {
    static var baseURL: String = "https://sv.tomythink.com"
    static var baseAPIURL: String = "https://sv.tomythink.com/api/"
    static let authorizedSession = Session(interceptor: RequestInterceptor())
    
    private let headers: HTTPHeaders = {
        var headers = ["Accept": "application/json"]
        return HTTPHeaders(headers)
    }()
    
    fileprivate static func request(reqMethod: RequestMethod,
                                    parameters: Parameters,
                                    method: HTTPMethod,
                                    success: @escaping (Data?) -> Void,
                                    failure: @escaping (NetworkError?) -> Void) {
        var headers = BaseAPI().headers
        
        if let token = UserDefaultsService.sharedInstance.authToken {
            headers.add(.authorization(bearerToken: token))
        }
        
        var encoding: ParameterEncoding!
        switch method {
        case .get:
            encoding = URLEncoding.default
            break
        case .post, .put, .delete:
            encoding = JSONEncoding.default
            break
        default:
            encoding = URLEncoding.default
            break
        }
        
        authorizedSession.request(URL(string: BaseAPI.baseAPIURL + reqMethod.path)!, method: method, parameters: parameters, encoding: encoding, headers: headers).response { response in
            debugPrint(response)
            print("ReqMethod: \(reqMethod)\nJSON Status: \(String(describing: response.response?.statusCode))\nResponse:", JSON(response.data ?? ""))
            if let data = response.data {
                success(data)
            } else {
                failure(NetworkError(.server, code: response.response?.statusCode))
            }
        }
    }
    // MARK: GET Requests
    
    static func authorizedGetRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .get, success: success, failure: failure)
    }
    
    // MARK: POST Requests
    
    static func unAuthorizedPostRequest(reqMethod: RequestMethod, parameters: Parameters, success: @escaping (Data?) -> Void, failure: @escaping (NetworkError?) -> Void) {
        request(reqMethod: reqMethod, parameters: parameters, method: .post, success: success, failure: failure)
    }
}
